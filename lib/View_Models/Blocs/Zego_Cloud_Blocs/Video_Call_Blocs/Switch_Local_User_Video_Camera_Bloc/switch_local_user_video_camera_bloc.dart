import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

part 'switch_local_user_video_camera_event.dart';
part 'switch_local_user_video_camera_state.dart';

class SwitchLocalUserVideoCameraBloc extends Bloc<
    SwitchLocalUserVideoCameraEvent, SwitchLocalUserVideoCameraState> {
  SwitchLocalUserVideoCameraBloc()
      : super(const SwitchLocalUserVideoCameraInitialState(
            isFrontCameraEnabled: true,
            videoCameraIcon: CupertinoIcons.switch_camera)) {
    on<SwitchLocalUserVideoCameraEvent>(
        _mapSwitchLocalUserVideoCameraEventToStates);
  }

  FutureOr<void> _mapSwitchLocalUserVideoCameraEventToStates(
      SwitchLocalUserVideoCameraEvent event,
      Emitter<SwitchLocalUserVideoCameraState> emit) async {
    try {
      bool isFrontCameraEnabled = !event.isFrontCameraEnabled;
      IconData switchCameraIcon = CupertinoIcons.switch_camera;

      await ZegoExpressEngine.instance.useFrontCamera(isFrontCameraEnabled);

      emit(SwitchLocalUserVideoCameraLoadedState(
          isFrontCameraEnabled: isFrontCameraEnabled,
          videoCameraIcon: switchCameraIcon));
    } catch (e) {
      emit(const SwitchLocalUserVideoCameraErrorState());
    }
  }
}
