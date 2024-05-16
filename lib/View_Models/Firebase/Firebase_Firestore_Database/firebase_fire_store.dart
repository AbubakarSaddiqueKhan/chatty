import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class FireBaseFireStoreDatBase {
  List<String> userContactNumberList = [];

  // Collections .
  // Main Collections .

  static const String userMainCollection = "users";

  // Sub Collections .

  static const String userContactsSubCollection = "contacts";
  // Keys ..
  static const String keyUserFirstName = "user_first_name";
  static const String keyUserLastName = "user_last_name";
  static const String keyUserImageURL = "user_image_url";
  static const String keyUserPhoneNumber = "user_phone_number";
  static const String keyUserDeviceToken = "user_device_token";
  static const String keyUserContactPhoneNumber = "user_contact_phone_number";

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // add data to firestore .
  Future<void> addUserDatToFirebaseStorage(
      {required String userDeviceToken,
      required String userFirstName,
      required String userLastName,
      required String userPhoneNumber,
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

  Future<void> addUserChatBuddyContact(
      {required String contactPhoneNumber,
      required String userPhoneNumber}) async {
    try {
      await firebaseFirestore
          .collection(userMainCollection)
          .doc(userPhoneNumber)
          .collection(userContactsSubCollection)
          .doc(contactPhoneNumber)
          .set({keyUserContactPhoneNumber: contactPhoneNumber});
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllChatContacts({required String phoneNumber}) async {
    DocumentSnapshot<Map<String, dynamic>> fethchDocumentsData =
        await firebaseFirestore
            .collection(userMainCollection)
            .doc(phoneNumber)
            .get();

    developer.log("Dtaaa ...... ${fethchDocumentsData.data().toString()}");
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> findUserFromGivenPhoneNumber(
      {required String contactPhoneNumber}) async {
    try {
      Query<Map<String, dynamic>>? checkUserExistence =
          await firebaseFirestore.collection(userMainCollection).where(
                keyUserPhoneNumber,
                isEqualTo: contactPhoneNumber,
              );

      if (checkUserExistence != null) {
        QuerySnapshot<Map<String, dynamic>> userData =
            await checkUserExistence.get();
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> checkUserContactsExistence(
      {required String userMobileNumber}) async {
    final querySnapshot = await firebaseFirestore
        .collection(userMainCollection)
        .doc(userMobileNumber)
        .collection(userContactsSubCollection)
        .get();
    if (querySnapshot.docs.isEmpty) {
      developer.log("User does'nt added any contact yet ....");
      return false;
    } else {
      developer
          .log("User contact list length ... ${querySnapshot.docs.length}");
      return true;
    }
  }

  Future<List<String>> fetchAllChatContactsOfGivenNumber(
      {required String userPhoneNumber}) async {
    developer.log("entereddddddddddddddddddd");
    QuerySnapshot<Map<String, dynamic>> userContactsData =
        await firebaseFirestore
            .collection(userMainCollection)
            .doc(userPhoneNumber)
            .collection(userContactsSubCollection)
            .get();

    for (var userData in userContactsData.docs) {
      developer.log("User data .... ${userData.data().toString()}");
      userContactNumberList.add(userData.data()[keyUserContactPhoneNumber]);
    }
    return userContactNumberList;
  }

  Future<Map<String, dynamic>?> fetchDataOfGivenPhoneNumber(
      {required String phoneNumber}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await firebaseFirestore
          .collection(userMainCollection)
          .doc(phoneNumber)
          .get();

      userData.data().toString();

      developer.log(
          "inputted phone number based  user data ....  ${userData.data().toString()}");

      return userData.data();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
