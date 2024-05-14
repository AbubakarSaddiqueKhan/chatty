import 'dart:io';

import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Data_To_Firebase_Firestore/upload_suer_data_to_firebase_firestore_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Profile_Image_To_firebase_Storage_Bloc/upload_user_profile_image_to_firebase_storage_bloc.dart';
import 'package:chatty/Views/Screens/chat_main_page_design.dart';
import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/user_profile_image_bloc_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class NavigateToNextPageChatMainPageCustomButton extends StatelessWidget {
  const NavigateToNextPageChatMainPageCustomButton(
      {super.key,
      required this.userNameFirstTextEditingController,
      required this.userMobileNumber,
      required this.userDeviceToken,
      required this.userNameLastTextEditingController});
  final TextEditingController userNameFirstTextEditingController;
  final TextEditingController userNameLastTextEditingController;
  final String userMobileNumber;

  final String userDeviceToken;

  void navigateToChatMainPage({required BuildContext context}) {
    Navigator.of(context).pushNamed(ChatMainPageDesign.pageName);
  }

  @override
  Widget build(BuildContext context) {
    String? uploadedUserImageURL;
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return BlocBuilder<UploadUserProfileImageToFirebaseStorageBloc,
        UploadUserProfileImageToFirebaseStorageState>(
      builder: (context, state) {
        if (state is UploadUserProfileImageToFirebaseStorageInitialState) {
          developer.log("Upload initialllllll");
          return InkWell(
            onTap: () {
              developer.log("Clickedddddd");
              if (formState.currentState!.validate()) {
                developer.log("image nullll");
                if (userSelectedImage != null) {
                  developer.log("Uploadig imageeeee");
                  context
                      .read<UploadUserProfileImageToFirebaseStorageBloc>()
                      .add(UploadUserPickedProfileImageToFirebaseStorageEvent(
                          imageFile: userSelectedImage!,
                          userMobileNumber: userMobileNumber));

                  developer.log("Uploadeddddd imageeeee");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Update Your Profile Photo")));
                }
              }
            },
            child: Container(
              width: width * 0.75,
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.cyan, width: 2)),
              alignment: Alignment.center,
              child: const Text(
                "Agree & Continue",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.cyan, fontSize: 18),
              ),
            ),
          );
        } else if (state
            is UploadUserProfileImageToFirebaseStorageLoadingState) {
          developer.log("Upload Lasingggggg");

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
              strokeWidth: 5,
            ),
          );
        } else if (state
            is UploadUserProfileImageToFirebaseStorageLoadedState) {
          developer.log("Upload Loaedddd");

          uploadedUserImageURL = state.uploadedUserImageURL;

          return BlocBuilder<UploadSuerDataToFirebaseFirestoreBloc,
              UploadSuerDataToFirebaseFirestoreState>(
            builder: (context, state) {
              if (state is UploadSuerDataToFirebaseFirestoreInitialState) {
                developer.log("Firestore initialllllll");

                if ((uploadedUserImageURL != null ||
                    uploadedUserImageURL!.isNotEmpty)) {
                  context.read<UploadSuerDataToFirebaseFirestoreBloc>().add(
                      UploadUserProvidedDataToFirebaseFireStoreEvent(
                          userDeviceToken: userDeviceToken!,
                          userFirstName:
                              userNameFirstTextEditingController.text,
                          userLastName: userNameLastTextEditingController.text,
                          userPhoneNumber: userMobileNumber,
                          userImageUrl: uploadedUserImageURL!));
                }
              } else if (state
                  is UploadSuerDataToFirebaseFirestoreLoadingState) {
                developer.log("Firestore loadidnggggg");
              } else if (state
                  is UploadSuerDataToFirebaseFirestoreLoadedState) {
                developer.log("Navigate Successfully");
                navigateToChatMainPage(context: context);
              }
              return const SizedBox.shrink();
            },
          );
        } else {
          developer.log("Upload Errorrrr");

          return const SizedBox.shrink();
        }
      },
    );
  }
}
