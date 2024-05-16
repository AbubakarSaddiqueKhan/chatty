import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Display_User_Chat_Contacts_Data_Bloc/display_user_chat_contacts_data_bloc.dart';
import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Update_User_Contact_Length_Bloc/update_user_contacts_length_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Screens/chat_detailed_page_design.dart';
import 'package:chatty/Views/Screens/find_user_screen.dart';
import 'package:chatty/Views/Screens/otp_verifying_screen.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_list_tile.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_local_data_list_tile.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/navigate_to_next_page_chat_main_page_custom_button.dart';
import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/user_profile_image_bloc_builder_widget.dart';
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

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
        SharedPreferenceLocalDataBase();
    userMobileNumber = await sharedPreferenceLocalDataBase
        .fetchUserPhoneNumberFromLocalDatabase();

    FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
        FireBaseFireStoreDatBase();
    bool isUserContactAdded = await fireBaseFireStoreDatBase
        .checkUserContactsExistence(userMobileNumber: userMobileNumber!);

    print("is................... $isUserContactAdded");

    if (isUserContactAdded) {
      print("start findingg contacts ....");

      context
          .read<UpdateUserContactsLengthBloc>()
          .add(UpdateUserContactListFromGivenFirebaseContactListEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  "Chatty",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.blueGrey.shade200, width: 2)),
                child: const Expanded(
                  child: TextField(
                    cursorColor: Colors.blueGrey,
                    cursorHeight: 15,
                    style: TextStyle(color: Colors.blueGrey),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.search,
                          color: Colors.blueGrey,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Search",
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<UpdateUserContactsLengthBloc,
                UpdateUserContactsLengthState>(
              builder: (context, state) {
                if (state is UpdateUserContactsLengthInitialState) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.4,
                          width: width,
                        ),
                        const Text(
                          "Add User to start chatting with him / her",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is UpdateUserContactsLengthLoadingState) {
                  return Column(
                    children: [
                      SizedBox(
                        height: height * 0.4,
                        width: width,
                      ),
                      const CircularProgressIndicator(
                        color: Colors.cyan,
                        strokeWidth: 5,
                      ),
                    ],
                  );
                } else if (state is UpdateUserContactsLengthLoadedState) {
                  context.read<DisplayUserChatContactsDataBloc>().add(
                      FetchAllUserContactDataFromFireStoreEvent(
                          userContactPhoneNumberList:
                              state.userContactPhoneNumberList));
                  List<String> userContactPhoneNumbersList =
                      state.userContactPhoneNumberList;
                  return BlocBuilder<DisplayUserChatContactsDataBloc,
                      DisplayUserChatContactsDataState>(
                    builder: (context, state) {
                      if (state is DisplayUserChatContactsDataInitialState) {
                        return SizedBox(
                            width: width,
                            height: height * 0.86,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: userContactPhoneNumbersList.length,
                              itemBuilder: (context, index) => const Row(
                                children: [
                                  Expanded(
                                      flex: 80,
                                      child: ChatMainPageLocalDataListTile()),
                                  Expanded(
                                      flex: 20,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "12:10 am",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.cyan),
                                        ),
                                      ))
                                ],
                              ),
                            ));
                      } else if (state
                          is DisplayUserChatContactsDataLoadingState) {
                        return Column(
                          children: [
                            SizedBox(
                              height: height * 0.4,
                              width: width,
                            ),
                            const CircularProgressIndicator(
                              color: Colors.lightBlueAccent,
                              strokeWidth: 5,
                            ),
                          ],
                        );
                      } else if (state
                          is DisplayUserChatContactsDataLoadedState) {
                        return SizedBox(
                            width: width,
                            height: height * 0.86,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.userContactDetailList.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  developer.log(
                                      "Clicked on  ...... ${state.userContactDetailList[index].userFirstName}");

                                  Navigator.of(context).pushNamed(
                                      ChatDetailedScreen.pageName,
                                      arguments:
                                          state.userContactDetailList[index]);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 80,
                                        child:
                                            ChatMainPageCustomUserDataListTile(
                                          userContactDetailData: state
                                              .userContactDetailList[index],
                                        )),
                                    const Expanded(
                                        flex: 20,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            "12:10 am",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.cyan),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ));
                      } else {
                        return SizedBox(
                            width: width,
                            height: height * 0.86,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: userContactPhoneNumbersList.length,
                              itemBuilder: (context, index) => const Row(
                                children: [
                                  Expanded(
                                      flex: 80,
                                      child: ChatMainPageLocalDataListTile()),
                                  Expanded(
                                      flex: 20,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "12:10 am",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.cyan),
                                        ),
                                      ))
                                ],
                              ),
                            ));
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Something went wrong at our side we are trying to manage it . Please wait sometime",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.cyan,
                      ),
                    ),
                  );
                }
              },
            )
          ],
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
