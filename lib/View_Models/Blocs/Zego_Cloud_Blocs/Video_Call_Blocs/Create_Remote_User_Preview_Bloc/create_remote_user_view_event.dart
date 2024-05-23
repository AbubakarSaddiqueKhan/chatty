part of 'create_remote_user_view_bloc.dart';

@immutable
sealed class CreateRemoteUserViewEvent {
  const CreateRemoteUserViewEvent();
}

class CreateRemoteUserWidgetFromGivenZegoCloudWidgetEvent
    extends CreateRemoteUserViewEvent {
  final Widget? zegoCloudCreateWidget;

  const CreateRemoteUserWidgetFromGivenZegoCloudWidgetEvent(
      {required this.zegoCloudCreateWidget});
}
