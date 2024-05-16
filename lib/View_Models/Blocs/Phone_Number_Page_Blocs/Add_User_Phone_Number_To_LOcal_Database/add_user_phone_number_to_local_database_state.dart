part of 'add_user_phone_number_to_local_database_bloc.dart';

@immutable
sealed class AddUserPhoneNumberToLocalDatabaseState {
  const AddUserPhoneNumberToLocalDatabaseState();
}

final class AddUserPhoneNumberToLocalDatabaseInitialState
    extends AddUserPhoneNumberToLocalDatabaseState {}

final class AddUserPhoneNumberToLocalDatabaseLoadingState
    extends AddUserPhoneNumberToLocalDatabaseState {}

final class AddUserPhoneNumberToLocalDatabaseLoadedState
    extends AddUserPhoneNumberToLocalDatabaseState {
  final bool isUserPhoneNumberAddedSuccessfully;

  const AddUserPhoneNumberToLocalDatabaseLoadedState(
      {required this.isUserPhoneNumberAddedSuccessfully});
}

final class AddUserPhoneNumberToLocalDatabaseErrorState
    extends AddUserPhoneNumberToLocalDatabaseState {}
