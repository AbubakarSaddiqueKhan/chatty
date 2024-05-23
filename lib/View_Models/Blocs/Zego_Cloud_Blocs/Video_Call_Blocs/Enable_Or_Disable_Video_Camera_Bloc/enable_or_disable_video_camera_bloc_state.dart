part of 'enable_or_disable_video_camera_bloc_bloc.dart';

@immutable
sealed class EnableOrDisableVideoCallBlocState {
  const EnableOrDisableVideoCallBlocState();
}

final class EnableOrDisableVideoCallBlocInitialState
    extends EnableOrDisableVideoCallBlocState {
  final bool isVideoCameraEnabled;
  final IconData videoCameraIcon;

  const EnableOrDisableVideoCallBlocInitialState(
      {required this.isVideoCameraEnabled, required this.videoCameraIcon});
}

final class EnableOrDisableVideoCallBlocLoadedState
    extends EnableOrDisableVideoCallBlocState {
  final bool isVideoCameraEnabled;
  final IconData videoCameraIcon;

  const EnableOrDisableVideoCallBlocLoadedState(
      {required this.isVideoCameraEnabled, required this.videoCameraIcon});
}

final class EnableOrDisableVideoCallBlocErrorState
    extends EnableOrDisableVideoCallBlocState {
  const EnableOrDisableVideoCallBlocErrorState();
}
