import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Storage/firebase_cloud_storage.dart';
import 'package:meta/meta.dart';

part 'upload_user_profile_image_to_firebase_storage_event.dart';
part 'upload_user_profile_image_to_firebase_storage_state.dart';

class UploadUserProfileImageToFirebaseStorageBloc extends Bloc<
    UploadUserProfileImageToFirebaseStorageEvent,
    UploadUserProfileImageToFirebaseStorageState> {
  UploadUserProfileImageToFirebaseStorageBloc()
      : super(UploadUserProfileImageToFirebaseStorageInitialState()) {
    on<UploadUserPickedProfileImageToFirebaseStorageEvent>(
        _mapUploadUserPickedProfileImageToFirebaseStorageEventToStates);
  }

  FutureOr<void> _mapUploadUserPickedProfileImageToFirebaseStorageEventToStates(
      UploadUserPickedProfileImageToFirebaseStorageEvent event,
      Emitter<UploadUserProfileImageToFirebaseStorageState> emit) async {
    developer.log("Before image loading  ....");
    emit(UploadUserProfileImageToFirebaseStorageLoadingState());
    developer.log("after image loading  ....");

    try {
      developer.log("Before image loaded  ....");

      FirebaseCloudStorage firebaseCloudStorage = FirebaseCloudStorage();
      String userProfileImageUrl =
          await firebaseCloudStorage.uploadImageToFirebaseCloudStorage(
              imageFile: event.imageFile, mobileNumber: event.userMobileNumber);
      emit(UploadUserProfileImageToFirebaseStorageLoadedState(
          uploadedUserImageURL: userProfileImageUrl));
      developer.log("after image loadedddd  ....");
    } catch (e) {
      developer.log("Before image Errrorrr  ....");

      emit(UploadUserProfileImageToFirebaseStorageErrorState());
    }
  }
}
