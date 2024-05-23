part of 'enable_or_disable_local_user_speaker_bloc.dart';

@immutable
sealed class EnableOrDisableLocalUserSpeakerState {
  const EnableOrDisableLocalUserSpeakerState();
}

final class EnableOrDisableLocalUserSpeakerInitialState
    extends EnableOrDisableLocalUserSpeakerState {
  final bool isLocalUserSpeakerEnabled;
  final IconData currentSpeakerIcon;

  const EnableOrDisableLocalUserSpeakerInitialState(
      {required this.isLocalUserSpeakerEnabled,
      required this.currentSpeakerIcon});
}

final class EnableOrDisableLocalUserSpeakerLoadedState
    extends EnableOrDisableLocalUserSpeakerState {
  final bool isLocalUserSpeakerEnabled;
  final IconData currentSpeakerIcon;

  const EnableOrDisableLocalUserSpeakerLoadedState(
      {required this.isLocalUserSpeakerEnabled,
      required this.currentSpeakerIcon});
}

final class EnableOrDisableLocalUserSpeakerErrorState
    extends EnableOrDisableLocalUserSpeakerState {
  const EnableOrDisableLocalUserSpeakerErrorState();
}
