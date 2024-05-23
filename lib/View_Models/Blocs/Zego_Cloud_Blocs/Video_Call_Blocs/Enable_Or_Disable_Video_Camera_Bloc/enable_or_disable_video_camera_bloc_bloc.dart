import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

part 'enable_or_disable_video_camera_bloc_event.dart';
part 'enable_or_disable_video_camera_bloc_state.dart';

class EnableOrDisableVideoCameraBloc extends Bloc<
    EnableOrDisableVideoCallBlocEvent, EnableOrDisableVideoCallBlocState> {
  EnableOrDisableVideoCameraBloc()
      : super(const EnableOrDisableVideoCallBlocInitialState(
            isVideoCameraEnabled: true,
            videoCameraIcon: CupertinoIcons.videocam)) {
    on<EnableOrDisableCurrentLocalUserVideoCameraEvent>(
        _mapEnableOrDisableCurrentLocalUserVideoCameraEventToStates);
  }

  FutureOr<void> _mapEnableOrDisableCurrentLocalUserVideoCameraEventToStates(
      EnableOrDisableCurrentLocalUserVideoCameraEvent event,
      Emitter<EnableOrDisableVideoCallBlocState> emit) async {
    try {
      bool isVideoCameraEnabled = !event.isVideoCameraEnabled;
      IconData videoCameraIcon = CupertinoIcons.videocam;

      if (isVideoCameraEnabled) {
        videoCameraIcon = CupertinoIcons.videocam;
      } else {
        videoCameraIcon = Icons.videocam_off_outlined;
      }

      await ZegoExpressEngine.instance.enableCamera(isVideoCameraEnabled);

      emit(EnableOrDisableVideoCallBlocLoadedState(
          isVideoCameraEnabled: isVideoCameraEnabled,
          videoCameraIcon: videoCameraIcon));
    } catch (e) {
      emit(const EnableOrDisableVideoCallBlocErrorState());
    }
  }
}
