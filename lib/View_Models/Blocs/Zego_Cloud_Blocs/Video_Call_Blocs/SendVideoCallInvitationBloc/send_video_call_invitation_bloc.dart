import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatty/View_Models/Custom_Codes/zego_cloud_send_call_invitation_custom_code.dart';
import 'package:chatty/Views/Screens/Zego_Cloud_Screens/video_call_main_page.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zego_zim/zego_zim.dart';

part 'send_video_call_invitation_event.dart';
part 'send_video_call_invitation_state.dart';

class SendVideoCallInvitationBloc
    extends Bloc<SendVideoCallInvitationEvent, SendVideoCallInvitationState> {
  SendVideoCallInvitationBloc() : super(SendVideoCallInvitationInitialState()) {
    on<SendVideoCallInvitationToGivenUserEvent>(
        _mapSendVideoCallInvitationToGivenUserEventToStates);
  }

  FutureOr<void> _mapSendVideoCallInvitationToGivenUserEventToStates(
      SendVideoCallInvitationToGivenUserEvent event,
      Emitter<SendVideoCallInvitationState> emit) async {
    try {
      ZIMCallInvitationSentResult? zimCallInvitationSentResult =
          await sendVideoCallInvitationToGivenUser(
              inviteePhoneNumber: event.invitationReceiverPhoneNumber,
              inviterPhoneNumber: event.invitationSenderPhoneNumber);

      (
        String callSenderName,
        String callSenderPhoneNumber,
        String roomId,
      ) videoCallDataRecord = (
        event.invitationSenderName,
        event.invitationSenderPhoneNumber,
        zimCallInvitationSentResult!.callID
      );

      Navigator.of(event.context)
          .pushNamed(VideoCallPage.pageName, arguments: videoCallDataRecord);
      emit(SendVideoCallInvitationLoadedState());
    } catch (e) {
      emit(SendVideoCallInvitationErrorState());
    }
  }
}
