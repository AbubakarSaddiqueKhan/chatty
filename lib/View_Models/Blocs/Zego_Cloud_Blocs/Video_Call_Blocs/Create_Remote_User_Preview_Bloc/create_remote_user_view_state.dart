part of 'create_remote_user_view_bloc.dart';

@immutable
sealed class CreateRemoteUserViewState {
  const CreateRemoteUserViewState();
}

final class CreateRemoteUserViewInitialState extends CreateRemoteUserViewState {
  final Widget? remoteUserView;

  const CreateRemoteUserViewInitialState({required this.remoteUserView});
}

final class CreateRemoteUserViewLoadedState extends CreateRemoteUserViewState {
  final Widget? remoteUserView;

  const CreateRemoteUserViewLoadedState({required this.remoteUserView});
}

final class CreateRemoteUserViewErrorState extends CreateRemoteUserViewState {}
