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
import 'package:rental_app/models/list_item_model.dart';
import 'package:rental_app/screens/auth/auth_view_model.dart';
import 'package:rental_app/service/snack_bar.dart';
import 'package:rental_app/utils/constants.dart';
import 'package:rental_app/utils/routes.dart';

class AdModel extends ChangeNotifier {
  List<File>? images = [];
  final picker = ImagePicker();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool loading = false;
  List<Ad> adData = [];
  List<ListItemModel> itemData = [];
  List<Ad> originalAdData = [];

  // POST AD
  Future<void> uploadAdToDatabase(Ad rentalAd) async {
    var adCollection = firebaseFirestore.collection('adCollection');
    try {
      loading = true;
      notifyListeners();
      String uniqueId = rentalAd.uId + getRandomString();

      if (images != null) {
        await uploadAdImages(uniqueId);
      }

      await adCollection.doc(uniqueId).set({
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

 Future<void> getAllAdData() async {
  adData.clear();
  originalAdData.clear();
  AuthModel authModel = AuthModel();

  await authModel.authoriseBuyer();

  var ref = firebaseFirestore.collection('adCollection');
  try {
    await ref.get().then((querySnapshot) async {
      for (var result in querySnapshot.docs) {
        var data = result.data();
        bool isUserBuyer = authModel.isUserBuyer;

        if (isUserBuyer == true) {
          bool favAd = itemData.any((item) => item.adId == data['adId']);
          var ad = Ad(
            adId: data['adId'],
            make: data['make'],
            model: data['model'],
            year: data['year'],
            transmission: data['transmission'],
            fuelType: data['fuelType'],
            timeStamp: data['timeStamp'].toDate(),
            uId: data['userId'],
            rates: data['rates'],
            location: data['location'],
            isFav: favAd,
          );
          List<String> imageURLs = await getImagesForAdId(ad.adId!, ad.uId);
          ad.images = imageURLs;
          adData.add(ad);
          originalAdData.add(Ad.fromMap(ad.toMap()));
        } else {
          if (auth.currentUser!.uid == data['userId']) {
            var ad = Ad(
              adId: data['adId'],
              make: data['make'],
              model: data['model'],
              year: data['year'],
              transmission: data['transmission'],
              fuelType: data['fuelType'],
              timeStamp: data['timeStamp'].toDate(),
              uId: data['userId'],
              rates: data['rates'],
              location: data['location'],
            );
            List<String> imageURLs = await getImagesForAdId(ad.adId!, ad.uId);
            ad.images = imageURLs;
            adData.add(ad);
            originalAdData.add(Ad.fromMap(ad.toMap()));
          }
        }
      }
    });
  } catch (error) {
    debugPrint('Error fetching ad data: $error');
  }
  notifyListeners();
}



  // GET IMAGES
  Future<List<String>> getImagesForAdId(String adId, String uId) async {
    List<String> imageURLs = [];
    try {
      Reference storageReference =
          firebaseStorage.ref().child("adPictures/$uId/$adId");

      ListResult result = await storageReference.listAll();

      await Future.forEach(result.items, (Reference ref) async {
        String downloadURL = await ref.getDownloadURL();
        imageURLs.add(downloadURL);
      });
    } catch (error) {
      debugPrint('Error fetching images for adId $adId: $error');
    }
    return imageURLs;
  }

  // FAVOURITE
  Future<void> toggleFavourite(int index) async {
    adData[index].isFav = !adData[index].isFav;
    notifyListeners();
    if (adData[index].isFav) {
      var temp = ListItemModel(
        adId: adData[index].adId!,
        rate: adData[index].rates,
        model: adData[index].model,
        buyerId: auth.currentUser!.uid,
        sellerId: adData[index].uId,
        year: adData[index].year,
        imageUrl:
            adData[index].images != null && adData[index].images!.isNotEmpty
                ? adData[index].images![0]
                : AppConstants.defaultImageUrl,
      );
      itemData.add(temp);

      await addToFavorites(temp);
      notifyListeners();
    } else {
      itemData.removeWhere((element) => element.adId == adData[index].adId);
      await removeFromFavourites(adData[index].adId!, auth.currentUser!.uid);
      notifyListeners();
    }
  }

  Future<void> addToFavorites(ListItemModel item) async {
    try {
      if (auth.currentUser != null) {
        String userId = auth.currentUser!.uid;

        await firebaseFirestore
            .collection('favoriteItems')
            .doc(userId + getRandomString())
            .set({
          "adId": item.adId,
          "buyerId": item.buyerId,
          "sellerId": item.sellerId,
          "rate": item.rate,
          "imageUrl": item.imageUrl,
          "model": item.model,
          "year": item.year,
        });
      }
    } catch (error) {
      debugPrint('Error adding to favorites: $error');
    }
  }

  Future<void> removeFromFavourites(String adId, String buyerId) async {
    try {
      var removeFavItem = firebaseFirestore
          .collection('favoriteItems')
          .where('adId', isEqualTo: adId)
          .where('buyerId', isEqualTo: buyerId);

      await removeFavItem.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });

      itemData.removeWhere((element) => element.adId == adId);
      for (var ad in adData) {
        if (ad.adId == adId) {
          ad.isFav = false;
        }
      }
      notifyListeners();
      Get.toNamed(Routes.home);
    } catch (error) {
      debugPrint('Error adding to favorites: $error');
    }
  }

  Future<void> getAdsFromFavourites() async {
    var favRef = firebaseFirestore.collection('favoriteItems');
    try {
      itemData.clear();
      var querySnapshot = await favRef.get();
      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        var buyerId = data['buyerId'];
        if (buyerId == auth.currentUser!.uid) {
          var favAds = ListItemModel(
              adId: data['adId'],
              rate: data['rate'],
              model: data['model'],
              year: data['year'],
              buyerId: auth.currentUser!.uid,
              sellerId: data['sellerId'],
              imageUrl: data['imageUrl']);
          itemData.add(favAds);
          notifyListeners();
        }
      }
    } catch (error) {
      debugPrint('Error fetching ad data: $error');
    }
  }

  Future<void> deleteAdById(String adId) async {
    loading = true;
    notifyListeners();
    try {
      var deletePost = firebaseFirestore
          .collection('adCollection')
          .where('adId', isEqualTo: adId);

      var deletePostFromFav = firebaseFirestore
          .collection('favoriteItems')
          .where('adId', isEqualTo: adId);

      await deletePost.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });

      await deletePostFromFav.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });

      itemData.removeWhere((element) => element.adId == adId);
      adData.removeWhere((element) => element.adId == adId);
      loading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar('Attention', 'Ad deleted successfully');
      Get.toNamed(Routes.home);
    } catch (error) {
      loading = false;
      notifyListeners();
      debugPrint('Error adding to favorites: $error');
    }
  }

  void moveToDetailScreen(String adId) {
    for (var ad in adData) {
      if (ad.adId == adId) {
        Get.toNamed(Routes.carDetails, arguments: ad);
        break;
      }
    }
    return;
  }

  // SEARCH
