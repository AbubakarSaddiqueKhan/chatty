import 'dart:convert';

import 'package:chatty/Model/chat_detail_model.dart';
import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Notifications/local_notifications_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class FirebaseCloudMessagingService {
  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();
  static const String fcmMessageSendingURL =
      "https://fcm.googleapis.com/fcm/send";

  static const String serverKey =
      "AAAAXQt7tOI:APA91bEpX7p6BVnVuP9ajZRUs0QHX_z6HM1AhiL0taQYzPVRbtF9IdgO2cCglsyU3OGv9r1dFuD_lUwcOf8QJPf45kQTmnzh7erXJfCkMpkJuNewDWsIxkhk6mC-PHrQ9Be-mfAmvoMz";

  static const String keySenderPhoneNumber = "sender_phone_number";
  static const String keyReceiverPhoneNumber = "receiver_phone_number";
  static const String keyMessageDetail = "message";
  static const String keyTimeStamp = "time_stamp";
  // static const String keyIsReceivedMessage = "is_received_message";

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> getUserDeviceToken() async {
    String? userDeviceToken = await firebaseMessaging.getToken();

    if (userDeviceToken != null || userDeviceToken!.isNotEmpty) {
      return userDeviceToken;
    } else {
      return null;
    }
  }

  void handleFCMForegroundMessages() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) async {
        developer.log("Foreground Message received");
        print("Foreground Message received");

        if (remoteMessage.notification != null) {
          print(
              "Received a foreground message ...... \n  Title  : ${remoteMessage.notification!.title} \n Body  ... ${remoteMessage.notification!.body}");

          developer.log(
              "Received a foreground message ...... \n  Title  : ${remoteMessage.notification!.title} \n Body  ... ${remoteMessage.notification!.body}  ... data ... ${remoteMessage.data.toString()} ... sender phone no : ${remoteMessage.data["sender_phone_number"]}");

          ChatDetailModel chatDetailModel = ChatDetailModel(
              senderPhoneNumber: remoteMessage.data[keySenderPhoneNumber],
              receiverPhoneNumber: remoteMessage.data[keyReceiverPhoneNumber],
              message: remoteMessage.data[keyMessageDetail],
              timeStamp: remoteMessage.data[keyTimeStamp],
              isReceivedMessage: true);

          developer
              .log("Recieved Message data ... ${chatDetailModel.toString()}");

          await fireBaseFireStoreDatBase
              .addReceivedMessageChatToFirebaseFirestore(
                  chatDetailData: chatDetailModel);
          // LocalNotificationsService localNotificationsService =
          //     LocalNotificationsService();
          // localNotificationsService.showFCMNotificationOnDevice(
          //     remoteMessage: remoteMessage);
        }
      },
    );
  }

  void checkNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> sendFCMMessageSendToGivenUserContactPhoneNumber(
      {required UserContactDetail senderDetailData,
      required UserContactDetail receiverDetailData,
      required String message}) async {
    DateTime currentTimeStamp = DateTime.now();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final data = {
      "to": receiverDetailData.userDeviceToken,
      "notification": {
        "title":
            "${senderDetailData.userFirstName}${senderDetailData.userLastName}",
        "body": message
      },
      "data": {
        keySenderPhoneNumber: senderDetailData.userPhoneNumber,
        keyReceiverPhoneNumber: receiverDetailData.userPhoneNumber,
        keyMessageDetail: message,
        keyTimeStamp: currentTimeStamp.toString(),
      },
    };

    final response = await http.post(Uri.parse(fcmMessageSendingURL),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      print("Message send successfulyy .... ");
      developer.log("Message send successfulyy .... ");
    } else {
      print('Failed to send FCM message');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      developer.log('Failed to send FCM message');
      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');
    }
  }
}
