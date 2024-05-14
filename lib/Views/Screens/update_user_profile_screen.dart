import 'dart:io';

import 'package:chatty/Model/Image_Picker/image_pick_from_device.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Pick_User_Image_From_Device_Bloc/pick_user_image_from_device_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Update_User_Profile_Image_Bloc/update_user_profile_image_bloc.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/update_user_profile.dart';
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

final formState = GlobalKey<FormState>();

class _UpdateUserProfileDataScreenState
    extends State<UpdateUserProfileDataScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userNameFirstTextEditingController = TextEditingController();
    _userNameLastTextEditingController = TextEditingController();
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
                            return Container(
                              width: width * 0.45,
                              height: width * 0.45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(state.userSelectedImage),
                                      fit: BoxFit.cover),
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
                                              File? selectedImage =
                                                  await ImagePickFromDevice
                                                      .pickImageFromDevice(
                                                          ImagePickFromDevice
                                                              .cameraSelected);

                                              context
                                                  .read<
                                                      UpdateUserProfileImageBloc>()
                                                  .add(
                                                      UpdateUserProfilePhotoWithGivenImageEvent(
                                                          selectedUserImage:
                                                              selectedImage!));

                                              // setState(() {
                                              //   userSelectedImage =
                                              //       selectedImage!;
                                              // });

                                              Navigator.of(context).pop();
                                              // developer
                                              //     .log("camera is clicked");
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
                                              File? selectedImage =
                                                  await ImagePickFromDevice
                                                      .pickImageFromDevice(
                                                          ImagePickFromDevice
                                                              .gallerySelected);

                                              context
                                                  .read<
                                                      UpdateUserProfileImageBloc>()
                                                  .add(
                                                      UpdateUserProfilePhotoWithGivenImageEvent(
                                                          selectedUserImage:
                                                              selectedImage!));

                                              // setState(() {
                                              //   userSelectedImage =
                                              //       selectedImage!;
                                              // });

                                              Navigator.of(context).pop();

                                              // developer
                                              //     .log("gallery is clicked");
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
              InkWell(
                onTap: () {
                  if (formState.currentState!.validate()) {
                    developer.log("Navigate Successfully to next page......");
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
