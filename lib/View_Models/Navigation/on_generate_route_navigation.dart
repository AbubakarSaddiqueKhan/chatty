import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_All_Chats_Of_Given_User_Bloc/fetch_all_chat_of_given_user_bloc.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_User_Data_From_Firestore_Bloc/fetch_user_data_from_firestore_bloc.dart';
import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Display_User_Chat_Contacts_Data_Bloc/display_user_chat_contacts_data_bloc.dart';
import 'package:chatty/View_Models/Blocs/Firebase_Cloud_Messaging_Blocs/Fetch_User_Device_Token_Bloc/fetch_user_device_token_bloc.dart';
import 'package:chatty/View_Models/Blocs/Phone_Number_Page_Blocs/Add_User_Phone_Number_To_LOcal_Database/add_user_phone_number_to_local_database_bloc.dart';
import 'package:chatty/View_Models/Blocs/Phone_Number_Page_Blocs/Update_Phone_Number_Length_BLoc/update_phone_number_length_bloc.dart';
import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Update_User_Contact_Length_Bloc/update_user_contacts_length_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Data_To_Firebase_Firestore/upload_suer_data_to_firebase_firestore_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Profile_Image_To_firebase_Storage_Bloc/upload_user_profile_image_to_firebase_storage_bloc.dart';
import 'package:chatty/Views/Screens/chat_detailed_page_design.dart';
import 'package:chatty/Views/Screens/chat_main_page_design.dart';
import 'package:chatty/Views/Screens/find_user_screen.dart';
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
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UpdatePhoneNumberLengthBloc(),
            ),
            BlocProvider(
              create: (context) => AddUserPhoneNumberToLocalDatabaseBloc(),
            ),
          ],
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

// 03700452203

    case ChatMainPageDesign.pageName:
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FetchUserDataFromFirestoreBloc(),
              ),
              BlocProvider(
                create: (context) => UpdateUserContactsLengthBloc(),
              ),
              BlocProvider(
                create: (context) => DisplayUserChatContactsDataBloc(),
              ),
            ],
            child: const ChatMainPageDesign(),
          );
        },
      );

    case ChatDetailedScreen.pageName:
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FetchUserDataFromFirestoreBloc(),
            ),
            BlocProvider(
              create: (context) => FetchAllChatOfGivenUserBloc(),
            ),
          ],
          child: const ChatDetailedScreen(),
        ),
      );

    case FindUserScreen.pageName:
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) {
          return BlocProvider(
            create: (context) => UpdatePhoneNumberLengthBloc(),
            child: const FindUserScreen(),
          );
        },
      );

    default:
      null;
  }
}
