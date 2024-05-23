import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_All_Chats_Of_Given_User_Bloc/fetch_all_chat_of_given_user_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/Views/Screens/Chat_Screens/update_user_profile_screen.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Detailed_Screen_Widgets/message_received_to_user_custom_widget.dart';
import 'package:chatty/Views/Widgets/Chat_Widgets/Chat_Detailed_Screen_Widgets/message_send_from_user_custom_widget.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAllChatCustomBlocBuilderWidget extends StatefulWidget {
  const FetchAllChatCustomBlocBuilderWidget(
      {super.key,
      required this.userContactDetail,
      required this.userImageUrl,
      required this.userPhoneNumber});
  final UserContactDetail userContactDetail;
  final String userPhoneNumber;
  final String userImageUrl;

  @override
  State<FetchAllChatCustomBlocBuilderWidget> createState() =>
      _FetchAllChatCustomBlocBuilderWidgetState();
}

class _FetchAllChatCustomBlocBuilderWidgetState
    extends State<FetchAllChatCustomBlocBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAllChatOfGivenUserBloc,
        FetchAllChatOfGivenUserState>(
      builder: (context, state) {
        if (state is FetchAllChatOfGivenUserInitialState) {
          context.read<FetchAllChatOfGivenUserBloc>().add(
              FetchAllChatsOfUserFromFirebaseFirestoreEvent(
                  userPhoneNumber: widget.userPhoneNumber,
                  chatPersonPhoneNumber:
                      widget.userContactDetail.userPhoneNumber));

          return const SizedBox.shrink();
        } else if (state is FetchAllChatOfGivenUserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: Colors.cyan,
            ),
          );
        } else if (state is FetchAllChatOfGivenUserLoadedState) {
          if (state.allChatsOfUserList.isEmpty) {
            return const Center(
                child: Text(
              "No chat found",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.cyan, fontSize: 24),
            ));
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.allChatsOfUserList.length,
              itemBuilder: (context, index) {
                if (state.allChatsOfUserList[index].isReceivedMessage ==
                    false) {
                  return MessageSendFromUserCustomWidget(
                    userImageUrl: widget.userImageUrl,
                    message: state.allChatsOfUserList[index].message,
                  );
                } else {
                  return MessageReceivedToUserCustomWidget(
                      userContactImageUrl:
                          widget.userContactDetail.userImageUrl,
                      message: state.allChatsOfUserList[index].message);
                }
              },
            );
          }
        } else {
          return const Text(
            "Some Thing went wrong at our side . We are trying to fix it ",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 16),
          );
        }
      },
    );
  }
}
