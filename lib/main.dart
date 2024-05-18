import 'package:chatty/Model/chat_detail_model.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Update_User_Profile_Image_Bloc/update_user_profile_image_bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Messaging_Service/firebase_cloud_messaging_service.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Navigation/on_generate_route_navigation.dart';
import 'package:chatty/View_Models/Notifications/local_notifications_service.dart';
import 'package:chatty/Views/Screens/splash_screen.dart';
import 'package:chatty/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  handleBackgroundFCMNotification();

  runApp(const MyApp());

  FirebaseCloudMessagingService firebaseCloudMessagingService =
      FirebaseCloudMessagingService();
  firebaseCloudMessagingService.handleFCMForegroundMessages();
  firebaseCloudMessagingService.checkNotificationPermission();
}

@pragma("vm entry-point")
void handleBackgroundFCMNotification() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  ChatDetailModel chatDetailModel = ChatDetailModel(
      senderPhoneNumber: remoteMessage.data["sender_phone_number"],
      receiverPhoneNumber: remoteMessage.data["receiver_phone_number"],
      message: remoteMessage.data["message"],
      timeStamp: remoteMessage.data["time"],
      isReceivedMessage: true);

  await FireBaseFireStoreDatBase().addReceivedMessageChatToFirebaseFirestore(
      chatDetailData: chatDetailModel);

  print("Background Notification Title : ${remoteMessage.notification!.title}");
  print("Background Notification Body : ${remoteMessage.notification!.body}");
  // print("Handling a background message: ${remoteMessage.messageId}");

  LocalNotificationsService localNotificationsService =
      LocalNotificationsService();
  localNotificationsService.showFCMNotificationOnDevice(
      remoteMessage: remoteMessage);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    void localNotificationAllSettings(
        {required RemoteMessage remoteMessage}) async {
      // Local Notification .

      LocalNotificationsService localNotificationsService =
          LocalNotificationsService();
      localNotificationsService.initializeSettings(
          context: context, remoteMessage: remoteMessage);

      localNotificationsService.openChatMainPageOnNotificationClick(
          context: context);
    }

    return BlocProvider(
      create: (context) => UpdateUserProfileImageBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashScreen.pageName,
      ),
    );
  }
}

/**
 * 
 * Platform  Firebase App Id
web       1:399624615138:web:a7da05db4cb10babe6dabb
android   1:399624615138:android:4a23ae3c7e4f54a7e6dabb
ios       1:399624615138:ios:4c02311c1a3041fde6dabb
macos     1:399624615138:ios:4c02311c1a3041fde6dabb
windows   1:399624615138:web:6a155522adeb4a9ce6dabb


 */
