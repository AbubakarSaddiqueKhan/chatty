part of 'create_remote_user_view_id_bloc.dart';

@immutable
sealed class CreateRemoteUserViewIdEvent {
  const CreateRemoteUserViewIdEvent();
}

class CreateRemoteUserViewIdFromZegoCloudEvent
    extends CreateRemoteUserViewIdEvent {
  final int? remoteUserViewId;

  const CreateRemoteUserViewIdFromZegoCloudEvent(
      {required this.remoteUserViewId});
}
