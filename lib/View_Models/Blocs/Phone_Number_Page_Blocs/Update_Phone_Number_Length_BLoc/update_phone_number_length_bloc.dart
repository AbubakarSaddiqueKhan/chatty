import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_phone_number_length_event.dart';
part 'update_phone_number_length_state.dart';

class UpdatePhoneNumberLengthBloc
    extends Bloc<UpdatePhoneNumberLengthEvent, UpdatePhoneNumberLengthState> {
  UpdatePhoneNumberLengthBloc()
      : super(const UpdatePhoneNumberLengthInitialState(
            initialPhoneNumberLength: 0)) {
    on<FetchCurrentPhoneNumberLengthFromTextEditingControllerEvent>(
        _mapFetchCurrentPhoneNumberLengthFromTextEditingControllerEventToStates);
  }

  FutureOr<void>
      _mapFetchCurrentPhoneNumberLengthFromTextEditingControllerEventToStates(
          FetchCurrentPhoneNumberLengthFromTextEditingControllerEvent event,
          Emitter<UpdatePhoneNumberLengthState> emit) {
    try {
      emit(UpdatePhoneNumberLengthLoadedState(
          currentPhoneNumberLength: event.currentPhoneNumberLength));
    } catch (e) {
      emit(UpdatePhoneNumberLengthErrorState());
    }
  }
}
