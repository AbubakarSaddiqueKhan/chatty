import 'dart:io';
import 'dart:developer' as developer;
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Update_User_Profile_Image_Bloc/update_user_profile_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileImageBlocBuilderWidget extends StatefulWidget {
  UserProfileImageBlocBuilderWidget({
    super.key,
  });

  @override
  State<UserProfileImageBlocBuilderWidget> createState() =>
      _UserProfileImageBlocBuilderWidgetState();
}

late String userImageName;
late File userSelectedImage;

class _UserProfileImageBlocBuilderWidgetState
    extends State<UserProfileImageBlocBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUserProfileImageBloc, UpdateUserProfileImageState>(
      builder: (context, state) {
        final Size(:width, :height) = MediaQuery.sizeOf(context);
        if (state is UpdateUserProfileImageInitialState) {
          return Container(
            width: width * 0.45,
            height: width * 0.45,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                    image: AssetImage("assets/images/user.png"),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.cyan, width: 3)),
          );
        } else if (state is UpdateUserProfileImageLoadingState) {
          return Container(
            width: width * 0.45,
            height: width * 0.45,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                    image: AssetImage("assets/images/user.png"),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.cyan, width: 3)),
          );
        } else if (state is UpdateUserProfileImageLoadedState) {
          userSelectedImage = state.userSelectedImage;
          userImageName = state.userSelectedImageName;
          developer.log("image updateddddd");

          return Container(
            width: width * 0.45,
            height: width * 0.45,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: FileImage(state.userSelectedImage),
                    fit: BoxFit.contain),
                border: Border.all(color: Colors.cyan, width: 3)),
          );
        } else {
          return Container(
            width: width * 0.45,
            height: width * 0.45,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                    image: AssetImage("assets/images/user.png"),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.red, width: 3)),
          );
        }
      },
    );
  }
}
