part of 'create_remote_user_view_id_bloc.dart';

@immutable
sealed class CreateRemoteUserViewIdState {
  const CreateRemoteUserViewIdState();
}

final class CreateRemoteUserViewIdInitialState
    extends CreateRemoteUserViewIdState {
  final int? remoteUserViewId;

  const CreateRemoteUserViewIdInitialState({required this.remoteUserViewId});
}

final class CreateRemoteUserViewIdLoadedState
    extends CreateRemoteUserViewIdState {
  final int? remoteUserViewId;

  const CreateRemoteUserViewIdLoadedState({required this.remoteUserViewId});
}

final class CreateRemoteUserViewIdErrorState
    extends CreateRemoteUserViewIdState {}
