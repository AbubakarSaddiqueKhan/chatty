import 'package:chatty/View_Models/Custom_Codes/zego_cloud_video_call_custom_code.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Screens/Zego_Cloud_Screens/video_call_main_page.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/imcoming_video_call_custom_dialog_widget.dart';
import 'package:chatty/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_zim/zego_zim.dart';
import 'dart:developer' as developer;

// Instance of zego cloud .
ZIM? zim = ZIM.getInstance();

Future<void> createUser() async {
  ZIM.create(
    ZIMAppConfig()
      ..appID = appID
      ..appSign = appSign,
  );
  developer.log("user created");
}

Future<void> connectUser(String userID, String userName) async {
  ZIMUserInfo userInfo = ZIMUserInfo();
  userInfo.userID = userID;
  userInfo.userName = userName;
  ZIMLoginConfig zimLoginConfig = ZIMLoginConfig();

  await zim?.login(userInfo.userID, zimLoginConfig);
  developer.log("User login successfully");
}

// sending calling invitation to user .

Future<ZIMCallInvitationSentResult?> sendVideoCallInvitationToGivenUser(
    {required String inviteePhoneNumber,
    required String inviterPhoneNumber}) async {
  ZIMCallInviteConfig zimCallInviteConfig = ZIMCallInviteConfig();
  String roomId = "$inviteePhoneNumber _ $inviterPhoneNumber";
  zimCallInviteConfig.extendedData = roomId;
  zimCallInviteConfig.mode = ZIMCallInvitationMode.advanced;

  ZIMCallInvitationSentResult? zimCallInvitationSentResult =
      await zim?.callInvite([inviteePhoneNumber], zimCallInviteConfig);

  return zimCallInvitationSentResult;
}

// decline or reject the incoming call invitation .

Future<ZIMCallRejectionSentResult?> rejectIncomingCallInvitation(
    {required String callID, required String roomId}) async {
  ZIMCallRejectConfig zimCallRejectConfig = ZIMCallRejectConfig();
  zimCallRejectConfig.extendedData = roomId;
  ZIMCallRejectionSentResult? zimCallRejectionSentResult =
      await zim?.callReject(callID, zimCallRejectConfig);

  return zimCallRejectionSentResult;
}

// Accept incoming call .

Future<ZIMCallAcceptanceSentResult?> acceptIncomingCallInvitation(
    {required String callId,
    required String roomId,
    required String callerReceiverPhoneNumber,
    required BuildContext context,
    required String callerReceiverName}) async {
  ZIMCallAcceptConfig zimCallAcceptConfig = ZIMCallAcceptConfig();
  zimCallAcceptConfig.extendedData = roomId;
  ZIMCallAcceptanceSentResult? zimCallAcceptanceSentResult =
      await zim?.callAccept(callId, zimCallAcceptConfig);

  SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
      SharedPreferenceLocalDataBase();
  String? currentUserPhoneNumber = await sharedPreferenceLocalDataBase
      .fetchUserPhoneNumberFromLocalDatabase();

  if (currentUserPhoneNumber != null) {
    if (currentUserPhoneNumber.isNotEmpty) {
      FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
          FireBaseFireStoreDatBase();
      Map<String, dynamic>? currentUserData = await fireBaseFireStoreDatBase
          .fetchDataOfGivenPhoneNumber(phoneNumber: currentUserPhoneNumber);

      String currentUserName =
          currentUserData?[FireBaseFireStoreDatBase.keyUserFirstName];

      (
        String callSenderName,
        String callSenderPhoneNumber,
        String roomId,
      ) videoCallDataRecord = (currentUserName, currentUserPhoneNumber, callId);

      Navigator.of(context)
          .pushNamed(VideoCallPage.pageName, arguments: videoCallDataRecord);
    }
  }
  return zimCallAcceptanceSentResult;
}

