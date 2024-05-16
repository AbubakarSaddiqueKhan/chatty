import 'dart:io';

import 'package:chatty/View_Models/Custom_Codes/Image_Picker/image_pick_from_device.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Update_User_Profile_Image_Bloc/update_user_profile_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickUserProfileImageFromDeviceCustomWidget extends StatelessWidget {
  const PickUserProfileImageFromDeviceCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              final Size(:width, :height) = MediaQuery.sizeOf(context);
              return Container(
                width: width,
                height: height * 0.25,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    border: Border.all(color: Colors.blueGrey, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          (
                            File? pickedImageFile,
                            String pickedImageFileName
                          )? selectedImage =
                              await ImagePickFromDevice.pickImageFromDevice(
                                  ImagePickFromDevice.cameraSelected);

                          context.read<UpdateUserProfileImageBloc>().add(
                              UpdateUserProfilePhotoWithGivenImageEvent(
                                  imageName: selectedImage!.$2,
                                  selectedUserImage: selectedImage.$1!));

                          Navigator.of(context).pop();
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              style: TextStyle(color: Colors.cyan),
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
                              await ImagePickFromDevice.pickImageFromDevice(
                                  ImagePickFromDevice.gallerySelected);

                          context.read<UpdateUserProfileImageBloc>().add(
                              UpdateUserProfilePhotoWithGivenImageEvent(
                                  imageName: selectedImage!.$2,
                                  selectedUserImage: selectedImage.$1!));

                          Navigator.of(context).pop();
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              style: TextStyle(color: Colors.cyan),
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
        ));
  }
}
