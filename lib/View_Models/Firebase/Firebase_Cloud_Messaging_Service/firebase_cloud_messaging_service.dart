import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseCloudMessagingService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> getUserDeviceToken() async {
    String? userDeviceToken = await firebaseMessaging.getToken();

    if (userDeviceToken != null || userDeviceToken!.isNotEmpty) {
      return userDeviceToken;
    } else {
      return null;
    }
  }
}
