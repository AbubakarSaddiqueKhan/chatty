import 'dart:io';

import 'package:chatty/View_Models/Blocs/Firebase_Cloud_Messaging_Blocs/Fetch_User_Device_Token_Bloc/fetch_user_device_token_bloc.dart';

import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Storage/firebase_cloud_storage.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/update_user_profile_screen_all_Widgets_list.dart';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

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

class _UpdateUserProfileDataScreenState
    extends State<UpdateUserProfileDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameFirstTextEditingController = TextEditingController();
    _userNameLastTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _userNameFirstTextEditingController.dispose();
    _userNameLastTextEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<FetchUserDeviceTokenBloc>().add(FetchUserDeviceTokenEvent());
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
        child: UpdateUserProfileScreenAllWidgetsList(
            userNameFirstTextEditingController:
                _userNameFirstTextEditingController,
            userNameLastTextEditingController:
                _userNameLastTextEditingController),
      ),
    );
  }
}
