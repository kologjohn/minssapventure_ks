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
    apiKey: 'AIzaSyDnJWvheU8ioNnY6RtLqdGuhJXb_CvWbyI',
    appId: '1:157787041363:web:c62c6870884188e0e160a6',
    messagingSenderId: '157787041363',
    projectId: 'minsapventures',
    authDomain: 'minsapventures.firebaseapp.com',
    storageBucket: 'minsapventures.appspot.com',
    measurementId: 'G-YQXX6RBCYB',

  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANnNGpYXD994wao2nei666IF6w-bf1hZQ',
    appId: '1:157787041363:android:757f023b0f33adf8e160a6',
    messagingSenderId: '157787041363',
    projectId: 'minsapventures',
    storageBucket: 'minsapventures.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeYWuX8pcfn0kLzGdc-gpBjbi9Rq_26cw',
    appId: '1:157787041363:ios:fafe3a237e1c1b6ae160a6',
    messagingSenderId: '157787041363',
    projectId: 'minsapventures',
    storageBucket: 'minsapventures.appspot.com',
    iosBundleId: 'com.kologsoft.minssappventures',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeYWuX8pcfn0kLzGdc-gpBjbi9Rq_26cw',
    appId: '1:157787041363:ios:fafe3a237e1c1b6ae160a6',
    messagingSenderId: '157787041363',
    projectId: 'minsapventures',
    storageBucket: 'minsapventures.appspot.com',
    iosBundleId: 'com.kologsoft.minssappventures',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC3CtF-E2ajbmiH4Rgriv9tv2zginpKhg4',
    appId: '1:157787041363:web:d0850ca0ed70621ae160a6',
    messagingSenderId: '157787041363',
    projectId: 'minsapventures',
    authDomain: 'minsapventures.firebaseapp.com',
    storageBucket: 'minsapventures.appspot.com',
    measurementId: 'G-PF1BBGXYMT',
  );
}
