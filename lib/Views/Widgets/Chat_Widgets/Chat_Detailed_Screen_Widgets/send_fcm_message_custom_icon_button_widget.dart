import 'package:chatty/Model/chat_detail_model.dart';
import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_User_Data_From_Firestore_Bloc/fetch_user_data_from_firestore_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Messaging_Service/firebase_cloud_messaging_service.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class SendFcmMessageCustomIconButtonWidget extends StatelessWidget {
  const SendFcmMessageCustomIconButtonWidget(
      {super.key,
      required this.sendMessageTextEditingController,
      required this.userContactDetail});
  final TextEditingController sendMessageTextEditingController;
  final UserContactDetail userContactDetail;

  @override
  Widget build(BuildContext context) {
    FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
        FireBaseFireStoreDatBase();
    FirebaseCloudMessagingService firebaseCloudMessagingService =
        FirebaseCloudMessagingService();
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: BlocBuilder<FetchUserDataFromFirestoreBloc,
          FetchUserDataFromFirestoreState>(
        builder: (context, state) {
          if (state is FetchUserDataFromFirestoreInitialState) {
            return const Icon(
              Icons.send,
              color: Colors.cyan,
            );
          } else if (state is FetchUserDataFromFirestoreLoadingState) {
            return const Icon(
              Icons.send,
              color: Colors.cyan,
            );
          } else if (state is FetchUserDataFromFirestoreLoadedState) {
            String currentDateTime = DateTime.now().toString();

            return IconButton(
                onPressed: () async {
                  if (sendMessageTextEditingController.text.isNotEmpty) {
                    ChatDetailModel chatDetailData = ChatDetailModel(
                        senderPhoneNumber: state.userData.userPhoneNumber,
                        receiverPhoneNumber: userContactDetail.userPhoneNumber,
                        message: sendMessageTextEditingController.text,
                        timeStamp: currentDateTime,
                        isReceivedMessage: false);

                    developer.log(
                        "Data in chatttt firestore .... ${chatDetailData.toString()}");

                    await fireBaseFireStoreDatBase.addChatToFirebaseFirestore(
                        chatDetailData: chatDetailData);

                    developer.log("Sending message ....");

                    await firebaseCloudMessagingService
                        .sendFCMMessageSendToGivenUserContactPhoneNumber(
                            senderDetailData: state.userData,
                            receiverDetailData: userContactDetail,
                            message: sendMessageTextEditingController.text);

                    sendMessageTextEditingController.clear();
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.cyan,
                ));
          } else {
            return const Icon(
              Icons.send,
              color: Colors.deepOrange,
            );
          }
        },
      ),
    );
  }
}
