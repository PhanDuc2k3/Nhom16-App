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
    apiKey: 'AIzaSyCuQSNJRJChWz2tRdP6tEASa0SsmY5-z44',
    appId: '1:609055781862:web:16526c378631f21b185c27',
    messagingSenderId: '609055781862',
    projectId: 'signin-9d6e3',
    authDomain: 'signin-9d6e3.firebaseapp.com',
    storageBucket: 'signin-9d6e3.appspot.com',
    measurementId: 'G-5ZKNEEH309',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAy80TA8xWHHOwZ-0ErC5-IVnGh5Ez_p68',
    appId: '1:609055781862:android:f72237d0dc63cfa8185c27',
    messagingSenderId: '609055781862',
    projectId: 'signin-9d6e3',
    storageBucket: 'signin-9d6e3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjX-KTg8RcHDEzBJtr25h1OrhsL0jzSXc',
    appId: '1:609055781862:ios:d4cb95f075dff7be185c27',
    messagingSenderId: '609055781862',
    projectId: 'signin-9d6e3',
    storageBucket: 'signin-9d6e3.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjX-KTg8RcHDEzBJtr25h1OrhsL0jzSXc',
    appId: '1:609055781862:ios:d4cb95f075dff7be185c27',
    messagingSenderId: '609055781862',
    projectId: 'signin-9d6e3',
    storageBucket: 'signin-9d6e3.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
