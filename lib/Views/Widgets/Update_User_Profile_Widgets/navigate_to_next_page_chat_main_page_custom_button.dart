import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Data_To_Firebase_Firestore/upload_suer_data_to_firebase_firestore_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Profile_Image_To_firebase_Storage_Bloc/upload_user_profile_image_to_firebase_storage_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Screens/chat_main_page_design.dart';
import 'package:chatty/Views/Screens/find_user_screen.dart';
import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/update_user_profile_screen_all_Widgets_list.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/user_profile_image_bloc_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class NavigateToNextPageChatMainPageCustomButton extends StatefulWidget {
  const NavigateToNextPageChatMainPageCustomButton(
      {super.key,
      required this.userNameFirstTextEditingController,
      // required this.userMobileNumber,
      required this.userDeviceToken,
      required this.userNameLastTextEditingController});
  final TextEditingController userNameFirstTextEditingController;
  final TextEditingController userNameLastTextEditingController;
  // final String userMobileNumber;

  final String userDeviceToken;

  @override
  State<NavigateToNextPageChatMainPageCustomButton> createState() =>
      _NavigateToNextPageChatMainPageCustomButtonState();
}

class _NavigateToNextPageChatMainPageCustomButtonState
    extends State<NavigateToNextPageChatMainPageCustomButton> {
  late String? userMobilePhoneNumber;
  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
        SharedPreferenceLocalDataBase();
    userMobilePhoneNumber = await sharedPreferenceLocalDataBase
        .fetchUserPhoneNumberFromLocalDatabase();
  }

  void navigateToChatMainPage(
      {required String uploadedUserImageURL,
      required BuildContext context}) async {
    if (userMobilePhoneNumber != null) {
      if (userMobilePhoneNumber!.isNotEmpty) {
        developer.log("User fetched mobile phone number");
      }
    }
    await fireBaseFireStoreDatBase.addUserDatToFirebaseStorage(
        userDeviceToken: widget.userDeviceToken,
        userFirstName: widget.userNameFirstTextEditingController.text,
        userLastName: widget.userNameLastTextEditingController.text,
        userPhoneNumber: userMobilePhoneNumber!,
        userImageUrl: uploadedUserImageURL);

    developer.log("Data adeeddddd sucessssssss......");
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
              if (formStateCustom.currentState!.validate()) {
                developer.log("image nullll");
                if (userSelectedImage != null) {
                  developer.log("Uploadig imageeeee");
                  context
                      .read<UploadUserProfileImageToFirebaseStorageBloc>()
                      .add(UploadUserPickedProfileImageToFirebaseStorageEvent(
                          imageFile: userSelectedImage!,
                          userMobileNumber: userMobilePhoneNumber!));

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

          navigateToChatMainPage(
              uploadedUserImageURL: uploadedUserImageURL!, context: context);

          return const SizedBox.shrink();
        } else {
          developer.log("Upload Errorrrr");
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.tealAccent,
              strokeWidth: 5,
            ),
          );
        }
      },
    );
  }
}
