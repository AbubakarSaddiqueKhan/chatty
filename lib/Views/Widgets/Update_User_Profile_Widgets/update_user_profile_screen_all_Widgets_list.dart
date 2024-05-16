import 'dart:io';

import 'package:chatty/View_Models/Blocs/Firebase_Cloud_Messaging_Blocs/Fetch_User_Device_Token_Bloc/fetch_user_device_token_bloc.dart';
import 'package:chatty/Views/Screens/find_user_screen.dart';
import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/navigate_to_next_page_chat_main_page_custom_button.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/pick_user_profile_image_from_device_custom_widget.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/update_user_profile_text_form_field.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/user_profile_image_bloc_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class UpdateUserProfileScreenAllWidgetsList extends StatefulWidget {
  const UpdateUserProfileScreenAllWidgetsList(
      {super.key,
      required this.userNameFirstTextEditingController,
      required this.userNameLastTextEditingController});

  final TextEditingController userNameFirstTextEditingController;
  final TextEditingController userNameLastTextEditingController;

  @override
  State<UpdateUserProfileScreenAllWidgetsList> createState() =>
      _UpdateUserProfileScreenAllWidgetsListState();
}

final formStateCustom = GlobalKey<FormState>();

class _UpdateUserProfileScreenAllWidgetsListState
    extends State<UpdateUserProfileScreenAllWidgetsList> {
  late String userDeviceToken;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return BlocBuilder<FetchUserDeviceTokenBloc, FetchUserDeviceTokenState>(
      builder: (context, state) {
        if (state is FetchUserDeviceTokenInitialState) {
          context
              .read<FetchUserDeviceTokenBloc>()
              .add(FetchUserDeviceTokenEvent());
          return const SizedBox.shrink();
        } else if (state is FetchUserDeviceTokenLoadingState) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.cyan,
          ));
        } else if (state is FetchUserDeviceTokenLoadedState) {
          userDeviceToken = state.userDeviceToken;
          developer.log("User device token ...... $userDeviceToken");
          return Form(
            key: formStateCustom,
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
                          child: UserProfileImageBlocBuilderWidget()),
                      Positioned(
                          bottom: height * 0.001,
                          left: width * 0.455,
                          child:
                              const PickUserProfileImageFromDeviceCustomWidget())
                    ],
                  ),
                ),
                UpdateUserProfileNameTextFormField(
                    labelText: "User First Name",
                    phoneNumberTextEditingController:
                        widget.userNameFirstTextEditingController),
                UpdateUserProfileNameTextFormField(
                    labelText: "User Last Name",
                    phoneNumberTextEditingController:
                        widget.userNameLastTextEditingController),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Your above provided data will be set to your profile . You may change it later",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.cyan),
                  ),
                ),
                NavigateToNextPageChatMainPageCustomButton(
                    userNameFirstTextEditingController:
                        widget.userNameFirstTextEditingController,
                    userDeviceToken: userDeviceToken,
                    userNameLastTextEditingController:
                        widget.userNameLastTextEditingController)
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
