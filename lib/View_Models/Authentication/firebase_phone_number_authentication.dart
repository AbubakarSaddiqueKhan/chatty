import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class PhoneAuthentication {
  static void sendVerificationCodeToPhoneNumber(String phoneNumber) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    String userPhoneNumber = "+92${phoneNumber.substring(1)}";

    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: userPhoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) async {
          // In android it will automatically authenticate user on otp received without entering the otp
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
          developer.log("Navigate to home User Profile page ............");
        },
        verificationFailed: (error) {
          if (error.code == 'invalid-phone-number') {
            developer.log('The provided phone number is not valid.');
          } else {
            developer.log("Errrrrrr isss .............. ${error.toString()}");
          }
        },
        codeSent: (verificationId, forceResendingToken) {
          developer.log("Navigate to otp screeeen .............");
        },
        codeAutoRetrievalTimeout: (verificationId) {
          developer.log("Oops !! verification Time Out");
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
