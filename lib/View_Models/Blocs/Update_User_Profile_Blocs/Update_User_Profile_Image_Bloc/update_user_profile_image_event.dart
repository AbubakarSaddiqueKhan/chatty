part of 'update_user_profile_image_bloc.dart';

@immutable
sealed class UpdateUserProfileImageEvent {
  const UpdateUserProfileImageEvent();
}

class UpdateUserProfilePhotoWithGivenImageEvent
    extends UpdateUserProfileImageEvent {
  final File selectedUserImage;
  final String imageName;

  const UpdateUserProfilePhotoWithGivenImageEvent(
      {required this.selectedUserImage, required this.imageName});
}
