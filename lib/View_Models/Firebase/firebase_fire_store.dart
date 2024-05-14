import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class FireBaseFireStoreDatBase {
  // Collections .
  static const String userMainCollection = "users";
  // Keys ..
  static const String keyUserFirstName = "user_first_name";
  static const String keyUserLastName = "user_last_name";
  static const String keyUserImageURL = "user_image_url";
  static const String keyUserPhoneNumber = "user_phone_number";
  static const String keyUserDeviceToken = "user_device_token";

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // add data to firestore .
  Future<void> addUserDatToFirebaseStorage(
      {required String userDeviceToken,
      required String userFirstName,
      required userLastName,
      required userPhoneNumber,
      required String userImageUrl}) async {
    try {
      await firebaseFirestore
          .collection(userMainCollection)
          .doc(userPhoneNumber)
          .set({
        keyUserFirstName: userFirstName,
        keyUserLastName: userLastName,
        keyUserImageURL: userImageUrl,
        keyUserPhoneNumber: userPhoneNumber,
        keyUserDeviceToken: userDeviceToken
      });
      developer.log("User data added");
    } catch (e) {
      print(e.toString());
    }
  }
}
