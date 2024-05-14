import 'dart:io';

import 'package:chatty/View_Models/Blocs/Firebase_Cloud_Messaging_Blocs/Fetch_User_Device_Token_Bloc/fetch_user_device_token_bloc.dart';

import 'package:chatty/View_Models/Firebase/firebase_cloud_storage.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/update_user_profile_screen_all_Widgets_list.dart';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

// Here in this class we will need of phone number of the user that we will store locally using the shared preference  and on the firestore on the click event of the button .

// Thing's to be added .

/// i -- User Phone number
/// ii -- User Firebase token for push notification
/// iii -- User Image url
/// iv -- User first name
/// v -- user last name
///  Document name will be the phone number of the user .
///

class UpdateUserProfileDataScreen extends StatefulWidget {
  const UpdateUserProfileDataScreen({super.key});
  static const String pageName = "/updateUserProfileScreen";

  @override
  State<UpdateUserProfileDataScreen> createState() =>
      _UpdateUserProfileDataScreenState();
}

late TextEditingController _userNameFirstTextEditingController;
late TextEditingController _userNameLastTextEditingController;

FirebaseCloudStorage firebaseCloudStorage = FirebaseCloudStorage();

late String userPhoneNumber;

final formState = GlobalKey<FormState>();

class _UpdateUserProfileDataScreenState
    extends State<UpdateUserProfileDataScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userNameFirstTextEditingController = TextEditingController();
    _userNameLastTextEditingController = TextEditingController();
    context.read<FetchUserDeviceTokenBloc>().add(FetchUserDeviceTokenEvent());
    userPhoneNumber = ModalRoute.of(context)!.settings.arguments as String;
  }

  void uploadImageToFirebaseStorage(
      {required String mobileNumber, required File imageFile}) async {
    String imageUrl =
        await firebaseCloudStorage.uploadImageToFirebaseCloudStorage(
            imageFile: imageFile, mobileNumber: mobileNumber);

    developer.log("Image Urll  ....... $imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: formState,
            child: UpdateUserProfileScreenAllWidgetsList(
                userNameFirstTextEditingController:
                    _userNameFirstTextEditingController,
                userMobileNumber: userPhoneNumber,
                userNameLastTextEditingController:
                    _userNameLastTextEditingController)),
      ),
    );
  }
}
