part of 'enable_or_disable_local_user_speaker_bloc.dart';

@immutable
sealed class EnableOrDisableLocalUserSpeakerEvent {
  const EnableOrDisableLocalUserSpeakerEvent();
}

class EnableOrDisableCurrentLocalUserSpeakerEvent
    extends EnableOrDisableLocalUserSpeakerEvent {
  final bool isLocalUserSpeakerEnabled;

  const EnableOrDisableCurrentLocalUserSpeakerEvent(
      {required this.isLocalUserSpeakerEnabled});
}
