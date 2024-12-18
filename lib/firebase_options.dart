// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBSWuMHOhAe5YoDuWKrtKkY_xA-zZ455mo',
    appId: '1:864939742386:web:eb884fdfd6bf83929ca5ab',
    messagingSenderId: '864939742386',
    projectId: 'recipe-flutter-app-3008e',
    authDomain: 'recipe-flutter-app-3008e.firebaseapp.com',
    storageBucket: 'recipe-flutter-app-3008e.appspot.com',
    measurementId: 'G-9HBSRHS4NC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjPGN-vROuy1eXdWJNU1Kv6FTQ8pVpoXs',
    appId: '1:864939742386:android:a2fbc4a9ad34cdb79ca5ab',
    messagingSenderId: '864939742386',
    projectId: 'recipe-flutter-app-3008e',
    storageBucket: 'recipe-flutter-app-3008e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuTwpV0bh50zZ63GOL4Mljom2NajLHuYY',
    appId: '1:864939742386:ios:bd42ea203d5c57079ca5ab',
    messagingSenderId: '864939742386',
    projectId: 'recipe-flutter-app-3008e',
    storageBucket: 'recipe-flutter-app-3008e.appspot.com',
    iosBundleId: 'com.example.messManagementSystem',
  );

}