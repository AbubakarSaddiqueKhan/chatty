part of 'create_local_user_view_id_bloc.dart';

@immutable
sealed class CreateLocalUserViewIdEvent {
  const CreateLocalUserViewIdEvent();
}

class CreateLocalUserViewIdFromZegoCloud extends CreateLocalUserViewIdEvent {
  final int? localUserViewId;

  const CreateLocalUserViewIdFromZegoCloud({required this.localUserViewId});
}
