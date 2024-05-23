import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Switch_Local_User_Video_Camera_Bloc/switch_local_user_video_camera_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchFrontRearCameraCustomWidget extends StatelessWidget {
  SwitchFrontRearCameraCustomWidget(
      {super.key, required this.isFrontCameraEnabled});
  bool isFrontCameraEnabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black26),
        ),
        onPressed: () async {
          context.read<SwitchLocalUserVideoCameraBloc>().add(
              SwitchLocalUserVideoCameraEvent(
                  isFrontCameraEnabled: isFrontCameraEnabled));
        },
        icon: BlocListener<SwitchLocalUserVideoCameraBloc,
            SwitchLocalUserVideoCameraState>(
          listener: (context, state) {
            if (state is SwitchLocalUserVideoCameraInitialState) {
              isFrontCameraEnabled = state.isFrontCameraEnabled;
            } else if (state is SwitchLocalUserVideoCameraLoadedState) {
              isFrontCameraEnabled = state.isFrontCameraEnabled;
            }
          },
          child: const Icon(
            CupertinoIcons.switch_camera,
            size: 22,
            color: Colors.white,
          ),
        ));
  }
}
