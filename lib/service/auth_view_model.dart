import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rental_app/service/snack_bar.dart';
import 'package:rental_app/utils/routes.dart';

class AuthModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool loading = false;
  late bool isUserBuyer;
  late String? displayName, email, photoUrl;

  AuthModel() {
    authoriseBuyer();
    getCredentials();
  }

  // AUTHORISATION
  Future<void> authoriseBuyer() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: _auth.currentUser!.uid.toString())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userType = querySnapshot.docs[0]['userType'];
        isUserBuyer = userType == 'buyer';
        return;
      } else {
        CustomSnackBar.showSnackBar('Error',
            'No documents found with userId: ${_auth.currentUser!.uid.toString()}');
        isUserBuyer = false;
        return;
      }
    } catch (error) {
      CustomSnackBar.commonSnackBar();
      isUserBuyer = false;
      return;
    }
  }

  // SIGN UP
  Future<void> createUserWithEmailAndPassword(
      String email, String password, String userType, String name) async {
    loading = true;
    notifyListeners();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser!.updateDisplayName(name);
      await storeUserInFireStore(
          _auth.currentUser!.uid.toString(), userType, name, email);
    } catch (error) {
      loading = false;
      notifyListeners();
      CustomSnackBar.commonSnackBar();
    }
  }

  Future<void> storeUserInFireStore(
      String userId, String userType, String name, String email) async {
    try {
      await firebaseFirestore.collection('users').doc(userId).set({
        "userId": userId,
        "userType": userType,
        "email": email,
        "name": name
      });
      loading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          "Account Created!", "Please login to avail services");
      Get.offNamed(Routes.login);
    } catch (error) {
      loading = false;
      CustomSnackBar.showSnackBar("Error", error.toString());
    }
  }

  // LOGIN
  Future<void> loginUser(String email, String password) async {
    loading = true;
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      loading = false;
      notifyListeners();
      Get.offAllNamed(Routes.home);
    } catch (error) {
      loading = false;
      notifyListeners();
      CustomSnackBar.commonSnackBar();
    }
  }

  // Forgot Password
  Future<void> sendEmail(String email) async {
    try {
      bool userExists = await isUserExists(email);

      if (userExists) {
        await _auth.sendPasswordResetEmail(email: email);
        CustomSnackBar.showSnackBar(
            "Email Sent", "Reset Password & Login Again");
        Get.offNamed(Routes.login);
      } else {
        CustomSnackBar.showSnackBar(
            "Error", "User with this email does not exist.");
      }
    } catch (error) {
      CustomSnackBar.commonSnackBar();
    }
  }

  Future<bool> isUserExists(String email) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      CustomSnackBar.commonSnackBar();
      return false;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.login);
  }

  // Get Credentials
  Future<void> getCredentials() async {
    displayName = _auth.currentUser!.displayName;
    email = _auth.currentUser!.email;
    photoUrl = _auth.currentUser?.photoURL;
  }

  // REDIRECT TO HOME IF USER ALREADY LOGGED IN
  Future<void> checkLoginStatus() async {
    try {
      await authoriseBuyer(); // Wait for authorisation
      if (_auth.currentUser != null) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.login);
      }
    } catch (error) {
      CustomSnackBar.commonSnackBar();
    }
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      loading = true;
      notifyListeners();

      // Generate a unique filename using the user's UID
      String fileName = _auth.currentUser!.uid;
      Reference ref =
          FirebaseStorage.instance.ref().child('profile_images/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);

      // Wait for the upload task to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      loading = false;
      notifyListeners();
      CustomSnackBar.commonSnackBar();
      return null;
    }
  }

  // EDIT PROFILE
  Future<void> updateUserCredentials(
      {required String email, required String name, String? photoURL}) async {
    loading = true;
    notifyListeners();

    try {
      await _auth.currentUser?.updatePhotoURL(photoUrl);
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.verifyBeforeUpdateEmail(email);

      var userQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: _auth.currentUser!.uid)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        await firebaseFirestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({"email": email, "name": name});
        loading = false;
        notifyListeners();

        CustomSnackBar.showSnackBar("Updated", "Sucessfully Updated!");
        Get.offNamed(Routes.home);
      }
    } catch (error) {
      loading = false;
      notifyListeners();
      CustomSnackBar.commonSnackBar();
      if (error is FirebaseAuthException &&
          error.code == 'auth/id-token-expired') {
        CustomSnackBar.showSnackBar('Error',
            'Login session expired! You need to login again if want to update.');
      }
      return;
    }
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email field cannot be empty';
    } else if (email.isNotEmpty && !EmailValidator.validate(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? nameValidator(String? name) {
    RegExp nameRegExp = RegExp('[0-9]');
    if (name == null || name.isEmpty) {
      return 'Name field cannot be empty';
    } else if (name.isNotEmpty && name.contains(nameRegExp)) {
      return 'Name cannot have numbers';
    }
    return null;
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password field cannot be empty';
    } else if (password.isNotEmpty && password.length < 8) {
      return 'Password cannot be less than 8 characters';
    }
    return null;
  }
}
