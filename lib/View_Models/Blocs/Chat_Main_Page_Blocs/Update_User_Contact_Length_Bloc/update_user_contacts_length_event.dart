part of 'update_user_contacts_length_bloc.dart';

@immutable
sealed class UpdateUserContactsLengthEvent {}

class UpdateUserContactListFromGivenFirebaseContactListEvent
    extends UpdateUserContactsLengthEvent {}
