import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'create_remote_user_view_event.dart';
part 'create_remote_user_view_state.dart';

class CreateRemoteUserViewBloc
    extends Bloc<CreateRemoteUserViewEvent, CreateRemoteUserViewState> {
  CreateRemoteUserViewBloc()
      : super(CreateRemoteUserViewInitialState(
            remoteUserView: Container(
          color: Colors.white,
        ))) {
    on<CreateRemoteUserWidgetFromGivenZegoCloudWidgetEvent>(
        _mapCreateRemoteUserWidgetFromGivenZegoCloudWidgetEventToStates);
  }

  FutureOr<void>
      _mapCreateRemoteUserWidgetFromGivenZegoCloudWidgetEventToStates(
          CreateRemoteUserWidgetFromGivenZegoCloudWidgetEvent event,
          Emitter<CreateRemoteUserViewState> emit) async {
    try {
      emit(CreateRemoteUserViewLoadedState(
          remoteUserView: event.zegoCloudCreateWidget));
    } catch (e) {
      emit(CreateRemoteUserViewErrorState());
    }
  }
}
