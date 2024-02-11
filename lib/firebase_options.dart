// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDBNNLkCMNe6iy75wGeEQcqQk1yQ_4t6os',
    appId: '1:1080923951459:web:d91551a3ec75ff95704356',
    messagingSenderId: '1080923951459',
    projectId: 'rentalapp-70515',
    authDomain: 'rentalapp-70515.firebaseapp.com',
    storageBucket: 'rentalapp-70515.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuQZbKf0HP4wfl8zshzbai3kzu_jVin2A',
    appId: '1:1080923951459:android:8b96abae93defb8b704356',
    messagingSenderId: '1080923951459',
    projectId: 'rentalapp-70515',
    storageBucket: 'rentalapp-70515.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApnHUMcCjCOGiQ2otJdtqrQ7AlJd-5_kA',
    appId: '1:1080923951459:ios:d97a003ac5f1c1a3704356',
    messagingSenderId: '1080923951459',
    projectId: 'rentalapp-70515',
    storageBucket: 'rentalapp-70515.appspot.com',
    iosBundleId: 'com.example.rentalApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyApnHUMcCjCOGiQ2otJdtqrQ7AlJd-5_kA',
    appId: '1:1080923951459:ios:d38935dda1da7883704356',
    messagingSenderId: '1080923951459',
    projectId: 'rentalapp-70515',
    storageBucket: 'rentalapp-70515.appspot.com',
    iosBundleId: 'com.example.rentalApp.RunnerTests',
  );
}