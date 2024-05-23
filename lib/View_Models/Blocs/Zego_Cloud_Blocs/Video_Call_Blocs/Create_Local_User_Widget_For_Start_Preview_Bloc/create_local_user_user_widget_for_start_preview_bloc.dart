import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'create_local_user_user_widget_for_start_preview_event.dart';
part 'create_local_user_user_widget_for_start_preview_state.dart';

class CreateLocalUserWidgetForStartPreviewBloc extends Bloc<
    CreateLocalUserWidgetForStartPreviewEvent,
    CreateLocalUserUserWidgetForStartPreviewState> {
  CreateLocalUserWidgetForStartPreviewBloc()
      : super(CreateLocalUserWidgetForStartPreviewInitialState(
            localViewWidget: Container(
          color: Colors.deepOrange,
        ))) {
    on<CreateLocalUserWidgetForStartPreviewFromGivenZegoCreatedWidgetEvent>(
        _mapCreateLocalUserUserWidgetForStartPreviewFromGivenZegoCreatedWidgetEventToStates);
  }

  FutureOr<void>
      _mapCreateLocalUserUserWidgetForStartPreviewFromGivenZegoCreatedWidgetEventToStates(
          CreateLocalUserWidgetForStartPreviewFromGivenZegoCreatedWidgetEvent
              event,
          Emitter<CreateLocalUserUserWidgetForStartPreviewState> emit) async {
    try {
      emit(CreateLocalUserUserWidgetForStartPreviewLoadedState(
          localViewWidget: event.zegoCreatedWidget));
    } catch (e) {
      emit(CreateLocalUserUserWidgetForStartPreviewErrorState());
    }
  }
}
