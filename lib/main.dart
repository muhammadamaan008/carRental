import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:rental_app/screens/splash.dart';
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
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const Splash(), transition: Transition.zoom),
          // GetPage(name: '/second', page: () => Second()),
          // GetPage(
          //   name: '/third',
          //   page: () => Third(),
          //   transition: Transition.zoom  
          // ),
        ],
        ),
      );
    });
  }
}