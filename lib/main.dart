import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/service/auth_view_model.dart';
import 'package:rental_app/screens/auth/forgot_password_view.dart';
import 'package:rental_app/screens/auth/login_view.dart';
import 'package:rental_app/screens/auth/sign_up_view.dart';
import 'package:rental_app/screens/buyer/buyer_home_view.dart';
import 'package:rental_app/screens/launcher/splash.dart';
import 'package:rental_app/screens/seller/seller_home_view.dart';
import 'package:rental_app/utils/routes.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
  //   late AuthModel authModel = Provider.of<AuthModel>(context, listen: false);

  // void setInitialRoute (){
    
  // }
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
          GetPage(name: Routes.sellerHomeView, page: () => const SellerHomeView(), transition: Transition.zoom),
          GetPage(name: Routes.buyerHomeView, page: () => const BuyerHomeView(), transition: Transition.zoom),
        ],
        ),
      );
    });
  }
}