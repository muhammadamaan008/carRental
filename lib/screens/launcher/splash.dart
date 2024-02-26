import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/utils/routes.dart';
import 'package:rental_app/widgets/app_bar.dart';
import 'package:rental_app/widgets/text_button.dart';
import 'package:sizer/sizer.dart';

import '../auth/auth_view_model.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late AuthModel authModel;

  @override
  void initState(){
    super.initState();
    authModel = Provider.of<AuthModel>(context, listen: false);
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        initialiseAndNavigate();
      } else {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(Routes.login);
      }
    });
  }

  void initialiseAndNavigate() async {
    await authModel.authoriseBuyer();
    await authModel.getCredentials();
    Get.offNamed(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    // authModel.checkLoginStatus();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(
        title: 'Cardez',
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: 90.w,
            height: 50.h,
            child: Image.asset(
              'assets/images/splash_car.png',
              width: 100.w,
            ),
          ),
          SizedBox(
            width: 100.w,
            height: 37.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF434144),
                            borderRadius: BorderRadius.circular(5.sp)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5.h, horizontal: 3.5.w),
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF434144),
                            borderRadius: BorderRadius.circular(5.sp)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5.h, horizontal: 3.5.w),
                          child: Text(
                            'Compare',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF434144),
                            borderRadius: BorderRadius.circular(5.sp)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5.h, horizontal: 3.5.w),
                          child: Text(
                            'Hire',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text('Find the ideal car rental for your trip!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold)),
                  Text(
                      'Get access to the best deals from global car rental companies.',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                  SizedBox(
                    width: 100.w,
                    child: CustomTextButton(
                      btnText: "Get Started",
                      onPressed: () {
                        Get.offNamed(Routes.login);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
