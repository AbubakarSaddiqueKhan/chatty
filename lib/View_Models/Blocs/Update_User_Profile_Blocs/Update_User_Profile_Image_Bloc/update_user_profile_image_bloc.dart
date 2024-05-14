import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_user_profile_image_event.dart';
part 'update_user_profile_image_state.dart';

class UpdateUserProfileImageBloc
    extends Bloc<UpdateUserProfileImageEvent, UpdateUserProfileImageState> {
  UpdateUserProfileImageBloc() : super(UpdateUserProfileImageInitialState()) {
    on<UpdateUserProfilePhotoWithGivenImageEvent>(
        _mapUpdateUserProfilePhotoWithGivenImageEventToStates);
  }

  FutureOr<void> _mapUpdateUserProfilePhotoWithGivenImageEventToStates(
      UpdateUserProfilePhotoWithGivenImageEvent event,
      Emitter<UpdateUserProfileImageState> emit) async {
    emit(UpdateUserProfileImageLoadingState());
    developer.log("Loadinggggggggggggg");

    try {
      emit(UpdateUserProfileImageLoadedState(
          userSelectedImage: event.selectedUserImage,
          userSelectedImageName: event.imageName));
      developer.log("Loadedddddddddddddd");
    } catch (e) {
      emit(UpdateUserProfileImageErrorState());
      developer.log("Errrorrrr");
    }
  }
}
