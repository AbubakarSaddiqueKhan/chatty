import 'dart:developer';
import 'dart:io';

import 'package:chatty/View_Models/Custom_Codes/Image_Picker/image_pick_from_device.dart';
import 'package:chatty/View_Models/Blocs/Firebase_Cloud_Messaging_Blocs/Fetch_User_Device_Token_Bloc/fetch_user_device_token_bloc.dart';
import 'package:chatty/View_Models/Blocs/Phone_Number_Page_Blocs/Update_Phone_Number_Length_BLoc/update_phone_number_length_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Pick_User_Image_From_Device_Bloc/pick_user_image_from_device_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Update_User_Profile_Image_Bloc/update_user_profile_image_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Data_To_Firebase_Firestore/upload_suer_data_to_firebase_firestore_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Upload_User_Profile_Image_To_firebase_Storage_Bloc/upload_user_profile_image_to_firebase_storage_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Navigation/on_generate_route_navigation.dart';
import 'package:chatty/Views/Screens/chat_detailed_page_design.dart';
import 'package:chatty/Views/Screens/chat_main_page_design.dart';
import 'package:chatty/Views/Screens/find_user_screen.dart';
import 'package:chatty/Views/Screens/splash_screen.dart';
import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_Received_to_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_send_from_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_list_tile.dart';
import 'package:chatty/Views/Widgets/Phone_Number_Login_Screens/enter_phone_number_text_form_field.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/update_user_profile_text_form_field.dart';
import 'package:chatty/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
// 03017731831
// 03700452203

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserProfileImageBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        // initialRoute: SplashScreen.pageName,
        initialRoute: ChatMainPageDesign.pageName,
        // initialRoute: ChatMainPageDesign.pageName,
        // home: const ChatMainPageDesign(),
        // home: const ChatDetailedScreen()
        // home: MultiBlocProvider(
        //   providers: [
        //     BlocProvider(
        //       create: (context) => FetchUserDeviceTokenBloc(),
        //     ),
        //     BlocProvider(
        //       create: (context) =>
        //           UploadUserProfileImageToFirebaseStorageBloc(),
        //     ),
        //     BlocProvider(
        //       create: (context) => UploadSuerDataToFirebaseFirestoreBloc(),
        //     ),
        //   ],
        //   child: const UpdateUserProfileDataScreen(),
        // ),
        // home: const ChatMainPageDesign(),
        // home: BlocProvider(
        //   create: (context) => UpdatePhoneNumberLengthBloc(),
        //   child: const FindUserScreen(),
        // ),
        // home: const ImageTest(),
        // home: const FetchContacts(),
      ),
    );
  }
}

class FetchContacts extends StatelessWidget {
  const FetchContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  FireBaseFireStoreDatBase()
                      .fetchAllChatContacts(phoneNumber: "03038738355");
                },
                child: const Text("Fetch Data"))
          ],
        ),
      ),
    );
  }
}

/**
 * 
 * Platform  Firebase App Id
web       1:399624615138:web:a7da05db4cb10babe6dabb
android   1:399624615138:android:4a23ae3c7e4f54a7e6dabb
ios       1:399624615138:ios:4c02311c1a3041fde6dabb
macos     1:399624615138:ios:4c02311c1a3041fde6dabb
windows   1:399624615138:web:6a155522adeb4a9ce6dabb


 */