import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

part 'enable_or_disable_local_user_speaker_event.dart';
part 'enable_or_disable_local_user_speaker_state.dart';

class EnableOrDisableLocalUserSpeakerBloc extends Bloc<
    EnableOrDisableLocalUserSpeakerEvent,
    EnableOrDisableLocalUserSpeakerState> {
  EnableOrDisableLocalUserSpeakerBloc()
      : super(const EnableOrDisableLocalUserSpeakerInitialState(
            currentSpeakerIcon: CupertinoIcons.speaker_3,
            isLocalUserSpeakerEnabled: true)) {
    on<EnableOrDisableCurrentLocalUserSpeakerEvent>(
        _mapEnableOrDisableCurrentLocalUserSpeakerEventToStates);
  }

  FutureOr<void> _mapEnableOrDisableCurrentLocalUserSpeakerEventToStates(
      EnableOrDisableCurrentLocalUserSpeakerEvent event,
      Emitter<EnableOrDisableLocalUserSpeakerState> emit) async {
    try {
      bool isLocalUserSpeakerEnabled = !event.isLocalUserSpeakerEnabled;
      IconData currentSpeakerIcon = CupertinoIcons.speaker_3;

      if (isLocalUserSpeakerEnabled) {
        currentSpeakerIcon = CupertinoIcons.speaker_3;
      } else {
        currentSpeakerIcon = Icons.volume_off_outlined;
      }

      await ZegoExpressEngine.instance.muteSpeaker(isLocalUserSpeakerEnabled);

      emit(EnableOrDisableLocalUserSpeakerLoadedState(
          currentSpeakerIcon: currentSpeakerIcon,
          isLocalUserSpeakerEnabled: isLocalUserSpeakerEnabled));
    } catch (e) {
      emit(const EnableOrDisableLocalUserSpeakerErrorState());
    }
  }
}
