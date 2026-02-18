import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform, defaultTargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConfig {
  /// Creates a [FirebaseOptions] object based on the current platform.
  ///
  /// This method reads the necessary API keys from the .env file and
  /// should only be called AFTER `dotenv.load()` has been executed.
  static FirebaseOptions createOptions() {
    // 1. Determine the current platform
    if (kIsWeb) {
      return _createWebOptions();
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _createAndroidOptions();
      case TargetPlatform.iOS:
        return _createIosOptions();
      case TargetPlatform.macOS:
        return _createMacOsOptions();
      case TargetPlatform.windows:
        return _createWindowsOptions();
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  /// 2. Create private helper methods for each platform

  // --- Android Configuration ---
  static FirebaseOptions _createAndroidOptions() {
    final apiKey = _getApiKey('FIREBASE_API_KEY_ANDROID');
    return FirebaseOptions(
      apiKey: apiKey,
      appId: '1:755701620617:android:f4c6aa3c8164be95c38b58',
      messagingSenderId: '755701620617',
      projectId: 'fir-b8753',
      storageBucket: 'fir-b8753.firebasestorage.app',
    );
  }

  // --- iOS Configuration ---
  static FirebaseOptions _createIosOptions() {
    final apiKey = _getApiKey('FIREBASE_API_KEY_IOS');
    return FirebaseOptions(
      apiKey: apiKey,
      appId: '1:755701620617:ios:52b4f5bda3039d28c38b58',
      messagingSenderId: '755701620617',
      projectId: 'fir-b8753',
      storageBucket: 'fir-b8753.firebasestorage.app',
      iosBundleId: 'com.example.firebaseNotification', // Ensure this matches your iOS Bundle ID
    );
  }

  // --- Web Configuration ---
  static FirebaseOptions _createWebOptions() {
    final apiKey = _getApiKey('FIREBASE_API_KEY_WEB');
    return FirebaseOptions(
      apiKey: apiKey,
      appId: '1:755701620617:web:169bfaad009bc254c38b58',
      messagingSenderId: '755701620617',
      projectId: 'fir-b8753',
      authDomain: 'fir-b8753.firebaseapp.com', // Web needs authDomain
      storageBucket: 'fir-b8753.firebasestorage.app',
      measurementId: 'G-FD2EFVMYXB', // Web may need measurementId
    );
  }

  // --- macOS Configuration ---
  static FirebaseOptions _createMacOsOptions() {
    final apiKey = _getApiKey('FIREBASE_API_KEY_MACOS');
    return FirebaseOptions(
      apiKey: apiKey,
      appId: '1:755701620617:ios:52b4f5bda3039d28c38b58', // Often shares appId with iOS
      messagingSenderId: '755701620617',
      projectId: 'fir-b8753',
      storageBucket: 'fir-b8753.firebasestorage.app',
      iosBundleId: 'com.example.firebaseNotification', // Ensure this matches your macOS Bundle ID
    );
  }

  // --- Windows Configuration ---
  static FirebaseOptions _createWindowsOptions() {
    final apiKey = _getApiKey('FIREBASE_API_KEY_WINDOWS');
    return FirebaseOptions(
      apiKey: apiKey,
      appId: '1:755701620617:web:7158e8f9b01d556cc38b58',
      messagingSenderId: '755701620617',
      projectId: 'fir-b8753',
      storageBucket: 'fir-b8753.firebasestorage.app',
      iosBundleId: 'com.example.firebaseNotification', // Ensure this matches your macOS Bundle ID
    );
  }


  /// 3. Create a reusable helper to get API keys and fail-fast
  static String _getApiKey(String keyName) {
    final apiKey = dotenv.env[keyName];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('$keyName not found in .env file or is empty');
    }
    return apiKey;
  }
}
