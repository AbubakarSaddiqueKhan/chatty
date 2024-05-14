import 'package:flutter/material.dart';

class MessageSendFromUserCustomWidget extends StatelessWidget {
  const MessageSendFromUserCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.875,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 15,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 1),
                      child: Container(
                        width: width,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/images/user.png",
                                ),
                                fit: BoxFit.contain),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 2)),
                      ),
                    )),
                Expanded(
                    flex: 85,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Asslam O Alaikum"),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            width: width * 0.125,
            height: height * 0.1,
          )
        ],
      ),
    );
  }
}
