part of 'update_user_contacts_length_bloc.dart';

@immutable
sealed class UpdateUserContactsLengthState {
  const UpdateUserContactsLengthState();
}

final class UpdateUserContactsLengthInitialState
    extends UpdateUserContactsLengthState {}

final class UpdateUserContactsLengthLoadingState
    extends UpdateUserContactsLengthState {}

final class UpdateUserContactsLengthLoadedState
    extends UpdateUserContactsLengthState {
  final List<String> userContactPhoneNumberList;

  const UpdateUserContactsLengthLoadedState(
      {required this.userContactPhoneNumberList});
}

final class UpdateUserContactsLengthErrorState
    extends UpdateUserContactsLengthState {}