// The inviter want's to cancel the cancel before response of the callee .
Future<ZIMCallCancelSentResult?> cancelOngoingCall(
    {required String inviteePhoneNumber, required String callId}) async {
  ZIMCallCancelConfig zimCallCancelConfig = ZIMCallCancelConfig();
  zimCallCancelConfig.extendedData = callId;
  ZIMCallCancelSentResult? zimCallCancelSentResult =
      await zim?.callCancel([inviteePhoneNumber], callId, zimCallCancelConfig);

  return zimCallCancelSentResult;
}

// End call is used to terminate call for every one in the group like the host end the video call in group .
Future<ZIMCallEndSentResult?> endOngoingCall(
    {required String callId, required BuildContext context}) async {
  ZIMCallEndConfig zimCallEndConfig = ZIMCallEndConfig();
  zimCallEndConfig.extendedData = callId;
  ZIMCallEndSentResult? zimCallEndSentResult =
      await zim?.callEnd(callId, zimCallEndConfig);

  Navigator.of(context).pop();

  return zimCallEndSentResult;
}

// If any person want's to leave the call .
Future<ZIMCallQuitSentResult?> quitOnGoingCall(
    {required String callId, required BuildContext context}) async {
  ZIMCallQuitConfig zimCallQuitConfig = ZIMCallQuitConfig();
  zimCallQuitConfig.extendedData = callId;
  ZIMCallQuitSentResult? zimCallQuitSentResult =
      await zim?.callQuit(callId, zimCallQuitConfig);

  Navigator.of(context).pop();

  return zimCallQuitSentResult;
}

Future<void> listenToCallInvitationReceived(
    {required BuildContext context}) async {
  String currentUserName = "Developer";
  String? currentUserImageUrl;
  developer.log("Start listening");

  ZIMEventHandler.onCallInvitationReceived = (ZIM zimInstance,
      ZIMCallInvitationReceivedInfo zimCallInvitationReceivedInfo,
      String callId) async {
    developer.log("Invitation received");

    FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
        FireBaseFireStoreDatBase();
    Map<String, dynamic>? userDataMap =
        await fireBaseFireStoreDatBase.fetchDataOfGivenPhoneNumber(
            phoneNumber: zimCallInvitationReceivedInfo.caller);

    currentUserName = userDataMap?[FireBaseFireStoreDatBase.keyUserFirstName];
    currentUserImageUrl =
        userDataMap?[FireBaseFireStoreDatBase.keyUserImageURL];

    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        return IncomingCallDialogWidget(
          invitationSenderImageUrl: currentUserImageUrl,
          invitationSenderName: currentUserName,
          invitationSenderPhoneNumber: zimCallInvitationReceivedInfo.caller,
          callId: callId,
          roomId: callId,
        );
      },
    );
  };
}

Future<void> listenToTheCalleeResponse({
  required BuildContext context,
}) async {
  developer.log("Start listening to invitation response");

  ZIMEventHandler.onCallUserStateChanged = (ZIM zimInstance,
      ZIMCallUserStateChangeInfo zIMCallUserStateChangeInfo, String callId) {
    developer.log(
        "Invitation response ... ${zIMCallUserStateChangeInfo.callUserList.first.state}");

    switch (zIMCallUserStateChangeInfo.callUserList.first.state) {
      // This  is call when wee send the invitation to the user .

      case ZIMCallUserState.inviting:
        // Here we have to open the call waiting page

        developer.log("Call still inviting");
      case ZIMCallUserState.accepted:
        developer.log("call Accepted");

      case ZIMCallUserState.cancelled:
        developer.log("Call Cancelled");
      case ZIMCallUserState.ended:
        developer.log("Call ended");

      case ZIMCallUserState.notYetReceived:
        developer.log("Call not yet received");
      case ZIMCallUserState.offline:
        developer.log("User is offline");
      case ZIMCallUserState.quited:
        developer.log("Call quited");
      case ZIMCallUserState.received:
        developer.log("Call Received");
      case ZIMCallUserState.rejected:
        developer.log("Call rejected");
      case ZIMCallUserState.timeout:
        developer.log("Call Time out");
      case ZIMCallUserState.unknown:
        developer.log("Call in unknown state");

      default:
        developer.log("Call in unknown state");
    }
  };
}
