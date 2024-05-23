import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:flutter/material.dart';

class ChatMainPageCustomUserDataListTile extends StatelessWidget {
  const ChatMainPageCustomUserDataListTile(
      {super.key, required this.userContactDetailData});
  final UserContactDetail userContactDetailData;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
      width: width,
      height: height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: height * 0.09,
              width: height * 0.09,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(userContactDetailData.userImageUrl),
                      fit: BoxFit.contain),
                  border: Border.all(width: 1, color: Colors.blueGrey)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userContactDetailData.userFirstName,
                  style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  ".....",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
