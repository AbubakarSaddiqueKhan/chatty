import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

part 'enable_or_disable_local_user_mic_event.dart';
part 'enable_or_disable_local_user_mic_state.dart';

class EnableOrDisableLocalUserMicBloc extends Bloc<
    EnableOrDisableLocalUserMicEvent, EnableOrDisableLocalUserMicState> {
  EnableOrDisableLocalUserMicBloc()
      : super(const EnableOrDisableLocalUserMicInitialState(
            currentMicIcon: CupertinoIcons.mic, isLocalUserMicEnabled: true)) {
    on<EnableOrDisableCurrentLocalUserMicEvent>(
        _mapEnableOrDisableCurrentLocalUserMicEventToStates);
  }

  FutureOr<void> _mapEnableOrDisableCurrentLocalUserMicEventToStates(
      EnableOrDisableCurrentLocalUserMicEvent event,
      Emitter<EnableOrDisableLocalUserMicState> emit) async {
    try {
      bool isMicEnabled = !event.isLocalUserMicEnabled;
      IconData micIcon = CupertinoIcons.mic;

      if (isMicEnabled) {
        micIcon = CupertinoIcons.mic;
      } else {
        micIcon = Icons.mic_off_outlined;
      }

      await ZegoExpressEngine.instance.muteMicrophone(isMicEnabled);

      emit(EnableOrDisableLocalUserMicLoadedState(
          currentMicIcon: micIcon, isLocalUserMicEnabled: isMicEnabled));
    } catch (e) {
      emit(const EnableOrDisableLocalUserMicErrorState());
    }
  }
}
