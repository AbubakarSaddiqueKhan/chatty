import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:meta/meta.dart';

part 'upload_suer_data_to_firebase_firestore_event.dart';
part 'upload_suer_data_to_firebase_firestore_state.dart';

class UploadSuerDataToFirebaseFirestoreBloc extends Bloc<
    UploadSuerDataToFirebaseFirestoreEvent,
    UploadSuerDataToFirebaseFirestoreState> {
  UploadSuerDataToFirebaseFirestoreBloc()
      : super(UploadSuerDataToFirebaseFirestoreInitialState()) {
    on<UploadUserProvidedDataToFirebaseFireStoreEvent>(
        _mapUploadUserProvidedDataToFirebaseFireStoreEventToStates);
  }

  FutureOr<void> _mapUploadUserProvidedDataToFirebaseFireStoreEventToStates(
      UploadUserProvidedDataToFirebaseFireStoreEvent event,
      Emitter<UploadSuerDataToFirebaseFirestoreState> emit) async {
    emit(UploadSuerDataToFirebaseFirestoreLoadingState());
    try {
      FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
          FireBaseFireStoreDatBase();

      await fireBaseFireStoreDatBase.addUserDatToFirebaseStorage(
          userDeviceToken: event.userDeviceToken,
          userFirstName: event.userFirstName,
          userLastName: event.userLastName,
          userPhoneNumber: event.userPhoneNumber,
          userImageUrl: event.userImageUrl);

      developer.log("Data added Successfullyyyy");
      emit(UploadSuerDataToFirebaseFirestoreLoadedState());
    } catch (e) {
      emit(UploadSuerDataToFirebaseFirestoreErrorState());
    }
  }
}
