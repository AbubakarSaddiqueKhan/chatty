import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Display_User_Chat_Contacts_Data_Bloc/display_user_chat_contacts_data_bloc.dart';
import 'package:chatty/Views/Screens/chat_detailed_page_design.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class ChatMainPageCustomUserChatBuddiesWidget extends StatelessWidget {
  const ChatMainPageCustomUserChatBuddiesWidget(
      {super.key, required this.state});
  final DisplayUserChatContactsDataLoadedState state;

  @override
  Widget build(BuildContext context) {
    String currentDateTime =
        "${DateTime.now().hour} : ${DateTime.now().minute}";
    final Size(:width, :height) = MediaQuery.sizeOf(context);
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

              Navigator.of(context).pushNamed(ChatDetailedScreen.pageName,
                  arguments: state.userContactDetailList[index]);
            },
            child: Row(
              children: [
                Expanded(
                    flex: 80,
                    child: ChatMainPageCustomUserDataListTile(
                      userContactDetailData: state.userContactDetailList[index],
                    )),
                Expanded(
                    flex: 20,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        currentDateTime,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.cyan, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
