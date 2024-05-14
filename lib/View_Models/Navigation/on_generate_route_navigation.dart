import 'package:chatty/View_Models/Blocs/Firebase_Cloud_Messaging_Blocs/Fetch_User_Device_Token_Bloc/fetch_user_device_token_bloc.dart';
import 'package:chatty/View_Models/Blocs/Phone_Number_Page_Blocs/Update_Phone_Number_Length_BLoc/update_phone_number_length_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Data_To_Firebase_Firestore/upload_suer_data_to_firebase_firestore_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Profile_Image_To_firebase_Storage_Bloc/upload_user_profile_image_to_firebase_storage_bloc.dart';
import 'package:chatty/Views/Screens/chat_main_page_design.dart';
import 'package:chatty/Views/Screens/otp_verifying_screen.dart';
import 'package:chatty/Views/Screens/phone_number_login_page.dart';
import 'package:chatty/Views/Screens/splash_screen.dart';
import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.pageName:
      return CupertinoPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case PhoneNumberLoginPage.pageName:
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => BlocProvider(
          create: (context) => UpdatePhoneNumberLengthBloc(),
          child: const PhoneNumberLoginPage(),
        ),
      );

    case OTPVerifyingScreen.pageName:
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => const OTPVerifyingScreen(),
      );

    case UpdateUserProfileDataScreen.pageName:
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FetchUserDeviceTokenBloc(),
              ),
              BlocProvider(
                create: (context) =>
                    UploadUserProfileImageToFirebaseStorageBloc(),
              ),
              BlocProvider(
                create: (context) => UploadSuerDataToFirebaseFirestoreBloc(),
              ),
            ],
            child: const UpdateUserProfileDataScreen(),
          );
        },
      );

    case ChatMainPageDesign.pageName:
      return CupertinoPageRoute(
        builder: (context) {
          return const ChatMainPageDesign();
        },
      );

    default:
      null;
  }
}
