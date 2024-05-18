import 'package:chatty/Views/Screens/chat_main_page_design.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_local_data_list_tile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void initializeSettings(
      {required BuildContext context, required RemoteMessage remoteMessage}) {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // this function is called when user click on the notification when app is on the foreground  .

      onDidReceiveNotificationResponse: (details) {
        handleNotificationClick(context: context, remoteMessage: remoteMessage);
      },
    );
  }

  void showFCMNotificationOnDevice(
      {required RemoteMessage remoteMessage}) async {
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel("FCM Notifications", "FCM",
            importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            androidNotificationChannel.id, androidNotificationChannel.name,
            importance: Importance.high,
            priority: Priority.high,
            ticker: "Ticker");

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(
      Duration.zero,
      () {
        flutterLocalNotificationsPlugin.show(
            1,
            remoteMessage.notification!.title,
            remoteMessage.notification!.body,
            notificationDetails);
      },
    );
  }

// Navigate to chat main page when app is in foreground .

  void handleNotificationClick(
      {required BuildContext context,
      required RemoteMessage remoteMessage}) async {
    Navigator.of(context).pushNamed(ChatMainPageDesign.pageName);
  }

  // this function is called to on the notification click when the app is in the background or terminated .

  void openChatMainPageOnNotificationClick(
      {required BuildContext context}) async {
    Future<void> setupInteractedMessage() async {
      // Get any messages which caused the application to open from
      // a terminated state.

      RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (remoteMessage != null) {
        handleNotificationClick(context: context, remoteMessage: remoteMessage);
      }

      // Also handle any interaction when the app is in the background via a
      // Stream listener

      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage remoteMessage) {
          handleNotificationClick(
              context: context, remoteMessage: remoteMessage);
        },
      );
    }
  }
}
