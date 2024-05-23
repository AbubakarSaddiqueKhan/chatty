import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/EnableOrDisableLocalUserSpeakerBloc/enable_or_disable_local_user_speaker_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnableOrDisableLocalUserSpeakersCustomWidget extends StatelessWidget {
  EnableOrDisableLocalUserSpeakersCustomWidget(
      {super.key, required this.isSpeakerEnabled});
  bool isSpeakerEnabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black26),
        ),
        onPressed: () async {
          context.read<EnableOrDisableLocalUserSpeakerBloc>().add(
              EnableOrDisableCurrentLocalUserSpeakerEvent(
                  isLocalUserSpeakerEnabled: isSpeakerEnabled));
        },
        icon: BlocBuilder<EnableOrDisableLocalUserSpeakerBloc,
            EnableOrDisableLocalUserSpeakerState>(
          builder: (context, state) {
            if (state is EnableOrDisableLocalUserSpeakerInitialState) {
              isSpeakerEnabled = state.isLocalUserSpeakerEnabled;
              return Icon(
                state.currentSpeakerIcon,
                size: 22,
                color: Colors.white,
              );
            } else if (state is EnableOrDisableLocalUserSpeakerLoadedState) {
              isSpeakerEnabled = state.isLocalUserSpeakerEnabled;
              return Icon(
                state.currentSpeakerIcon,
                size: 22,
                color: Colors.white,
              );
            } else {
              return const Icon(
                CupertinoIcons.speaker_3,
                size: 22,
                color: Colors.white,
              );
            }
          },
        ));
  }
}
