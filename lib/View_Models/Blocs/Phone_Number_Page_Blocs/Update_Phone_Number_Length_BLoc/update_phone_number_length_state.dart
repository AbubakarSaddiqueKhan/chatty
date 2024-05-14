part of 'update_phone_number_length_bloc.dart';

@immutable
sealed class UpdatePhoneNumberLengthState {
  const UpdatePhoneNumberLengthState();
}

final class UpdatePhoneNumberLengthInitialState
    extends UpdatePhoneNumberLengthState {
  final int initialPhoneNumberLength;

  const UpdatePhoneNumberLengthInitialState(
      {required this.initialPhoneNumberLength});
}

final class UpdatePhoneNumberLengthLoadedState
    extends UpdatePhoneNumberLengthState {
  final int currentPhoneNumberLength;

  const UpdatePhoneNumberLengthLoadedState(
      {required this.currentPhoneNumberLength});
}

final class UpdatePhoneNumberLengthErrorState
    extends UpdatePhoneNumberLengthState {}
