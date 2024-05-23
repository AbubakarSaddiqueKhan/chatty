import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/EnableOrDisableLocalUserMicBloc/enable_or_disable_local_user_mic_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnableOrDisableLocalUserMicCustomWidget extends StatelessWidget {
  EnableOrDisableLocalUserMicCustomWidget(
      {super.key, required this.isMicroPhoneEnabled});
  bool isMicroPhoneEnabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black26),
        ),
        onPressed: () async {
          context.read<EnableOrDisableLocalUserMicBloc>().add(
              EnableOrDisableCurrentLocalUserMicEvent(
                  isLocalUserMicEnabled: isMicroPhoneEnabled));
        },
        icon: BlocBuilder<EnableOrDisableLocalUserMicBloc,
            EnableOrDisableLocalUserMicState>(
          builder: (context, state) {
            if (state is EnableOrDisableLocalUserMicInitialState) {
              isMicroPhoneEnabled = state.isLocalUserMicEnabled;
              return Icon(
                state.currentMicIcon,
                size: 22,
                color: Colors.white,
              );
            } else if (state is EnableOrDisableLocalUserMicLoadedState) {
              isMicroPhoneEnabled = state.isLocalUserMicEnabled;
              return Icon(
                state.currentMicIcon,
                size: 22,
                color: Colors.white,
              );
            } else {
              return const Icon(
                CupertinoIcons.mic,
                size: 22,
                color: Colors.white,
              );
            }
          },
        ));
  }
}