void searchPerson(String charEntered) {
  List<Ad> filteredList = [];

  if (charEntered.isEmpty) {
    filteredList = originalAdData;
  } else {
    filteredList = originalAdData.where((ad) {
      final lowerCaseEntered = charEntered.toLowerCase();
      final makeContains = ad.make.toLowerCase().contains(lowerCaseEntered);
      final modelContains = ad.model.toLowerCase().contains(lowerCaseEntered);
      final isNumeric = double.tryParse(charEntered) != null;
      final numberContains = ad.make.contains(charEntered) || ad.model.contains(charEntered);
      return makeContains || modelContains || (isNumeric && numberContains);
    }).toList();
  }

  adData = filteredList;
  notifyListeners();
}


  // Validation Functions
  String getRandomString() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(10, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  String? rateValidator(String? rate) {
    RegExp nameRegExp = RegExp('[A-Za-z]');
    if (rate == null || rate.isEmpty) {
      return 'Rate field cannot be empty';
    } else if (rate.isNotEmpty && rate.contains(nameRegExp)) {
      return 'Rate cannot have aplhabets';
    }
    return null;
  }

  String? yearValidator(String? year) {
    if (year == null || year.isEmpty) {
      return 'Year cannot be empty';
    }
    return null;
  }

  String? locationValidator(String? location) {
    if (location == null || location.isEmpty) {
      return 'Location cannot be empty';
    }
    return null;
  }

  String? modelValidator(String? model) {
    if (model == null || model.isEmpty) {
      return 'Model field cannot be empty';
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
