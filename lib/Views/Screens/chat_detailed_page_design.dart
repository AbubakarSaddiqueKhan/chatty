import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_Received_to_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_send_from_user_custom_widget.dart';
import 'package:flutter/material.dart';

class ChatDetailedScreen extends StatelessWidget {
  const ChatDetailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.cyan,
            )),
        title: const Text(
          "Abubakar",
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 24,
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
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            if (index % 2 == 0) {
              return const MessageSendFromUserCustomWidget();
            } else {
              return const MessageReceivedToUserCustomWidget();
            }
          },
        ),
      ),
    );
  }
}
