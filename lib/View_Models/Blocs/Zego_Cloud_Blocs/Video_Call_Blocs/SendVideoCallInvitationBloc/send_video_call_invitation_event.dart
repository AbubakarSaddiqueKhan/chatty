part of 'send_video_call_invitation_bloc.dart';

@immutable
sealed class SendVideoCallInvitationEvent {
  const SendVideoCallInvitationEvent();
}

class SendVideoCallInvitationToGivenUserEvent
    extends SendVideoCallInvitationEvent {
  final String invitationSenderPhoneNumber;
  final String invitationSenderName;
  final BuildContext context;
  final String invitationReceiverPhoneNumber;

  const SendVideoCallInvitationToGivenUserEvent(
      {required this.invitationSenderPhoneNumber,
      required this.invitationSenderName,
      required this.context,
      required this.invitationReceiverPhoneNumber});
}
