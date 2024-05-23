import 'package:chatty/Model/chat_detail_model.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_All_Chats_Of_Given_User_Bloc/fetch_all_chat_of_given_user_bloc.dart';
import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Update_User_Contact_Length_Bloc/update_user_contacts_length_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Messaging_Service/firebase_cloud_messaging_service.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

class FireBaseFireStoreDatBase {
  List<String> userContactNumberList = [];
  List<ChatDetailModel> allChatDetailDataList = [];

  // Collections .
  // Main Collections .

  static const String userMainCollection = "users";
  static const String chatMainCollection = "chats";

  // Sub Collections .

  static const String userContactsSubCollection = "contacts";
  // Keys ..
  static const String keyUserFirstName = "user_first_name";
  static const String keyUserLastName = "user_last_name";
  static const String keyUserImageURL = "user_image_url";
  static const String keyUserPhoneNumber = "user_phone_number";
  static const String keyUserDeviceToken = "user_device_token";
  static const String keyUserContactPhoneNumber = "user_contact_phone_number";
  static const String keyMessageSender = "sender";
  static const String keyMessageReceiver = "receiver";
  static const String keyMessageDetail = "message";
  static const String keyMessageTimeStamp = "time";
  static const String keyIsReceivedMessage = "isReceivedMessage";

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // add data to firestore .
  Future<void> addUserDatToFirebaseStorage(
      {required String userDeviceToken,
      required String userFirstName,
      required String userLastName,
      required String userPhoneNumber,
      required String userImageUrl}) async {
    try {
      await firebaseFirestore
          .collection(userMainCollection)
          .doc(userPhoneNumber)
          .set({
        keyUserFirstName: userFirstName,
        keyUserLastName: userLastName,
        keyUserImageURL: userImageUrl,
        keyUserPhoneNumber: userPhoneNumber,
        keyUserDeviceToken: userDeviceToken
      });

      developer.log("User data added");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> listenToAnyChangeInUserContactCollection(
      {required BuildContext context}) async {
    developer.log("Start listening to contact changes ....");
    SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
        SharedPreferenceLocalDataBase();
    String? currentUserPhoneNumber = await sharedPreferenceLocalDataBase
        .fetchUserPhoneNumberFromLocalDatabase();

    if (currentUserPhoneNumber != null) {
      if (currentUserPhoneNumber.isNotEmpty) {
        await firebaseFirestore
            .collection(userMainCollection)
            .doc(currentUserPhoneNumber)
            .collection(userContactsSubCollection)
            .snapshots()
            .listen(
          (event) {
            // for (var i = 1; i <= event.docs.length; i++) {
            //   if (i == event.docs.length) {
            //     developer.log(
            //         "Chnage in contacts .... ${event.docs.last.data().toString()}");
            //   }
            // }

            context
                .read<UpdateUserContactsLengthBloc>()
                .add(UpdateUserContactListFromGivenFirebaseContactListEvent());

            // for (var change in event.docs.last) {

            // context.read<UpdateUserContactsLengthBloc>().add(
            //     UpdateUserContactListFromGivenFirebaseContactListEvent());
            // }
          },
        );
      }
    }
  }

  Future<void> listenToAnyChangeInChatWithCurrentChatPerson(
      {required BuildContext context,
      required String currentChatContactPhoneNumber}) async {
    developer.log("Start listening to chat changes ....");

    SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
        SharedPreferenceLocalDataBase();
    String? currentUserPhoneNumber = await sharedPreferenceLocalDataBase
        .fetchUserPhoneNumberFromLocalDatabase();

    if (currentUserPhoneNumber != null) {
      if (currentUserPhoneNumber.isNotEmpty) {
        await firebaseFirestore
            .collection(chatMainCollection)
            .doc(currentUserPhoneNumber)
            .collection(currentChatContactPhoneNumber)
            .snapshots()
            .listen(
          (event) {
            context.read<FetchAllChatOfGivenUserBloc>().add(
                FetchAllChatsOfUserFromFirebaseFirestoreEvent(
                    userPhoneNumber: currentUserPhoneNumber,
                    chatPersonPhoneNumber: currentChatContactPhoneNumber));
            for (var change in event.docs) {
              developer.log(
                  "Current chat changess .... ${change.data().toString()}");
            }
          },
        );
      }
    }
  }

  Future<void> addUserChatBuddyContact(
      {required String contactPhoneNumber,
      required String userPhoneNumber}) async {
    try {
      await firebaseFirestore
          .collection(userMainCollection)
          .doc(userPhoneNumber)
          .collection(userContactsSubCollection)
          .doc(contactPhoneNumber)
          .set({keyUserContactPhoneNumber: contactPhoneNumber});
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllChatContacts({required String phoneNumber}) async {
    DocumentSnapshot<Map<String, dynamic>> fethchDocumentsData =
        await firebaseFirestore
            .collection(userMainCollection)
            .doc(phoneNumber)
            .get();

    developer.log("Dtaaa ...... ${fethchDocumentsData.data().toString()}");
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> findUserFromGivenPhoneNumber(
      {required String contactPhoneNumber}) async {
    try {
      Query<Map<String, dynamic>>? checkUserExistence =
          await firebaseFirestore.collection(userMainCollection).where(
                keyUserPhoneNumber,
                isEqualTo: contactPhoneNumber,
              );

      if (checkUserExistence != null) {
        QuerySnapshot<Map<String, dynamic>> userData =
            await checkUserExistence.get();
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> checkUserContactsExistence(
      {required String userMobileNumber}) async {
    final querySnapshot = await firebaseFirestore
        .collection(userMainCollection)
        .doc(userMobileNumber)
        .collection(userContactsSubCollection)
        .get();
    if (querySnapshot.docs.isEmpty) {
      developer.log("User does'nt added any contact yet ....");
      return false;
    } else {
      developer
          .log("User contact list length ... ${querySnapshot.docs.length}");
      return true;
    }
  }

  Future<bool> checkUserExistence({required String userMobileNumber}) async {
    final querySnapshot = await firebaseFirestore
        .collection(userMainCollection)
        .doc(userMobileNumber)
        .get();
    if (querySnapshot.exists) {
      developer.log("User Existasssss");
      return true;
    } else {
      developer.log("User not exisstssss");
      return false;
    }
  }

  Future<List<String>> fetchAllChatContactsOfGivenNumber(
      {required String userPhoneNumber}) async {
    developer.log("entereddddddddddddddddddd");
    QuerySnapshot<Map<String, dynamic>> userContactsData =
        await firebaseFirestore
            .collection(userMainCollection)
            .doc(userPhoneNumber)
            .collection(userContactsSubCollection)
            .get();

    for (var userData in userContactsData.docs) {
      developer.log("User data .... ${userData.data().toString()}");
      userContactNumberList.add(userData.data()[keyUserContactPhoneNumber]);
    }
    return userContactNumberList;
  }

  Future<Map<String, dynamic>?> fetchDataOfGivenPhoneNumber(
      {required String phoneNumber}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await firebaseFirestore
          .collection(userMainCollection)
          .doc(phoneNumber)
          .get();

      userData.data().toString();

      developer.log(
          "inputted phone number based  user data ....  ${userData.data().toString()}");

      return userData.data();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> addChatToFirebaseFirestore(
      {required ChatDetailModel chatDetailData}) async {
    developer.log("Entereddd......................");
    await firebaseFirestore
        .collection(chatMainCollection)
        .doc(chatDetailData.senderPhoneNumber)
        .collection(chatDetailData.receiverPhoneNumber)
        .doc(chatDetailData.timeStamp)
        .set({
      keyMessageSender: chatDetailData.senderPhoneNumber,
      keyMessageReceiver: chatDetailData.receiverPhoneNumber,
      keyMessageDetail: chatDetailData.message,
      keyMessageTimeStamp: chatDetailData.timeStamp,
      keyIsReceivedMessage: chatDetailData.isReceivedMessage
    });

    developer.log("Message added successfully to firebase fire store ......");
  }

  Future<void> addReceivedMessageChatToFirebaseFirestore(
      {required ChatDetailModel chatDetailData}) async {
    developer.log("Entereddd......In recieved message................");
    await firebaseFirestore
        .collection(chatMainCollection)
        .doc(chatDetailData.receiverPhoneNumber)
        .collection(chatDetailData.senderPhoneNumber)
        .doc(chatDetailData.timeStamp)
        .set({
      keyMessageSender: chatDetailData.senderPhoneNumber,
      keyMessageReceiver: chatDetailData.receiverPhoneNumber,
      keyMessageDetail: chatDetailData.message,
      keyMessageTimeStamp: chatDetailData.timeStamp,
      keyIsReceivedMessage: chatDetailData.isReceivedMessage
    });

    developer.log(
        "Recieved Message added successfully to firebase fire store ......");
  }

  Future<List<ChatDetailModel>> fetchAllChatsOfGivenContact(
      {required String userPhoneNumber,
      required String contactPhoneNumber}) async {
    QuerySnapshot<Map<String, dynamic>> allChatsOfContactData =
        await firebaseFirestore
            .collection(chatMainCollection)
            .doc(userPhoneNumber)
            .collection(contactPhoneNumber)
            .get();

    for (var chatDetailData in allChatsOfContactData.docs) {
      String messageSendPhoneNumber = chatDetailData.data()[keyMessageSender];
      String messageReceiverPhoneNumber =
          chatDetailData.data()[keyMessageReceiver];
      String message = chatDetailData.data()[keyMessageDetail];
      String messageTimeStamp = chatDetailData.data()[keyMessageTimeStamp];
      bool isReceivedMessage = chatDetailData.data()[keyIsReceivedMessage];

      ChatDetailModel chatDetailModel = ChatDetailModel(
          senderPhoneNumber: messageSendPhoneNumber,
          receiverPhoneNumber: messageReceiverPhoneNumber,
          message: message,
          timeStamp: messageTimeStamp,
          isReceivedMessage: isReceivedMessage);

      allChatDetailDataList.add(chatDetailModel);
    }

    return allChatDetailDataList;
  }
}
