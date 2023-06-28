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
    apiKey: 'AIzaSyCs2uJFo6f7tlZgbdxxrGMu37GBN55eyzI',
    appId: '1:1043409295320:web:f0051ba4103d81b8a884ad',
    messagingSenderId: '1043409295320',
    projectId: 'miraitracker-c0c33',
    authDomain: 'miraitracker-c0c33.firebaseapp.com',
    storageBucket: 'miraitracker-c0c33.appspot.com',
    measurementId: 'G-XYJPX8SY05',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAyeXFwDDzRlzdgRgNCAVE14ynpGgg2CYI',
    appId: '1:1043409295320:android:6f88dc3fd6d935cba884ad',
    messagingSenderId: '1043409295320',
    projectId: 'miraitracker-c0c33',
    storageBucket: 'miraitracker-c0c33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfC9gBxkCG74q5Ix34f1Bd7hUMvzpvyGg',
    appId: '1:1043409295320:ios:03ffb50b882bf319a884ad',
    messagingSenderId: '1043409295320',
    projectId: 'miraitracker-c0c33',
    storageBucket: 'miraitracker-c0c33.appspot.com',
    iosClientId: '1043409295320-s7u4jaf9p6gp5p7km21p6qtgknm281cg.apps.googleusercontent.com',
    iosBundleId: 'com.example.miraiTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfC9gBxkCG74q5Ix34f1Bd7hUMvzpvyGg',
    appId: '1:1043409295320:ios:ecf5b8621b6da7dda884ad',
    messagingSenderId: '1043409295320',
    projectId: 'miraitracker-c0c33',
    storageBucket: 'miraitracker-c0c33.appspot.com',
    iosClientId: '1043409295320-nolbo5tkevr20ubv7m3ovv2o23e6jpqm.apps.googleusercontent.com',
    iosBundleId: 'com.example.miraiTracker.RunnerTests',
  );
}
