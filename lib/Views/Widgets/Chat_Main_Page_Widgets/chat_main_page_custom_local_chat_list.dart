import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_local_data_list_tile.dart';
import 'package:flutter/material.dart';

class ChatMainPageCustomLocalChatList extends StatelessWidget {
  const ChatMainPageCustomLocalChatList(
      {super.key, required this.userContactPhoneNumbersList});
  final List<String> userContactPhoneNumbersList;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
        width: width,
        height: height * 0.86,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: userContactPhoneNumbersList.length,
          itemBuilder: (context, index) => const Row(
            children: [
              Expanded(flex: 80, child: ChatMainPageLocalDataListTile()),
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
}
