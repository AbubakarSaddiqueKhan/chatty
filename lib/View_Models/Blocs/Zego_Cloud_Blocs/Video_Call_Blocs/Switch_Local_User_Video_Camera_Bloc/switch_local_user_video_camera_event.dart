part of 'switch_local_user_video_camera_bloc.dart';

@immutable
class SwitchLocalUserVideoCameraEvent {
  final bool isFrontCameraEnabled;

  const SwitchLocalUserVideoCameraEvent({required this.isFrontCameraEnabled});
}
