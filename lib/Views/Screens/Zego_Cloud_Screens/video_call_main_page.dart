import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Create_Local_User_View_Id_Bloc/create_local_user_view_id_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Create_Local_User_Widget_For_Start_Preview_Bloc/create_local_user_user_widget_for_start_preview_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Create_Remote_User_Preview_Bloc/create_remote_user_view_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Create_Remote_User_View_Id_Bloc/create_remote_user_view_id_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/EnableOrDisableLocalUserMicBloc/enable_or_disable_local_user_mic_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/EnableOrDisableLocalUserSpeakerBloc/enable_or_disable_local_user_speaker_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Enable_Or_Disable_Video_Camera_Bloc/enable_or_disable_video_camera_bloc_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Switch_Local_User_Video_Camera_Bloc/switch_local_user_video_camera_bloc.dart';
import 'package:chatty/View_Models/Custom_Codes/local_user_widget_custom_clipper.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/enable_or_disable_local_user_mic_custom_widget.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/enable_or_disable_local_user_speakers_custom_widget.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/enable_or_disable_video_camera_custom_widget.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/end_vide_call_custom_button.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/switch_front_rear_camera_custom_widget.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/video_call_main_page_custom_bottom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'dart:developer' as developer;

class VideoCallPage extends StatefulWidget {
  @override
  State<VideoCallPage> createState() => _VideoCallPageState();

  static const String pageName = "/videoCallMainPage";
}

class _VideoCallPageState extends State<VideoCallPage> {
  late String localUserID;
  late String localUserName;
  late String roomId;

  Widget? localView;
  int? localViewID;
  Widget? remoteView;
  int? remoteViewID;

  @override
  void initState() {
    startListenEvent();

    super.initState();
  }

