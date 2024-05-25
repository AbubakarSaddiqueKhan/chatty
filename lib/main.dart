import 'package:chatty/Model/chat_detail_model.dart';
import 'package:chatty/View_Models/Blocs/Update_User_Profile_Blocs/Update_User_Profile_Image_Bloc/update_user_profile_image_bloc.dart';
import 'package:chatty/View_Models/Custom_Codes/custom_permissions.dart';
import 'package:chatty/View_Models/Custom_Codes/zego_cloud_send_call_invitation_custom_code.dart';
import 'package:chatty/View_Models/Custom_Codes/zego_cloud_video_call_custom_code.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Messaging_Service/firebase_cloud_messaging_service.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Navigation/on_generate_route_navigation.dart';
import 'package:chatty/View_Models/Notifications/local_notifications_service.dart';
import 'package:chatty/Views/Screens/Chat_Screens/splash_screen.dart';
import 'package:chatty/Views/Screens/Zego_Cloud_Screens/video_call_main_page.dart';
import 'package:chatty/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zim/zego_zim.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  handleBackgroundFCMNotification();
  requestPermission();

  createEngine();
  createUser();

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
        // initialRoute: SplashScreen.pageName,
        home: const TestCallInvitation(),
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

class TestCallInvitation extends StatefulWidget {
  const TestCallInvitation({super.key});

  @override
  State<TestCallInvitation> createState() => _TestCallInvitationState();
}

class _TestCallInvitationState extends State<TestCallInvitation> {
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // connectUser(userMobileNumber!, "Developer");

    await connectUser("03072066828", "Home");

    // await connectUser("03038738355", "Abubakar");

    await listenToCallInvitationReceived(context: context);

    await listenToTheCalleeResponse(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () async {
                  // ZIMCallInvitationSentResult? zimCallInvitationSentResult =
                  // await sendVideoCallInvitationToGivenUser(
                  //     inviteePhoneNumber: "03038738355",
                  //     inviterPhoneNumber: "03072066828");

                  ZIMCallInvitationSentResult? zimCallInvitationSentResult =
                      await sendVideoCallInvitationToGivenUser(
                          inviteePhoneNumber: "03072066828",
                          inviterPhoneNumber: "03038738355");

                  (
                    String callSenderName,
                    String callSenderPhoneNumber,
                    String roomId,
                  ) videoCallDataRecord = (
                    // "Aziz Ur Rehman",
                    // "03072066828",
                    "Abubakar",
                    "03038738355",
                    zimCallInvitationSentResult!.callID
                  );

                  Navigator.of(context).pushNamed(VideoCallPage.pageName,
                      arguments: videoCallDataRecord);
                },
                child: const Text("Send Call Invitation"))
          ],
        ),
      ),
    );
  }
}

/**
 * 
 * 
 * 
 * ponse ... ZIMCallUserState.inviting
D/EGL_emulation( 5543): app_time_stats: avg=3762.88ms min=3762.88ms max=3762.88ms count=1
I/zego_jni( 5543): [2024-5-25 1:3:13:144][Verbose][Callback] OnCallUserStateChanged: call id: 16098170910976462697,call user info list:1
[log] Invitation response ... ZIMCallUserState.received
I/zego_jni( 5543): [2024-5-25 1:3:24:972][Verbose][Callback] OnCallUserStateChanged: call id: 16098170910976462697,call user info list:1
[log] Invitation response ... ZIMCallUserState.accepted


 * 
 */

class CallWaitingPage extends StatelessWidget {
  const CallWaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Call Waiting page",
              style: TextStyle(
                  color: Colors.brown,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}



/**
 * 
 * 
 * 
 * Exception has occurred.
FlutterError (Could not find a generator for route RouteSettings("/videoCallMainPage", (Abubakar , 03038738355, 7268972430574225697)) in the _WidgetsAppState.
Make sure your root app widget has provided a way to generate
this route.
Generators for routes are searched for in the following order:
 1. For the "/" route, the "home" property, if non-null, is used.
 2. Otherwise, the "routes" table is used, if it has an entry for the route.
 3. Otherwise, onGenerateRoute is called. It should return a non-null value for any valid route not handled by "home" and "routes".
 4. Finally if all else fails onUnknownRoute is called.
Unfortunately, onUnknownRoute was not set.)




 */