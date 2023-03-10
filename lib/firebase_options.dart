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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBiJwR2bdIhY-rtGDMm_zubzdJKOs0VDbU',
    appId: '1:346212515172:web:29489ad71818b3f2388e71',
    messagingSenderId: '346212515172',
    projectId: 'femunity-b818c',
    authDomain: 'femunity-b818c.firebaseapp.com',
    storageBucket: 'femunity-b818c.appspot.com',
    measurementId: 'G-3BWZWH5N16',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA58_C0bCdRSPLzOY7fBvO_XwpJaMMvW6I',
    appId: '1:346212515172:android:f7f19cad80edc7f0388e71',
    messagingSenderId: '346212515172',
    projectId: 'femunity-b818c',
    storageBucket: 'femunity-b818c.appspot.com',
  );
}
