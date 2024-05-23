import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/enable_or_disable_local_user_mic_custom_widget.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/enable_or_disable_local_user_speakers_custom_widget.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/enable_or_disable_video_camera_custom_widget.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/end_vide_call_custom_button.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/switch_front_rear_camera_custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoCallMainPageCustomBottomWidget extends StatefulWidget {
  const VideoCallMainPageCustomBottomWidget({super.key});

  @override
  State<VideoCallMainPageCustomBottomWidget> createState() =>
      _VideoCallMainPageCustomBottomWidgetState();
}

class _VideoCallMainPageCustomBottomWidgetState
    extends State<VideoCallMainPageCustomBottomWidget> {
  bool isFrontCameraEnabled = true;
  bool isVideoCameraEnabled = true;
  bool isMicroPhoneEnabled = true;
  bool isSpeakerEnabled = true;
  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          width: width,
          height: height * 0.125,
          decoration: const BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EnableOrDisableVideoCameraCustomWidget(
                  isVideoCameraEnabled: isVideoCameraEnabled),
              SwitchFrontRearCameraCustomWidget(
                  isFrontCameraEnabled: isFrontCameraEnabled),
              const EndVideCallCustomButton(),
              EnableOrDisableLocalUserMicCustomWidget(
                  isMicroPhoneEnabled: isMicroPhoneEnabled),
              EnableOrDisableLocalUserSpeakersCustomWidget(
                  isSpeakerEnabled: isSpeakerEnabled)
            ],
          ),
        ));
  }
}
