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
  late String? userDisplayName, userEmail, userPhotoUrl;

  bool isUserAuthenticated() {
    // Access the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    // Return true if user is not null (i.e., user is authenticated), otherwise return false
    return user != null;
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
        if (userType == 'buyer') {
          isUserBuyer = true;
          notifyListeners();
        } else {
          isUserBuyer = false;
          notifyListeners();
        }
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
      print('achaaaaaaaa');
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('okkkkkkkkkkk');
      await _auth.currentUser?.updateDisplayName(name);
      print('wewwwwwwwwwwwwwwwwwww');
      await storeUserInFireStore(
          _auth.currentUser!.uid.toString(), userType, name, email);
      print('555215220056333.');
      loading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          "Account Created!", "Please login to avail services");
      Get.toNamed(Routes.login);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CustomSnackBar.showSnackBar('Error', 'Email Already in use');
        loading = false;
        notifyListeners();
      } else if (e.code == 'network-request-failed') {
        CustomSnackBar.showSnackBar('Error', 'Network error occured');
        loading = false;
        notifyListeners();
      } else if (e.code == 'operation-not-allowed') {
        CustomSnackBar.showSnackBar('Error', 'Operation not allowed');
        loading = false;
        notifyListeners();
      } else {
        CustomSnackBar.commonSnackBar();
        loading = false;
        notifyListeners();
      }
    } catch (error) {
      CustomSnackBar.commonSnackBar();
      loading = false;
      notifyListeners();
    }
  }

  Future<void> storeUserInFireStore(
      String userId, String userType, String name, String email) async {
    try {
      print('doneeeeeeeeeeeeeeee');
      await firebaseFirestore.collection('users').doc(userId).set({
        "userId": userId,
        "userType": userType,
        "email": email,
        "name": name
      });
      print('dokieeeeeeeeeeeee');
    } catch (error) {
      loading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar("Error", error.toString());
      debugPrint(error.toString());
    }
  }

  // LOGIN
  Future<void> loginUser(String email, String password) async {
    loading = true;
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await getCredentials();
      await authoriseBuyer();
      loading = false;
      notifyListeners();
      if (isUserBuyer) {
        CustomSnackBar.showSnackBar('Logged In', 'Welcome to buyer dashboard');
      } else {
        CustomSnackBar.showSnackBar('Logged In', 'Welcome to seller dashboard');
      }
      Get.offNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        CustomSnackBar.showSnackBar('Error', 'Invalid Credentials');
        loading = false;
        notifyListeners();
      } else if (e.code == 'too-many-requests') {
        CustomSnackBar.showSnackBar(
            'Error', 'Too Many Request. Try again later.');
        loading = false;
        notifyListeners();
      } else if (e.code == 'network-request-failed') {
        CustomSnackBar.showSnackBar('Error', 'Network error occured');
        loading = false;
        notifyListeners();
      } else if (e.code == 'user-disabled') {
        CustomSnackBar.showSnackBar(
            'Error', 'Temporarily blocked. Try again later.');
        loading = false;
        notifyListeners();
      } else if (e.code == 'user-not-found') {
        CustomSnackBar.showSnackBar('Error', 'User not found');
        loading = false;
        notifyListeners();
      } else {
        CustomSnackBar.commonSnackBar();
        loading = false;
        notifyListeners();
      }
    } catch (error) {
      CustomSnackBar.commonSnackBar();
      loading = false;
      notifyListeners();
    }
  }

  // Forgot Password
  Future<void> sendEmail(String email) async {
    try {
      loading = true;
      notifyListeners();
      bool userExists = await isUserExists(email);
      if (userExists) {
        await _auth.sendPasswordResetEmail(email: email);
        CustomSnackBar.showSnackBar(
            "Email Sent", "Reset Password & Login Again");
        loading = false;
        notifyListeners();
        Get.offNamed(Routes.login);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
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
    userDisplayName = _auth.currentUser!.displayName;
    userEmail = _auth.currentUser!.email;
    userPhotoUrl = _auth.currentUser?.photoURL;
  }

  // REDIRECT TO HOME IF USER ALREADY LOGGED IN
  // Future<void> checkLoginStatus() async {
  //   try {
  //     await authoriseBuyer();
  //     if (_auth.currentUser != null) {
  //       Get.offAllNamed(Routes.home);
  //     } else {
  //       Get.offAllNamed(Routes.login);
  //     }
  //   } catch (error) {
  //     CustomSnackBar.commonSnackBar();
  //   }
  // }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      loading = true;
      notifyListeners();

      String fileName = _auth.currentUser!.uid;
      Reference ref =
          FirebaseStorage.instance.ref().child('profile_images/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);

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
      await _auth.currentUser?.updatePhotoURL(photoURL);
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

        userPhotoUrl = photoURL;
        userDisplayName = name;
        userEmail = email;
        loading = false;
        notifyListeners();

        CustomSnackBar.showSnackBar("Updated", "Sucessfully Updated!");
        Get.offNamed(Routes.home);
      }
    } on FirebaseAuthException catch (error) {
      debugPrint(error.toString());
      if (error.code == 'requires-recent-login') {
        CustomSnackBar.showSnackBar('Updated', 'Login again to see changes.');
        loading = false;
        notifyListeners();
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      debugPrint(e.toString());
      CustomSnackBar.commonSnackBar();
      loading = false;
      notifyListeners();
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
