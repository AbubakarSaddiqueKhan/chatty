import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Widgets/Phone_Number_Login_Screens_Widgets/enter_phone_number_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class FindUserScreen extends StatefulWidget {
  const FindUserScreen({super.key});

  static const String pageName = "/findUserScreen";

  @override
  State<FindUserScreen> createState() => _FindUserScreenState();
}

late TextEditingController newContactPhoneNumberTextEditingController;
final formState = GlobalKey<FormState>();

class _FindUserScreenState extends State<FindUserScreen> {
  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();

  late String? userPhoneNumber;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    newContactPhoneNumberTextEditingController = TextEditingController();
    // userPhoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
        SharedPreferenceLocalDataBase();
    userPhoneNumber = await sharedPreferenceLocalDataBase
        .fetchUserPhoneNumberFromLocalDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Enter the phone number of the user if it exists in our database then you will be able to chat with him / her",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.cyan, fontSize: 16),
                ),
                EnterPhoneNumberTextFormField(
                    phoneNumberTextEditingController:
                        newContactPhoneNumberTextEditingController)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade200,
        onPressed: () async {
          if (formState.currentState!.validate()) {
            QuerySnapshot<Map<String, dynamic>>? userData =
                await fireBaseFireStoreDatBase.findUserFromGivenPhoneNumber(
                    contactPhoneNumber:
                        newContactPhoneNumberTextEditingController.text);

            if (userData != null) {
              if (userData.docs.isNotEmpty) {
                developer.log("User  found");
                developer.log(
                    "User data .... ${userData.docs[0].data().toString()}");
                await fireBaseFireStoreDatBase.addUserChatBuddyContact(
                    contactPhoneNumber:
                        newContactPhoneNumberTextEditingController.text,
                    userPhoneNumber: userPhoneNumber!);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Oops !!! User not found ")));
                developer.log("User not found");
              }
            }
          }
        },
        child: const Icon(
          Icons.search,
          color: Colors.cyan,
        ),
      ),
    );
  }
}
