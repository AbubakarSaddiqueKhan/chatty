import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Display_User_Chat_Contacts_Data_Bloc/display_user_chat_contacts_data_bloc.dart';
import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Update_User_Contact_Length_Bloc/update_user_contacts_length_bloc.dart';
import 'package:chatty/View_Models/Custom_Codes/zego_cloud_send_call_invitation_custom_code.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Screens/Chat_Screens/chat_detailed_page_design.dart';
import 'package:chatty/Views/Screens/Chat_Screens/find_user_screen.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Main_Page_Widgets/chat_main_page_all_widgets.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_list_tile.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_local_chat_list.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_user_chat_buddies_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Main_Page_Widgets/chat_main_page_local_data_list_tile.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Main_Page_Widgets/display_user_chat_contact_main_bloc_builder_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Main_Page_Widgets/display_user_chat_contacts_bloc_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class ChatMainPageDesign extends StatefulWidget {
  const ChatMainPageDesign({super.key});
  static const String pageName = "/chatMainPageDesign";

  @override
  State<ChatMainPageDesign> createState() => _ChatMainPageDesignState();
}

class _ChatMainPageDesignState extends State<ChatMainPageDesign> {
  late String? userMobileNumber;

  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();

  @override
  void initState() {
    super.initState();

    fireBaseFireStoreDatBase.listenToAnyChangeInUserContactCollection(
        context: context);
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
        SharedPreferenceLocalDataBase();
    userMobileNumber = await sharedPreferenceLocalDataBase
        .fetchUserPhoneNumberFromLocalDatabase();

    Map<String, dynamic>? currentUserData = await fireBaseFireStoreDatBase
        .fetchDataOfGivenPhoneNumber(phoneNumber: userMobileNumber!);

    String curentUserName =
        currentUserData?[FireBaseFireStoreDatBase.keyUserFirstName];

    // print("is................... $isUserContactAdded");

    await listenToCallInvitationReceived(context: context);

    // connectUser(userMobileNumber!, "Developer");
    await connectUser(userMobileNumber!, curentUserName);

    // await listenToTheCalleeResponse(context: context,callReceiverPhoneNumber: "03038738355" ,callSenderName:  ,callSenderPhoneNumber: userMobileNumber!);

    await listenToCallInvitationReceived(context: context);

    await listenToTheCalleeResponse(
      context: context,
    );
    // if (isUserContactAdded) {
    //   print("start findingg contacts ....");
    //   if (mounted) {
    //     // context
    //     //     .read<UpdateUserContactsLengthBloc>()
    //     //     .add(UpdateUserContactListFromGivenFirebaseContactListEvent());

    //     developer.log("Need to be update length ...");
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ChatMainPageAllWidgets()],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.grey.shade300,
        onPressed: () {
          Navigator.of(context).pushNamed(FindUserScreen.pageName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
