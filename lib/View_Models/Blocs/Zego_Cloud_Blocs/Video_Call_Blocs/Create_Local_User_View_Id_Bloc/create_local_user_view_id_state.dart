part of 'create_local_user_view_id_bloc.dart';

@immutable
sealed class CreateLocalUserViewIdState {
  const CreateLocalUserViewIdState();
}

final class CreateLocalUserViewIdInitialState
    extends CreateLocalUserViewIdState {
  final int? localUserViewId;

  const CreateLocalUserViewIdInitialState({required this.localUserViewId});
}

final class CreateLocalUserViewIdLoadedState
    extends CreateLocalUserViewIdState {
  final int? localUserViewId;

  const CreateLocalUserViewIdLoadedState({required this.localUserViewId});
}

final class CreateLocalUserViewIdErrorState
    extends CreateLocalUserViewIdState {}
