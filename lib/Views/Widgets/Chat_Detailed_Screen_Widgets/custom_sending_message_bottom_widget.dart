import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/send_fcm_message_custom_icon_button_widget.dart';
import 'package:flutter/material.dart';

class CustomSendingMessageBottomWidget extends StatelessWidget {
  const CustomSendingMessageBottomWidget(
      {super.key,
      required this.sendMessageTextEditingController,
      required this.userContactDetail});
  final TextEditingController sendMessageTextEditingController;
  final UserContactDetail userContactDetail;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Expanded(
      flex: 8,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
        child: Container(
          width: width,
          height: height * 0.07,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22.5),
                  bottomLeft: Radius.circular(22.5))),
          child: Expanded(
              child: Row(
            children: [
              Expanded(
                  flex: 85,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(22.5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        )),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Colors.cyan,
                                )),
                          ),
                          Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: TextField(
                                  maxLines: null,
                                  controller: sendMessageTextEditingController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.link_outlined,
                                    color: Colors.cyan,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.cyan,
                                  )))
                        ],
                      )),
                    ),
                  )),
              Expanded(
                  flex: 15,
                  child: SendFcmMessageCustomIconButtonWidget(
                      sendMessageTextEditingController:
                          sendMessageTextEditingController,
                      userContactDetail: userContactDetail))
            ],
          )),
        ),
      ),
    );
  }
}
