// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// // "₹"
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
    apiKey: 'AIzaSyCtUEBK30y3a-8nfRvIdt3_1yAymbuPqkQ',
    appId: '1:224204898704:web:e309c32c600b294b4c3315',
    messagingSenderId: '224204898704',
    projectId: 'cloathing',
    authDomain: 'cloathing.firebaseapp.com',
    databaseURL:
        'https://cloathing-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cloathing.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcK6KPRZ9IJH0Uxgh5-2mF9OyTC-JXFoQ',
    appId: '1:224204898704:android:3d59163c53ecc8784c3315',
    messagingSenderId: '224204898704',
    projectId: 'cloathing',
    databaseURL:
        'https://cloathing-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cloathing.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7Agno4CA1X33G82-9Xu_bnWmmtbYKKbQ',
    appId: '1:224204898704:ios:94bc119dd938c76e4c3315',
    messagingSenderId: '224204898704',
    projectId: 'cloathing',
    databaseURL:
        'https://cloathing-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cloathing.appspot.com',
    iosClientId:
        '224204898704-c0mdge1jpr4ta75nk6d5jbv3kkscmdlr.apps.googleusercontent.com',
    iosBundleId: 'com.example.clothingApp',
  );
}
