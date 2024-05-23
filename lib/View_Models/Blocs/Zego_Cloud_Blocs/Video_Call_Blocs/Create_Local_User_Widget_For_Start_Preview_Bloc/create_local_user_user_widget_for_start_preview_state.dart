part of 'create_local_user_user_widget_for_start_preview_bloc.dart';

@immutable
sealed class CreateLocalUserUserWidgetForStartPreviewState {
  const CreateLocalUserUserWidgetForStartPreviewState();
}

final class CreateLocalUserWidgetForStartPreviewInitialState
    extends CreateLocalUserUserWidgetForStartPreviewState {
  final Widget? localViewWidget;

  const CreateLocalUserWidgetForStartPreviewInitialState(
      {required this.localViewWidget});
}

final class CreateLocalUserUserWidgetForStartPreviewLoadingState
    extends CreateLocalUserUserWidgetForStartPreviewState {}

final class CreateLocalUserUserWidgetForStartPreviewLoadedState
    extends CreateLocalUserUserWidgetForStartPreviewState {
  final Widget? localViewWidget;

  const CreateLocalUserUserWidgetForStartPreviewLoadedState(
      {required this.localViewWidget});
}

final class CreateLocalUserUserWidgetForStartPreviewErrorState
    extends CreateLocalUserUserWidgetForStartPreviewState {}
