part of 'enable_or_disable_video_camera_bloc_bloc.dart';

@immutable
sealed class EnableOrDisableVideoCallBlocEvent {
  const EnableOrDisableVideoCallBlocEvent();
}

class EnableOrDisableCurrentLocalUserVideoCameraEvent
    extends EnableOrDisableVideoCallBlocEvent {
  final bool isVideoCameraEnabled;

  const EnableOrDisableCurrentLocalUserVideoCameraEvent(
      {required this.isVideoCameraEnabled});
}
