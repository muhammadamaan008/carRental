import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rental_app/utils/constants.dart';

class CustomSnackBar{
  
  static void showSnackBar(String title, String description){
    Get.snackbar(title, description,
    colorText: Colors.black,
    backgroundColor: AppConstants.mainColor);
  }

  static void commonSnackBar(){
    Get.snackbar('Error', 'Something went wrong.',
    colorText: Colors.black,
    backgroundColor: AppConstants.mainColor);
  }
}