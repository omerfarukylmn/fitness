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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC6PlPJH0NhLAlAAlxcGrdhe1RQIqBaEn8',
    appId: '1:518496717289:web:5373558fafabf485476378',
    messagingSenderId: '518496717289',
    projectId: 'basarsoft-d4b7b',
    authDomain: 'basarsoft-d4b7b.firebaseapp.com',
    storageBucket: 'basarsoft-d4b7b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwozWjW9Fmt1jR4jCucEMQztNMrtQDEIY',
    appId: '1:518496717289:android:d2857eab655116ed476378',
    messagingSenderId: '518496717289',
    projectId: 'basarsoft-d4b7b',
    storageBucket: 'basarsoft-d4b7b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7_AHrSzZIZYclDCJHdNyeGJ55oUSfeXI',
    appId: '1:518496717289:ios:66885cca275590c8476378',
    messagingSenderId: '518496717289',
    projectId: 'basarsoft-d4b7b',
    storageBucket: 'basarsoft-d4b7b.appspot.com',
    iosBundleId: 'com.example.fitness',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7_AHrSzZIZYclDCJHdNyeGJ55oUSfeXI',
    appId: '1:518496717289:ios:66885cca275590c8476378',
    messagingSenderId: '518496717289',
    projectId: 'basarsoft-d4b7b',
    storageBucket: 'basarsoft-d4b7b.appspot.com',
    iosBundleId: 'com.example.fitness',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC6PlPJH0NhLAlAAlxcGrdhe1RQIqBaEn8',
    appId: '1:518496717289:web:86cf90db7d339080476378',
    messagingSenderId: '518496717289',
    projectId: 'basarsoft-d4b7b',
    authDomain: 'basarsoft-d4b7b.firebaseapp.com',
    storageBucket: 'basarsoft-d4b7b.appspot.com',
  );
}