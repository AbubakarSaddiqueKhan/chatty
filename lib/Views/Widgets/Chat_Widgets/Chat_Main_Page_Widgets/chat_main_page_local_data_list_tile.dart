import 'package:flutter/material.dart';

class ChatMainPageLocalDataListTile extends StatelessWidget {
  const ChatMainPageLocalDataListTile({super.key});

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
                  image: const DecorationImage(
                      image: AssetImage("assets/images/user.png"),
                      fit: BoxFit.cover),
                  border: Border.all(width: 1, color: Colors.blueGrey)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Developer",
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Assalam O Alaikum",
                  style: TextStyle(
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
