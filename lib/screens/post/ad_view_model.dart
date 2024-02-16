import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_app/models/ad_model.dart';
import 'package:rental_app/service/snack_bar.dart';
import 'package:rental_app/utils/routes.dart';

class AdModel extends ChangeNotifier {
  List<File>? images = [];
  final picker = ImagePicker();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool loading = false;



  // POST AD
  Future<void> uploadAdToDatabase(Ad rentalAd) async {
    var adCollection = firebaseFirestore.collection('adCollection');
    String adId = auth.currentUser!.uid;
    try {
      loading = true;
      notifyListeners();
      String uniqueId = rentalAd.uId + getRandomString();

      if (images != null) {
        await uploadAdImages(uniqueId);
      }

      await adCollection.doc(adId).set({
        'adId': uniqueId,
        'make': rentalAd.make,
        'model': rentalAd.model,
        'year': rentalAd.year,
        'transmission': rentalAd.transmission,
        'fuelType': rentalAd.fuelType,
        'timeStamp': rentalAd.timeStamp,
        'userId': rentalAd.uId,
        'rates': rentalAd.rates,
        'location': rentalAd.location
      });
      loading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar('Hurrah', 'Ad Posted!');
      Get.offAndToNamed(Routes.home);
    } catch (error) {
      CustomSnackBar.showSnackBar(
          'Error', 'Something went wrong.Could not post ad.');
      loading = false;
      notifyListeners();
    }
  }

  Future<void> uploadAdImages(String uniqueId) async {
    try {
      loading = true;
      notifyListeners();

      images?.forEach((element) async {
        Reference storageReference = firebaseStorage.ref().child(
            "adPictures/${auth.currentUser!.uid}/$uniqueId/${getRandomString()}");
        UploadTask uploadReference = storageReference.putFile(element);
        await uploadReference;
      });
    } catch (error) {
      debugPrint(error.toString());
      loading = false;
      notifyListeners();
    }
  }

  // Validation Functions
  String getRandomString() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(10, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  String? rateValidator(String? name) {
    RegExp nameRegExp = RegExp('[A-Za-z]');
    if (name == null || name.isEmpty) {
      return 'Rate field cannot be empty';
    } else if (name.isNotEmpty && name.contains(nameRegExp)) {
      return 'Rate cannot have aplhabets';
    }
    return null;
  }

  String? yearValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Year cannot be empty';
    }
    return null;
  }

  String? modelValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name field cannot be empty';
    }
    return null;
  }

  Future<void> getImagesFromGallery() async {
    final pickedImages = await picker.pickMultiImage();
    images?.clear();
    images?.addAll(
        pickedImages.map((pickedImage) => File(pickedImage.path)).toList());
    notifyListeners();
  }
}
