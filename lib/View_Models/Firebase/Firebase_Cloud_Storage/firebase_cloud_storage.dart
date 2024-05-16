import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCloudStorage {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static const String userImages = "User Images";

  Future<String> uploadImageToFirebaseCloudStorage(
      {required File imageFile, required String mobileNumber}) async {
    String imageUrl = "";
    try {
      await firebaseStorage
          .ref()
          .child(FirebaseCloudStorage.userImages)
          // Here instead of the image name use the mobile number of the user .
          .child(mobileNumber)
          .putFile(imageFile);

      imageUrl = await firebaseStorage
          .ref()
          .child(FirebaseCloudStorage.userImages)
          .child(mobileNumber)
          .getDownloadURL();
    } catch (e) {
      print(e.toString());
    }

    return imageUrl;
  }
}
