import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Cloud_Messaging_Service/firebase_cloud_messaging_service.dart';
import 'package:meta/meta.dart';

part 'fetch_user_device_token_event.dart';
part 'fetch_user_device_token_state.dart';

class FetchUserDeviceTokenBloc
    extends Bloc<FetchUserDeviceTokenEvent, FetchUserDeviceTokenState> {
  FetchUserDeviceTokenBloc() : super(FetchUserDeviceTokenInitialState()) {
    on<FetchUserDeviceTokenEvent>(_mapFetchUserDeviceTokenEventToStates);
  }

  FutureOr<void> _mapFetchUserDeviceTokenEventToStates(
      FetchUserDeviceTokenEvent event,
      Emitter<FetchUserDeviceTokenState> emit) async {
    emit(FetchUserDeviceTokenLoadingState());
    try {
      FirebaseCloudMessagingService firebaseCloudMessagingService =
          FirebaseCloudMessagingService();
      String? userDeviceToken =
          await firebaseCloudMessagingService.getUserDeviceToken();
      if (userDeviceToken != null || userDeviceToken!.isNotEmpty) {
        emit(FetchUserDeviceTokenLoadedState(userDeviceToken: userDeviceToken));
      }
    } catch (e) {
      emit(FetchUserDeviceTokenErrorState());
    }
  }
}
