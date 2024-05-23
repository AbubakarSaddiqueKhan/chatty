part of 'switch_local_user_video_camera_bloc.dart';

@immutable
sealed class SwitchLocalUserVideoCameraState {
  const SwitchLocalUserVideoCameraState();
}

final class SwitchLocalUserVideoCameraInitialState
    extends SwitchLocalUserVideoCameraState {
  final bool isFrontCameraEnabled;
  final IconData videoCameraIcon;

  const SwitchLocalUserVideoCameraInitialState(
      {required this.isFrontCameraEnabled, required this.videoCameraIcon});
}

final class SwitchLocalUserVideoCameraLoadedState
    extends SwitchLocalUserVideoCameraState {
  final bool isFrontCameraEnabled;
  final IconData videoCameraIcon;

  const SwitchLocalUserVideoCameraLoadedState(
      {required this.isFrontCameraEnabled, required this.videoCameraIcon});
}

final class SwitchLocalUserVideoCameraErrorState
    extends SwitchLocalUserVideoCameraState {
  const SwitchLocalUserVideoCameraErrorState();
}
