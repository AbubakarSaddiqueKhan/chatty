part of 'upload_user_profile_image_to_firebase_storage_bloc.dart';

@immutable
sealed class UploadUserProfileImageToFirebaseStorageState {
  const UploadUserProfileImageToFirebaseStorageState();
}

final class UploadUserProfileImageToFirebaseStorageInitialState
    extends UploadUserProfileImageToFirebaseStorageState {}

final class UploadUserProfileImageToFirebaseStorageLoadingState
    extends UploadUserProfileImageToFirebaseStorageState {}

final class UploadUserProfileImageToFirebaseStorageLoadedState
    extends UploadUserProfileImageToFirebaseStorageState {
  final String uploadedUserImageURL;

  const UploadUserProfileImageToFirebaseStorageLoadedState(
      {required this.uploadedUserImageURL});
}

final class UploadUserProfileImageToFirebaseStorageErrorState
    extends UploadUserProfileImageToFirebaseStorageState {}
