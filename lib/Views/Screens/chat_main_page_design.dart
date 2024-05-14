import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_list_tile.dart';
import 'package:flutter/material.dart';

class ChatMainPageDesign extends StatelessWidget {
  const ChatMainPageDesign({super.key});
  static const String pageName = "/chatMainPageDesign";

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(
                width: width,
                height: height * 0.86,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) => const Row(
                    children: [
                      Expanded(flex: 80, child: ChatMainPageCustomListTile()),
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
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.grey.shade300,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
