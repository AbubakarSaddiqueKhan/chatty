import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/display_user_chat_contact_main_bloc_builder_widget.dart';
import 'package:flutter/material.dart';

class ChatMainPageAllWidgets extends StatelessWidget {
  const ChatMainPageAllWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Column(
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
                border: Border.all(color: Colors.blueGrey.shade200, width: 2)),
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
        const DisplayUserChatContactMainBlocBuilderWidget()
      ],
    );
  }
}
