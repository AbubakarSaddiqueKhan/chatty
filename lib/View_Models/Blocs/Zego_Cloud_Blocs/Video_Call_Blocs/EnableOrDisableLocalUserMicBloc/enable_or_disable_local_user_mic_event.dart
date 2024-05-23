part of 'enable_or_disable_local_user_mic_bloc.dart';

@immutable
sealed class EnableOrDisableLocalUserMicEvent {
  const EnableOrDisableLocalUserMicEvent();
}

class EnableOrDisableCurrentLocalUserMicEvent
    extends EnableOrDisableLocalUserMicEvent {
  final bool isLocalUserMicEnabled;

  const EnableOrDisableCurrentLocalUserMicEvent(
      {required this.isLocalUserMicEnabled});
}
