import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_User_Data_From_Firestore_Bloc/fetch_user_data_from_firestore_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/SendVideoCallInvitationBloc/send_video_call_invitation_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Messaging_Service/firebase_cloud_messaging_service.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Detailed_Screen_Widgets/custom_sending_message_bottom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Detailed_Screen_Widgets/display_user_all_chats_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class ChatDetailedScreen extends StatefulWidget {
  const ChatDetailedScreen({super.key});
  static const String pageName = "/chatDetailedPage";

  @override
  State<ChatDetailedScreen> createState() => _ChatDetailedScreenState();
}

class _ChatDetailedScreenState extends State<ChatDetailedScreen> {
  late String? userMobileNumber;
  late String userFirstName;
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

    SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
        SharedPreferenceLocalDataBase();
    userMobileNumber = await sharedPreferenceLocalDataBase
        .fetchUserPhoneNumberFromLocalDatabase();

    if (userMobileNumber != null) {
      if (userMobileNumber!.isNotEmpty) {
        Map<String, dynamic>? contactData = await fireBaseFireStoreDatBase
            .fetchDataOfGivenPhoneNumber(phoneNumber: userMobileNumber!);

        userFirstName = contactData?[FireBaseFireStoreDatBase.keyUserFirstName];
      }
    }
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
          BlocListener<SendVideoCallInvitationBloc,
              SendVideoCallInvitationState>(
            listener: (context, state) {
              if (state is SendVideoCallInvitationInitialState) {
                developer.log("Sending invitation");
              } else if (state is SendVideoCallInvitationLoadedState) {
              } else {
                developer.log("Error in sending invitation");
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () async {
                    context.read<SendVideoCallInvitationBloc>().add(
                        SendVideoCallInvitationToGivenUserEvent(
                            invitationSenderPhoneNumber: userMobileNumber!,
                            invitationSenderName: userFirstName,
                            context: context,
                            invitationReceiverPhoneNumber:
                                userContactDetail.userPhoneNumber));
                  },
                  icon: const Icon(
                    Icons.video_call_outlined,
                    color: Colors.cyan,
                  )),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          DisplayUserAllChatsCustomWidget(userContactDetail: userContactDetail),
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
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
