import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_remote_user_view_id_event.dart';
part 'create_remote_user_view_id_state.dart';

class CreateRemoteUserViewIdBloc
    extends Bloc<CreateRemoteUserViewIdEvent, CreateRemoteUserViewIdState> {
  CreateRemoteUserViewIdBloc()
      : super(
            const CreateRemoteUserViewIdInitialState(remoteUserViewId: null)) {
    on<CreateRemoteUserViewIdFromZegoCloudEvent>(
        _mapCreateRemoteUserViewIdFromZegoCloudEventToStates);
  }

  FutureOr<void> _mapCreateRemoteUserViewIdFromZegoCloudEventToStates(
      CreateRemoteUserViewIdFromZegoCloudEvent event,
      Emitter<CreateRemoteUserViewIdState> emit) {
    try {
      emit(CreateRemoteUserViewIdLoadedState(
          remoteUserViewId: event.remoteUserViewId));
    } catch (e) {
      emit(CreateRemoteUserViewIdErrorState());
    }
  }
}
