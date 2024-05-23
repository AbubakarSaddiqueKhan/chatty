part of 'create_local_user_user_widget_for_start_preview_bloc.dart';

@immutable
sealed class CreateLocalUserWidgetForStartPreviewEvent {
  const CreateLocalUserWidgetForStartPreviewEvent();
}

class CreateLocalUserWidgetForStartPreviewFromGivenZegoCreatedWidgetEvent
    extends CreateLocalUserWidgetForStartPreviewEvent {
  final Widget? zegoCreatedWidget;

  const CreateLocalUserWidgetForStartPreviewFromGivenZegoCreatedWidgetEvent(
      {required this.zegoCreatedWidget});
}
