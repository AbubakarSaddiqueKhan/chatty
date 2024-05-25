part of 'send_video_call_invitation_bloc.dart';

@immutable
sealed class SendVideoCallInvitationState {}

final class SendVideoCallInvitationInitialState
    extends SendVideoCallInvitationState {}

final class SendVideoCallInvitationLoadedState
    extends SendVideoCallInvitationState {}

final class SendVideoCallInvitationErrorState
    extends SendVideoCallInvitationState {}
