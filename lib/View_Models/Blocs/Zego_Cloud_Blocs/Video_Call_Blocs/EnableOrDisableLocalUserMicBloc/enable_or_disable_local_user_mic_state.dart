part of 'enable_or_disable_local_user_mic_bloc.dart';

@immutable
sealed class EnableOrDisableLocalUserMicState {
  const EnableOrDisableLocalUserMicState();
}

final class EnableOrDisableLocalUserMicInitialState
    extends EnableOrDisableLocalUserMicState {
  final bool isLocalUserMicEnabled;
  final IconData currentMicIcon;

  const EnableOrDisableLocalUserMicInitialState(
      {required this.isLocalUserMicEnabled, required this.currentMicIcon});
}

final class EnableOrDisableLocalUserMicLoadedState
    extends EnableOrDisableLocalUserMicState {
  final bool isLocalUserMicEnabled;
  final IconData currentMicIcon;

  const EnableOrDisableLocalUserMicLoadedState(
      {required this.isLocalUserMicEnabled, required this.currentMicIcon});
}

final class EnableOrDisableLocalUserMicErrorState
    extends EnableOrDisableLocalUserMicState {
  const EnableOrDisableLocalUserMicErrorState();
}
