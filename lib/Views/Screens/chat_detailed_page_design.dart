import 'package:chatty/Model/chat_detail_model.dart';
import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_All_Chats_Of_Given_User_Bloc/fetch_all_chat_of_given_user_bloc.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_User_Data_From_Firestore_Bloc/fetch_user_data_from_firestore_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Messaging_Service/firebase_cloud_messaging_service.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Screens/find_user_screen.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/custom_sending_message_bottom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/display_user_all_chats_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/fetch_all_chat_custom_bloc_builder_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_received_to_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_send_from_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/send_fcm_message_custom_icon_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class ChatDetailedScreen extends StatefulWidget {
  const ChatDetailedScreen({super.key});
  static const String pageName = "/chatDetailedPage";

  @override
  State<ChatDetailedScreen> createState() => _ChatDetailedScreenState();
}

class _ChatDetailedScreenState extends State<ChatDetailedScreen> {
  late TextEditingController sendMessageTextEditingController;
  late UserContactDetail userContactDetail;
  FirebaseCloudMessagingService firebaseCloudMessagingService =
      FirebaseCloudMessagingService();

  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();

  double bottomPadding = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendMessageTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    sendMessageTextEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    userContactDetail =
        ModalRoute.of(context)!.settings.arguments as UserContactDetail;

    context
        .read<FetchUserDataFromFirestoreBloc>()
        .add(const FetchUserAllDataFromFirebaseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.cyan,
            )),
        title: Text(
          userContactDetail.userFirstName,
          style: const TextStyle(
            color: Colors.cyan,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.cyan,
              ))
        ],
      ),
      body: Stack(
        // mainAxisAlignment: mains,
        children: [
          DisplayUserAllChatsCustomWidget(userContactDetail: userContactDetail),
          Positioned(
            left: 0,
            bottom: bottomPadding,
            right: 0,
            child: CustomSendingMessageBottomWidget(
                sendMessageTextEditingController:
                    sendMessageTextEditingController,
                userContactDetail: userContactDetail),
          )
        ],
      ),
    );
  }
}
