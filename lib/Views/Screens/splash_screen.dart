import 'dart:async';
import 'dart:developer' as developer;
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Screens/chat_main_page_design.dart';
import 'package:chatty/Views/Screens/phone_number_login_page.dart';
import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String pageName = "/splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double logoScaleValue = 0;
  late String? userPhoneNumber;
  late bool isUserDataExists;
  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    developer.log("message entereddd");

    developer.log("finallllll");

    Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(() {
              logoScaleValue = 1;
            }));

    await checkUserIsLoginOrNot();
  }

  Future<void> checkUserIsLoginOrNot() async {
    userPhoneNumber = await fetchUserPhoneNumberFromLocalDatabase();
    if (userPhoneNumber != null) {
      developer.log("no no tnulll entereddd");

      if (userPhoneNumber!.isNotEmpty) {
        developer.log("no not emptyyyyyy entereddd");
        isUserDataExists = await fireBaseFireStoreDatBase.checkUserExistence(
            userMobileNumber: userPhoneNumber!);
        if (isUserDataExists) {
          developer.log("User data existssss.....");

          Navigator.of(context)
              .pushReplacementNamed(ChatMainPageDesign.pageName);
        } else {
          developer.log("User data doesnottttt existssss.....");

          Navigator.of(context)
              .pushReplacementNamed(UpdateUserProfileDataScreen.pageName);
        }
      }
    } else {
      await Navigator.of(context)
          .pushReplacementNamed(PhoneNumberLoginPage.pageName);

      userPhoneNumber = await fetchUserPhoneNumberFromLocalDatabase();
      if (userPhoneNumber != null) {
        developer.log("no no tnulll entereddd");

        if (userPhoneNumber!.isNotEmpty) {
          developer.log("no not emptyyyyyy entereddd");
          isUserDataExists = await fireBaseFireStoreDatBase.checkUserExistence(
              userMobileNumber: userPhoneNumber!);
          if (isUserDataExists) {
            developer.log("User data existssss.....");

            Navigator.of(context)
                .pushReplacementNamed(ChatMainPageDesign.pageName);
          } else {
            developer.log("User data doesnottttt existssss.....");

            Navigator.of(context)
                .pushReplacementNamed(UpdateUserProfileDataScreen.pageName);
          }
        }
      }
    }

    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //     developer.log("User is currently signed out!");
    //     Navigator.of(context)
    //         .pushReplacementNamed(PhoneNumberLoginPage.pageName);
    //   } else {
    //     print('User is signed in!');
    //     developer.log("User is signed in!");

    //     Navigator.of(context).pushReplacementNamed(ChatMainPageDesign.pageName);

    //     // if (isUserDataExists) {
    //     //   developer.log("User data existssss.....");

    //     //   Navigator.of(context)
    //     //       .pushReplacementNamed(ChatMainPageDesign.pageName);
    //     // } else {
    //     //   developer.log("User data doesnottttt existssss.....");

    //     //   Navigator.of(context)
    //     //       .pushReplacementNamed(UpdateUserProfileDataScreen.pageName);
    //     // }
    //   }
    // });
  }

  Future<String?> fetchUserPhoneNumberFromLocalDatabase() async {
    SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
        SharedPreferenceLocalDataBase();
    String? phoneNumber = await sharedPreferenceLocalDataBase
        .fetchUserPhoneNumberFromLocalDatabase();
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: AnimatedScale(
          duration: const Duration(seconds: 1),
          scale: logoScaleValue,
          child: SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
