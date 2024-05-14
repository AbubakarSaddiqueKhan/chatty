import 'dart:developer';
import 'dart:io';

import 'package:chatty/Model/Image_Picker/image_pick_from_device.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Pick_User_Image_From_Device_Bloc/pick_user_image_from_device_bloc.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Update_User_Profile_Image_Bloc/update_user_profile_image_bloc.dart';
import 'package:chatty/View_Models/Navigation/on_generate_route_navigation.dart';
import 'package:chatty/Views/Screens/chat_main_page_design.dart';
import 'package:chatty/Views/Screens/splash_screen.dart';
import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_Received_to_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_send_from_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_list_tile.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/update_user_profile.dart';
import 'package:chatty/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        home: const UpdateUserProfileDataScreen(),
      ),
    );
  }
}

class ImageTest extends StatelessWidget {
  const ImageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    File? image = await ImagePickFromDevice.pickImageFromDevice(
                        ImagePickFromDevice.gallerySelected);
                  },
                  child: const Text("Pick Image")),
            )
          ],
        ),
      ),
    );
  }
}


/// Text(
                        //   "10:25 pm",
                        //   style: TextStyle(
                        //     color: Colors.cyan,
                        //   ),
                        // )


/**
 * 
 * Platform  Firebase App Id
web       1:399624615138:web:a7da05db4cb10babe6dabb
android   1:399624615138:android:4a23ae3c7e4f54a7e6dabb
ios       1:399624615138:ios:4c02311c1a3041fde6dabb
macos     1:399624615138:ios:4c02311c1a3041fde6dabb
windows   1:399624615138:web:6a155522adeb4a9ce6dabb


 */