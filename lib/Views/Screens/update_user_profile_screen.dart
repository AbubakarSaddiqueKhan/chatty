import 'dart:io';

import 'package:chatty/Model/Image_Picker/image_pick_from_device.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Pick_User_Image_From_Device_Bloc/pick_user_image_from_device_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Update_User_Profile_Image_Bloc/update_user_profile_image_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Data_To_Firebase_Firestore/upload_suer_data_to_firebase_firestore_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Profile_Image_To_firebase_Storage_Bloc/upload_user_profile_image_to_firebase_storage_bloc.dart';
import 'package:chatty/View_Models/Firebase/firebase_cloud_storage.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/update_user_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  @override
  State<UpdateUserProfileDataScreen> createState() =>
      _UpdateUserProfileDataScreenState();
}

late TextEditingController _userNameFirstTextEditingController;
late TextEditingController _userNameLastTextEditingController;
File? userSelectedImage;
FirebaseCloudStorage firebaseCloudStorage = FirebaseCloudStorage();
String? uploadedUserImageURL;

final formState = GlobalKey<FormState>();

class _UpdateUserProfileDataScreenState
    extends State<UpdateUserProfileDataScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userNameFirstTextEditingController = TextEditingController();
    _userNameLastTextEditingController = TextEditingController();
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
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                height: width * 0.55,
                child: Stack(
                  children: [
                    Positioned(
                      top: height * 0.02,
                      left: width * 0.3,
                      child: BlocBuilder<UpdateUserProfileImageBloc,
                          UpdateUserProfileImageState>(
                        builder: (context, state) {
                          if (state is UpdateUserProfileImageInitialState) {
                            developer.log("Initiallllllllllll Stateeeee.....");
                            return Container(
                              width: width * 0.45,
                              height: width * 0.45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/user.png"),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(color: Colors.cyan, width: 3)),
                            );
                          } else if (state
                              is UpdateUserProfileImageLoadingState) {
                            developer.log("Loadidngggggggg Stateeeee .....");
                            return Container(
                              width: width * 0.45,
                              height: width * 0.45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/user.png"),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(color: Colors.cyan, width: 3)),
                            );
                          } else if (state
                              is UpdateUserProfileImageLoadedState) {
                            developer.log("Loadeddddddd Stateeeee .....");
                            userSelectedImage = state.userSelectedImage;

                            return Container(
                              width: width * 0.45,
                              height: width * 0.45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(state.userSelectedImage),
                                      fit: BoxFit.contain),
                                  border:
                                      Border.all(color: Colors.cyan, width: 3)),
                            );
                          } else {
                            developer.log("Errorrrrrrrrrrrrr Stateeeee .....");
                            return Container(
                              width: width * 0.45,
                              height: width * 0.45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/user.png"),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(color: Colors.red, width: 3)),
                            );
                          }
                        },
                      ),
                    ),
                    Positioned(
                        bottom: height * 0.001,
                        left: width * 0.455,
                        child: IconButton(
                            onPressed: () {
                              // openBottomNavigationSheetForCameraGallerySelection();
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    width: width,
                                    height: height * 0.25,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        border: Border.all(
                                            color: Colors.blueGrey, width: 2)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              (
                                                File? pickedImageFile,
                                                String pickedImageFileName
                                              )? selectedImage =
                                                  await ImagePickFromDevice
                                                      .pickImageFromDevice(
                                                          ImagePickFromDevice
                                                              .cameraSelected);

                                              context
                                                  .read<
                                                      UpdateUserProfileImageBloc>()
                                                  .add(
                                                      UpdateUserProfilePhotoWithGivenImageEvent(
                                                          imageName:
                                                              selectedImage!.$2,
                                                          selectedUserImage:
                                                              selectedImage
                                                                  .$1!));

                                              Navigator.of(context).pop();
                                            },
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.cyan,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                      color: Colors.cyan),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              (
                                                File? pickedImageFile,
                                                String pickedImageFileName
                                              )? selectedImage =
                                                  await ImagePickFromDevice
                                                      .pickImageFromDevice(
                                                          ImagePickFromDevice
                                                              .gallerySelected);

                                              context
                                                  .read<
                                                      UpdateUserProfileImageBloc>()
                                                  .add(
                                                      UpdateUserProfilePhotoWithGivenImageEvent(
                                                          imageName:
                                                              selectedImage!.$2,
                                                          selectedUserImage:
                                                              selectedImage
                                                                  .$1!));

                                              Navigator.of(context).pop();
                                            },
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.image_outlined,
                                                  color: Colors.cyan,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                      color: Colors.cyan),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: Colors.teal,
                            )))
                  ],
                ),
              ),
              UpdateUserProfileNameTextFormField(
                  labelText: "User First Name",
                  phoneNumberTextEditingController:
                      _userNameFirstTextEditingController),
              UpdateUserProfileNameTextFormField(
                  labelText: "User Last Name",
                  phoneNumberTextEditingController:
                      _userNameLastTextEditingController),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Your above provided data will be set to your profile . You may change it later",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.cyan),
                ),
              ),
              BlocBuilder<UploadUserProfileImageToFirebaseStorageBloc,
                  UploadUserProfileImageToFirebaseStorageState>(
                builder: (context, state) {
                  if (state
                      is UploadUserProfileImageToFirebaseStorageInitialState) {
                    return InkWell(
                      onTap: () {
                        if (formState.currentState!.validate()) {
                          if (userSelectedImage != null) {
                            context
                                .read<
                                    UploadUserProfileImageToFirebaseStorageBloc>()
                                .add(
                                    UploadUserPickedProfileImageToFirebaseStorageEvent(
                                        imageFile: userSelectedImage!,
                                        userMobileNumber: "03007853886"));
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
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyan,
                        strokeWidth: 5,
                      ),
                    );
                  } else if (state
                      is UploadUserProfileImageToFirebaseStorageLoadedState) {
                    uploadedUserImageURL = state.uploadedUserImageURL;
                    return BlocBuilder<UploadSuerDataToFirebaseFirestoreBloc,
                        UploadSuerDataToFirebaseFirestoreState>(
                      builder: (context, state) {
                        if (state
                            is UploadSuerDataToFirebaseFirestoreInitialState) {
                          if (uploadedUserImageURL != null ||
                              uploadedUserImageURL!.isNotEmpty) {
                            context
                                .read<UploadSuerDataToFirebaseFirestoreBloc>()
                                .add(
                                    UploadUserProvidedDataToFirebaseFireStoreEvent(
                                        userDeviceToken: "12345678",
                                        userFirstName:
                                            _userNameFirstTextEditingController
                                                .text,
                                        userLastName:
                                            _userNameLastTextEditingController
                                                .text,
                                        userPhoneNumber: "03038738355",
                                        userImageUrl: uploadedUserImageURL!));
                          }
                        } else if (state
                            is UploadSuerDataToFirebaseFirestoreLoadingState) {
                        } else if (state
                            is UploadSuerDataToFirebaseFirestoreLoadedState) {
                          developer.log("Navigate Successfully");
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
