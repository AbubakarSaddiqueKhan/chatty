part of 'update_user_profile_image_bloc.dart';

@immutable
sealed class UpdateUserProfileImageState {
  const UpdateUserProfileImageState();
}

final class UpdateUserProfileImageInitialState
    extends UpdateUserProfileImageState {}

final class UpdateUserProfileImageLoadingState
    extends UpdateUserProfileImageState {}

final class UpdateUserProfileImageLoadedState
    extends UpdateUserProfileImageState {
  final File userSelectedImage;

  const UpdateUserProfileImageLoadedState({required this.userSelectedImage});
}

final class UpdateUserProfileImageErrorState
    extends UpdateUserProfileImageState {}
