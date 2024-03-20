import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCNdaYMcBvdqB7MKDxB6P7VqODhqbv103Y',
    appId: '1:684336849582:web:36b803b864a58b5179033f',
    messagingSenderId: '684336849582',
    projectId: 'get-code-c3aee',
    authDomain: 'get-code-c3aee.firebaseapp.com',
    storageBucket: 'get-code-c3aee.appspot.com',
    measurementId: 'G-FHLKX7GH8P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkYjDaNYKOQcgMs61CWFfDduxuZ8neklo',
    appId: '1:684336849582:android:7cec12783ba845dd79033f',
    messagingSenderId: '684336849582',
    projectId: 'get-code-c3aee',
    storageBucket: 'get-code-c3aee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXnM-sL8NVK-u3ScHq8MwDDDwLKZ0J4CE',
    appId: '1:684336849582:ios:5b2a86c434a5692f79033f',
    messagingSenderId: '684336849582',
    projectId: 'get-code-c3aee',
    storageBucket: 'get-code-c3aee.appspot.com',
    iosBundleId: 'com.example.startProject1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXnM-sL8NVK-u3ScHq8MwDDDwLKZ0J4CE',
    appId: '1:684336849582:ios:8c8614e39533883079033f',
    messagingSenderId: '684336849582',
    projectId: 'get-code-c3aee',
    storageBucket: 'get-code-c3aee.appspot.com',
    iosBundleId: 'com.example.startProject1.RunnerTests',
  );
}
