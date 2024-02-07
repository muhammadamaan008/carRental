import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rental_app/service/snackbar.dart';
import 'package:rental_app/utils/routes.dart';

class AuthModel extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool loading = false;

  //Sign Up
  Future<void> createUserWithEmailAndPassword(
      String email, String password, String userType, String name) async {
    loading = true;
    notifyListeners();

    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await storeUserInFireStore(
          auth.currentUser!.uid.toString(), userType, name, email);
    }).onError((error, stackTrace) {
      loading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar("Error", error.toString());
    });
  }

  Future<void> storeUserInFireStore(
      String userId, String userType, String name, String email) async {
    await firebaseFirestore.collection('users').doc(userId).set({
      "userId": userId,
      "userType": userType,
      "email": email,
      "name": name
    }).then((value) {
      loading = false;
      notifyListeners();

      CustomSnackBar.showSnackBar(
          "Account Created!", "Please login to avail services");
      Get.offNamed(Routes.login);
    }).onError((error, stackTrace) {
      loading = false;
      CustomSnackBar.showSnackBar("Error", error.toString());
    });
  }

  // LOGIN
  Future<void> loginUser(String email, String password) async {
    loading = true;
    notifyListeners();

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      bool buyerExist = await isBuyer(auth.currentUser!.uid.toString());
      loading = false;
      notifyListeners();

      if (buyerExist) {
        Get.toNamed(Routes.buyerHomeView);
      } else {
        Get.toNamed(Routes.sellerHomeView);
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        // Handle FirebaseAuthException
        switch (error.code) {
          case 'user-not-found':
            // Handle user-not-found error
            print('No user found for that email.');
            break;
          case 'wrong-password':
            // Handle wrong-password error
            print('Wrong password provided for that user.');
            break;
          case 'user-disabled':
            // Handle user-disabled error
            print('User has been disabled.');
            break;
          // Add more cases for other error codes as needed
          default:
            // Handle other FirebaseAuthException errors
            print('Error signing in: ${error.message}');
        }
      }
    }
  }

  Future<bool> isBuyer(String userId) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userType = querySnapshot.docs[0]['userType'];
        return userType == 'buyer';
      } else {
        CustomSnackBar.showSnackBar(
            'Error', 'No documents found with userId: $userId');
        return false;
      }
    } catch (error) {
      CustomSnackBar.showSnackBar('Error', 'Error retrieving document: $error');
      return false;
    }
  }

  // Forgot Password
  Future<void> sendEmail(String email) async {
    try {
      bool userExists = await isUserExists(email);

      if (userExists) {
        await auth.sendPasswordResetEmail(email: email);
        CustomSnackBar.showSnackBar(
            "Email Sent", "Reset Password & Login Again");
        Get.offNamed(Routes.login);
      } else {
        CustomSnackBar.showSnackBar(
            "Error", "User with this email does not exist.");
      }
    } catch (error) {
      CustomSnackBar.showSnackBar("Error", error.toString());
    }
  }

  Future<bool> isUserExists(String email) async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      return false;
    }
  }

  String? emailValidtaor(String? email) {
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

  String? passwordValidtaor(String? password) {
    if (password == null || password.isEmpty) {
      return 'Pasword field cannot be empty';
    } else if (password.isNotEmpty && password.length < 8) {
      return 'Password cannot be less than 8 characters';
    }
    return null;
  }
}
