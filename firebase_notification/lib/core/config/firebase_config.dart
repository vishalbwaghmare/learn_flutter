import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConfig {
  /// Creates a [FirebaseOptions] object with the keys loaded from the .env file.
  ///
  /// This method should only be called AFTER `dotenv.load()` has been executed.
  /// Throws an exception if the required API key is not found, ensuring a fail-fast system.
  static FirebaseOptions createOptions() {
    // Retrieve the API key from the environment variables.
    final apiKey = dotenv.env['FIREBASE_API_KEY_ANDROID'];

    // Fail-fast: If the API key is missing, crash the app immediately.
    // This is safer than letting Firebase fail silently.
    if (apiKey == null) {
      throw Exception('FIREBASE_API_KEY_ANDROID not found in .env file');
    }

    // You can retrieve other platform-specific IDs here if needed.
    // These are non-secret and can be stored directly.
    const String appId = '1:755701620617:android:f4c6aa3c8164be95c38b58';
    const String messagingSenderId = '755701620617';
    const String projectId = 'fir-b8753';
    const String storageBucket = 'fir-b8753.firebasestorage.app';

    return FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket,
    );
  }
}
