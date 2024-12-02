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
    apiKey: 'AIzaSyCEhdkosSL8j3pNyb0LL8VVoneTjq-QVuU',
    appId: '1:352232158982:web:0e879caff419d2f25a1087',
    messagingSenderId: '352232158982',
    projectId: 'notification-f5de6',
    authDomain: 'notification-f5de6.firebaseapp.com',
    storageBucket: 'notification-f5de6.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEcFrxsY7_QA723ZdsmQ4y1yeP7D4IadU',
    appId: '1:352232158982:android:05c3e974d50f49f35a1087',
    messagingSenderId: '352232158982',
    projectId: 'notification-f5de6',
    storageBucket: 'notification-f5de6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAN_491od8PVyLUMQuHxyxd3ZA6VVnncoQ',
    appId: '1:352232158982:ios:a0394e7ba2807b2b5a1087',
    messagingSenderId: '352232158982',
    projectId: 'notification-f5de6',
    storageBucket: 'notification-f5de6.firebasestorage.app',
    iosBundleId: 'com.example.driverApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAN_491od8PVyLUMQuHxyxd3ZA6VVnncoQ',
    appId: '1:352232158982:ios:a0394e7ba2807b2b5a1087',
    messagingSenderId: '352232158982',
    projectId: 'notification-f5de6',
    storageBucket: 'notification-f5de6.firebasestorage.app',
    iosBundleId: 'com.example.driverApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCEhdkosSL8j3pNyb0LL8VVoneTjq-QVuU',
    appId: '1:352232158982:web:a7f8952dfcd2f70b5a1087',
    messagingSenderId: '352232158982',
    projectId: 'notification-f5de6',
    authDomain: 'notification-f5de6.firebaseapp.com',
    storageBucket: 'notification-f5de6.firebasestorage.app',
  );
}