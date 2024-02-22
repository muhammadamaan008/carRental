import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/screens/car_details.dart';
import 'package:rental_app/screens/profile/edit_profile.dart';
import 'package:rental_app/screens/home/home.dart';
import 'package:rental_app/screens/profile/privacy.dart';
import 'package:rental_app/screens/profile/terms_and_conditions.dart';
import 'package:rental_app/screens/post/ad_view_model.dart';
import 'package:rental_app/screens/auth/auth_view_model.dart';
import 'package:rental_app/screens/auth/forgot_password_view.dart';
import 'package:rental_app/screens/auth/login_view.dart';
import 'package:rental_app/screens/auth/sign_up_view.dart';
import 'package:rental_app/screens/launcher/splash.dart';
import 'package:rental_app/utils/routes.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthModel()),
      ChangeNotifierProvider(create: (context) => AdModel()),
    ],
    child: const MyApp(),
  ));
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
          GetPage(name: Routes.home, page: () => const Home(), transition: Transition.zoom),
          GetPage(name: Routes.termsAndCondition, page: () => const TermsAndConditions(), transition: Transition.zoom),
          GetPage(name: Routes.privacy, page: () => const Privacy(), transition: Transition.zoom),
          GetPage(name: Routes.editProfile, page: () => const EditProfile(), transition: Transition.zoom),
          GetPage(name: Routes.carDetails, page: () => const CarDetails(), transition: Transition.zoom),
        ],
        ),
      );
    });
  }
}