part of 'add_user_phone_number_to_local_database_bloc.dart';

@immutable
sealed class AddUserPhoneNumberToLocalDatabaseEvent {
  const AddUserPhoneNumberToLocalDatabaseEvent();
}

class AddGivenUserPhoneNumberToLocalDatabaseSharedPreferenceEvent
    extends AddUserPhoneNumberToLocalDatabaseEvent {
  final String userPhoneNumber;

  const AddGivenUserPhoneNumberToLocalDatabaseSharedPreferenceEvent(
      {required this.userPhoneNumber});
}
