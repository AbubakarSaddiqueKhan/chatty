import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class SharedPreferenceLocalDataBase {
  Future<bool> addUserMobilePhoneNumberToLocalDatabase(
      {required String phoneNumber}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool isUserPhoneNumberAdded = await sharedPreferences.setString(
        FireBaseFireStoreDatBase.keyUserPhoneNumber, phoneNumber);

    developer
        .log("Current added phone number data ..... $isUserPhoneNumberAdded");

    return isUserPhoneNumberAdded;
  }

  Future<String?> fetchUserPhoneNumberFromLocalDatabase() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userMobileNumber = sharedPreferences
        .getString(FireBaseFireStoreDatBase.keyUserPhoneNumber);

    if (userMobileNumber != null) {
      if (userMobileNumber.isNotEmpty) {
        return userMobileNumber;
      }
    } else {
      return null;
    }
  }
}