  @override
  void dispose() {
    stopListenEvent();

    logoutRoom();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final videoCallDataRecord = ModalRoute.of(context)!.settings.arguments as (
      String callSenderName,
      String callSenderPhoneNumber,
      String callReceiverPhoneNumber,
      String roomId,
    );

    localUserID = videoCallDataRecord.$2;
    localUserName = videoCallDataRecord.$1;
    roomId = videoCallDataRecord.$4;

    await loginRoom();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BlocListener<CreateRemoteUserViewIdBloc,
                CreateRemoteUserViewIdState>(
              listener: (context, state) {
                if (state is CreateRemoteUserViewIdInitialState) {
                  remoteViewID = state.remoteUserViewId;
                } else if (state is CreateRemoteUserViewIdLoadedState) {
                  remoteViewID = state.remoteUserViewId;
                }
              },
              child: Expanded(child: BlocBuilder<CreateRemoteUserViewBloc,
                  CreateRemoteUserViewState>(
                builder: (context, state) {
                  if (state is CreateRemoteUserViewInitialState) {
                    return state.remoteUserView ??
                        Container(
                          color: Colors.grey,
                        );
                  } else if (state is CreateRemoteUserViewLoadedState) {
                    return state.remoteUserView ??
                        Container(
                          color: Colors.grey,
                        );
                  } else {
                    return Container(
                      color: Colors.grey,
                    );
                  }
                },
              )),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: BlocListener<CreateLocalUserViewIdBloc,
                  CreateLocalUserViewIdState>(
                listener: (context, state) {
                  if (state is CreateLocalUserViewIdInitialState) {
                    localViewID = state.localUserViewId;
                  } else if (state is CreateLocalUserViewIdLoadedState) {
                    localViewID = state.localUserViewId;
                  }
                },
                child: SizedBox(
                  width: width * 0.35,
                  height: height * 0.26,
                  child: Expanded(
                      child: ClipPath(
                    clipper: LocalUserVideoWidgetCustomClipper(),
                    child: BlocBuilder<CreateLocalUserWidgetForStartPreviewBloc,
                        CreateLocalUserUserWidgetForStartPreviewState>(
                      builder: (context, state) {
                        if (state
                            is CreateLocalUserWidgetForStartPreviewInitialState) {
                          return state.localViewWidget ??
                              Container(
                                color: Colors.white,
                              );
                        } else if (state
                            is CreateLocalUserUserWidgetForStartPreviewLoadedState) {
                          return state.localViewWidget ??
                              Container(
                                color: Colors.white,
                              );
                        } else {
                          return Container(
                            color: Colors.white,
                          );
                        }
                      },
                    ),
                    // child: localView ??
                    //     Container(color: Colors.grey.shade300)
                  )),
                ),
              ),
            ),
            const VideoCallMainPageCustomBottomWidget()
          ],
        ),
      ),
    );
  }

  Future<ZegoRoomLoginResult> loginRoom() async {
    // The value of `userID` is generated locally and must be globally unique.
    final user = ZegoUser(localUserID, localUserName);

    // The value of `roomID` is generated locally and must be globally unique.
    final roomID = roomId;

    // onRoomUserUpdate callback can be received when "isUserStatusNotify" parameter value is "true".
    ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()
      ..isUserStatusNotify = true;

    // if (kIsWeb) {
    //   // ! ** Warning: ZegoTokenUtils is only for use during testing. When your application goes live,
    //   // ! ** tokens must be generated by the server side. Please do not generate tokens on the client side!
    //   roomConfig.token =
    //       ZegoTokenUtils.generateToken(appID, serverSecret, widget.localUserID);
    // }
    // log in to a room
    // Users must log in to the same room to call each other.
    return ZegoExpressEngine.instance
        .loginRoom(roomID, user, config: roomConfig)
        .then((ZegoRoomLoginResult loginRoomResult) {
      debugPrint(
          'loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
      if (loginRoomResult.errorCode == 0) {
        startPreview();
        startPublish();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('loginRoom failed: ${loginRoomResult.errorCode}')));
      }
      return loginRoomResult;
    });
  }

  Future<ZegoRoomLogoutResult> logoutRoom() async {
    stopPreview();
    stopPublish();
    return ZegoExpressEngine.instance.logoutRoom(roomId);
  }

  void startListenEvent() {
    // Callback for updates on the status of other users in the room.
    // Users can only receive callbacks when the isUserStatusNotify property of ZegoRoomConfig is set to `true` when logging in to the room (loginRoom).
    ZegoExpressEngine.onRoomUserUpdate =
        (roomID, updateType, List<ZegoUser> userList) {
      debugPrint(
          'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
    };
    // Callback for updates on the status of the streams in the room.
    ZegoExpressEngine.onRoomStreamUpdate =
        (roomID, updateType, List<ZegoStream> streamList, extendedData) {
      debugPrint(
          'onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
      if (updateType == ZegoUpdateType.Add) {
        for (final stream in streamList) {
          startPlayStream(stream.streamID);
        }
      } else {
        for (final stream in streamList) {
          stopPlayStream(stream.streamID);
        }
      }
    };
    // Callback for updates on the current user's room connection status.
    ZegoExpressEngine.onRoomStateUpdate =
        (roomID, state, errorCode, extendedData) {
      debugPrint(
          'onRoomStateUpdate: roomID: $roomID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };

    // Callback for updates on the current user's stream publishing changes.
    ZegoExpressEngine.onPublisherStateUpdate =
        (streamID, state, errorCode, extendedData) {
      debugPrint(
          'onPublisherStateUpdate: streamID: $streamID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };
  }

  void stopListenEvent() {
    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onRoomStateUpdate = null;
    ZegoExpressEngine.onPublisherStateUpdate = null;
  }

  Future<void> startPreview() async {
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      localViewID = viewID;
      ZegoCanvas previewCanvas =
          ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
    }).then((canvasViewWidget) {
      // setState(() => localView = canvasViewWidget);
      context.read<CreateLocalUserWidgetForStartPreviewBloc>().add(
          CreateLocalUserWidgetForStartPreviewFromGivenZegoCreatedWidgetEvent(
              zegoCreatedWidget: canvasViewWidget));
    });
  }

  Future<void> stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (localViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);
      if (mounted) {
        // localViewID = null;
        context.read<CreateLocalUserViewIdBloc>().add(
            const CreateLocalUserViewIdFromZegoCloud(localUserViewId: null));
        // localView = null;
        context.read<CreateLocalUserWidgetForStartPreviewBloc>().add(
            const CreateLocalUserWidgetForStartPreviewFromGivenZegoCreatedWidgetEvent(
                zegoCreatedWidget: null));
      }
    }
  }

  Future<void> startPublish() async {
    // After calling the `loginRoom` method, call this method to publish streams.
    // The StreamID must be unique in the room.
    String streamID = '${roomId}_${localUserID}_call';
    return ZegoExpressEngine.instance.startPublishingStream(streamID);
  }

  Future<void> stopPublish() async {
    return ZegoExpressEngine.instance.stopPublishingStream();
  }

  Future<void> startPlayStream(String streamID) async {
    // Start to play streams. Set the view for rendering the remote streams.
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      remoteViewID = viewID;
      ZegoCanvas canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
    }).then((canvasViewWidget) {
      // setState(() => remoteView = canvasViewWidget);
      context.read<CreateRemoteUserViewBloc>().add(
          CreateRemoteUserWidgetFromGivenZegoCloudWidgetEvent(
              zegoCloudCreateWidget: canvasViewWidget));
    });
  }

  Future<void> stopPlayStream(String streamID) async {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    if (remoteViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
      if (mounted) {
        // remoteViewID = null;
        context.read<CreateRemoteUserViewIdBloc>().add(
            const CreateRemoteUserViewIdFromZegoCloudEvent(
                remoteUserViewId: null));
        // remoteView = null;
        context.read<CreateRemoteUserViewBloc>().add(
            const CreateRemoteUserWidgetFromGivenZegoCloudWidgetEvent(
                zegoCloudCreateWidget: null));
      }
    }
  }
}
