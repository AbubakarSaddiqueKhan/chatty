import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Enable_Or_Disable_Video_Camera_Bloc/enable_or_disable_video_camera_bloc_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnableOrDisableVideoCameraCustomWidget extends StatelessWidget {
  EnableOrDisableVideoCameraCustomWidget(
      {super.key, required this.isVideoCameraEnabled});
  bool isVideoCameraEnabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black26),
        ),
        onPressed: () async {
          context.read<EnableOrDisableVideoCameraBloc>().add(
              EnableOrDisableCurrentLocalUserVideoCameraEvent(
                  isVideoCameraEnabled: isVideoCameraEnabled));
        },
        icon: BlocBuilder<EnableOrDisableVideoCameraBloc,
            EnableOrDisableVideoCallBlocState>(
          builder: (context, state) {
            if (state is EnableOrDisableVideoCallBlocInitialState) {
              isVideoCameraEnabled = state.isVideoCameraEnabled;

              return Icon(
                state.videoCameraIcon,
                size: 24,
                color: Colors.white,
              );
            } else if (state is EnableOrDisableVideoCallBlocLoadedState) {
              isVideoCameraEnabled = state.isVideoCameraEnabled;

              return Icon(
                state.videoCameraIcon,
                size: 24,
                color: Colors.white,
              );
            } else {
              return const Icon(
                CupertinoIcons.videocam,
                size: 24,
                color: Colors.white,
              );
            }
          },
        ));
  }
}
