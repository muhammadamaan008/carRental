import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:rental_app/screens/auth/forgot_password.dart';
import 'package:rental_app/screens/auth/login.dart';
import 'package:rental_app/screens/auth/sign_up.dart';
import 'package:rental_app/screens/launcher/splash.dart';
import 'package:rental_app/utils/routes.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return SafeArea(
        child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        getPages: [
          GetPage(name: Routes.splash, page: () => const Splash(), transition: Transition.zoom),
          GetPage(name: Routes.login, page: () => const Login(), transition: Transition.zoom),
          GetPage(name: Routes.signUp, page: () => const SignUp(), transition: Transition.zoom),
          GetPage(name: Routes.forgotPassword, page: () => const ForgotPassword(), transition: Transition.zoom),
        ],
        ),
      );
    });
  }
}