import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Create_Local_User_View_Id_Bloc/create_local_user_view_id_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Create_Local_User_Widget_For_Start_Preview_Bloc/create_local_user_user_widget_for_start_preview_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Create_Remote_User_Preview_Bloc/create_remote_user_view_bloc.dart';
import 'package:chatty/View_Models/Blocs/Zego_Cloud_Blocs/Video_Call_Blocs/Create_Remote_User_View_Id_Bloc/create_remote_user_view_id_bloc.dart';
import 'package:chatty/View_Models/Custom_Codes/local_user_widget_custom_clipper.dart';
import 'package:chatty/View_Models/Custom_Codes/zego_cloud_video_call_custom_code.dart';
import 'package:chatty/Views/Widgets/Zego_Cloud_Screens_Widgets/video_call_screen_widgets/video_call_main_page_custom_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    startListenEvent(context: context, remoteViewID: remoteViewID);

    super.initState();
  }

  @override
  void dispose() {
    stopListenEvent();

    logoutRoom(context: context, roomID: roomId, localViewID: localViewID);
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final videoCallDataRecord = ModalRoute.of(context)!.settings.arguments as (
      String callSenderName,
      String callSenderPhoneNumber,
      String roomId,
    );

    developer.log("Received record .... ${videoCallDataRecord.toString()}");

    localUserID = videoCallDataRecord.$2;
    localUserName = videoCallDataRecord.$1;
    roomId = videoCallDataRecord.$3;

    await loginRoom(
        context: context,
        localUserID: localUserID,
        localUserName: localUserName,
        localViewID: localViewID,
        roomId: roomId);
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
                  )),
                ),
              ),
            ),
            VideoCallMainPageCustomBottomWidget(
              callId: roomId,
            )
          ],
        ),
      ),
    );
  }
}
