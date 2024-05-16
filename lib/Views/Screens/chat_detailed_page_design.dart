import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_User_Data_From_Firestore_Bloc/fetch_user_data_from_firestore_bloc.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_Received_to_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/message_send_from_user_custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailedScreen extends StatefulWidget {
  const ChatDetailedScreen({super.key});
  static const String pageName = "/chatDetailedPage";

  @override
  State<ChatDetailedScreen> createState() => _ChatDetailedScreenState();
}

class _ChatDetailedScreenState extends State<ChatDetailedScreen> {
  late UserContactDetail userContactDetail;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    userContactDetail =
        ModalRoute.of(context)!.settings.arguments as UserContactDetail;

    context
        .read<FetchUserDataFromFirestoreBloc>()
        .add(const FetchUserAllDataFromFirebaseEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.cyan,
            )),
        title: Text(
          userContactDetail.userFirstName,
          style: const TextStyle(
            color: Colors.cyan,
            fontSize: 22,
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
        child: Column(
          // mainAxisAlignment: mains,
          children: [
            Expanded(
              flex: 92,
              child: BlocBuilder<FetchUserDataFromFirestoreBloc,
                  FetchUserDataFromFirestoreState>(
                builder: (context, state) {
                  if (state is FetchUserDataFromFirestoreInitialState) {
                    return const SizedBox.shrink();
                  } else if (state is FetchUserDataFromFirestoreLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyan,
                        strokeWidth: 5,
                      ),
                    );
                  } else if (state is FetchUserDataFromFirestoreLoadedState) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 26,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          return MessageSendFromUserCustomWidget(
                            userImageUrl: state.userData.userImageUrl,
                          );
                        } else {
                          return MessageReceivedToUserCustomWidget(
                            userContactImageUrl: userContactDetail.userImageUrl,
                          );
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Something went wrong at our end . We are trying to fix it",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.cyan),
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                child: Container(
                  width: width,
                  height: height * 0.07,
                  color: Colors.grey.shade300,
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
                                  const Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: TextField(
                                          decoration: InputDecoration(
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
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.cyan,
                                )),
                          ))
                    ],
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
