import 'package:chatty/Views/Screens/otp_verifying_screen.dart';
import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PhoneAuthentication {
  static void sendVerificationCodeToPhoneNumber(
      {required String phoneNumber, required BuildContext context}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    String userPhoneNumber = "+92${phoneNumber.substring(1)}";

    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: userPhoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (phoneAuthCredential) async {
          // In android it will automatically authenticate user on otp received without entering the otp
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
          developer.log("Navigate to home User Profile page ............");
          Navigator.of(context).pushNamed(UpdateUserProfileDataScreen.pageName,
              arguments: phoneNumber);
        },
        verificationFailed: (error) {
          if (error.code == 'invalid-phone-number') {
            developer.log('The provided phone number is not valid.');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("The provided phone number is not valid")));
          } else {
            developer.log("Errrrrrr isss .............. ${error.toString()}");
          }
        },
        codeSent: (verificationId, forceResendingToken) async {
          // developer.log("Token .. Forcedddd ... $forceResendingToken");

          String currentEnteredOTP = await Navigator.of(context).pushNamed(
              OTPVerifyingScreen.pageName,
              arguments: phoneNumber) as String;

          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: currentEnteredOTP);

          // Sign the user in (or link) with the credential
          await firebaseAuth.signInWithCredential(credential);

          developer.log("Navigate to otp screeeen .............");

          Navigator.of(context).pushNamed(UpdateUserProfileDataScreen.pageName,
              arguments: phoneNumber);
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
