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
      apiKey: "AIzaSyAhBcmGhvCA4iq9xi5ugIMHuAh3kPvDrqs",
      authDomain: "kunal-scratch.firebaseapp.com",
      projectId: "kunal-scratch",
      storageBucket: "kunal-scratch.appspot.com",
      messagingSenderId: "550614207330",
      appId: "1:550614207330:web:a46affebb49ba728b77a3b");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQ6PeqfRVwC6UMk1RUlBSMuKOWJ3ZWvRY',
    appId: '1:842728648829:android:fea85327b0e1edc3d18114',
    messagingSenderId: '842728648829',
    projectId: 'super-dash-game',
    storageBucket: 'super-dash-game.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy2jUHwXytAhOHlF0bhIelBmYnx9nYxmY',
    appId: '1:842728648829:ios:4ee20b6a9a65a426d18114',
    messagingSenderId: '842728648829',
    projectId: 'super-dash-game',
    storageBucket: 'super-dash-game.appspot.com',
    iosBundleId: 'com.example.dashRun',
  );
}
