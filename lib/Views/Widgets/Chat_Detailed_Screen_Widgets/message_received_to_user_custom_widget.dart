import 'package:chatty/Views/Widgets/Update_User_Profile_Widgets/user_profile_image_bloc_builder_widget.dart';
import 'package:flutter/material.dart';

class MessageReceivedToUserCustomWidget extends StatelessWidget {
  const MessageReceivedToUserCustomWidget(
      {super.key, required this.userContactImageUrl, required this.message});
  final String userContactImageUrl;
  final String message;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.125,
            height: height * 0.1,
          ),
          SizedBox(
            width: width * 0.875,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 85,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(message),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 15,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 1),
                      child: Container(
                        width: width,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(userContactImageUrl),
                                fit: BoxFit.contain),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 1)),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
