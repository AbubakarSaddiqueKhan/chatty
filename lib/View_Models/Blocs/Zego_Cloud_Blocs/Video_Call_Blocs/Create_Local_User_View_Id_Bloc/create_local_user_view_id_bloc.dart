import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_local_user_view_id_event.dart';
part 'create_local_user_view_id_state.dart';

class CreateLocalUserViewIdBloc
    extends Bloc<CreateLocalUserViewIdEvent, CreateLocalUserViewIdState> {
  CreateLocalUserViewIdBloc()
      : super(const CreateLocalUserViewIdInitialState(localUserViewId: null)) {
    on<CreateLocalUserViewIdFromZegoCloud>(
        _mapCreateLocalUserViewIdFromZegoCloudToStates);
  }

  FutureOr<void> _mapCreateLocalUserViewIdFromZegoCloudToStates(
      CreateLocalUserViewIdFromZegoCloud event,
      Emitter<CreateLocalUserViewIdState> emit) async {
    try {
      emit(CreateLocalUserViewIdLoadedState(
          localUserViewId: event.localUserViewId));
    } catch (e) {
      emit(CreateLocalUserViewIdErrorState());
    }
  }
}
