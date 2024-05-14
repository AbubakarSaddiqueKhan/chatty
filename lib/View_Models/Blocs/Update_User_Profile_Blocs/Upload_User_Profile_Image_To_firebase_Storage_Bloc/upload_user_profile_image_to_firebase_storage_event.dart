part of 'upload_user_profile_image_to_firebase_storage_bloc.dart';

@immutable
sealed class UploadUserProfileImageToFirebaseStorageEvent {
  const UploadUserProfileImageToFirebaseStorageEvent();
}

class UploadUserPickedProfileImageToFirebaseStorageEvent
    extends UploadUserProfileImageToFirebaseStorageEvent {
  final File imageFile;
  final String userMobileNumber;

  const UploadUserPickedProfileImageToFirebaseStorageEvent(
      {required this.imageFile, required this.userMobileNumber});
}
