part of 'update_phone_number_length_bloc.dart';

@immutable
sealed class UpdatePhoneNumberLengthEvent {
  const UpdatePhoneNumberLengthEvent();
}

class FetchCurrentPhoneNumberLengthFromTextEditingControllerEvent
    extends UpdatePhoneNumberLengthEvent {
  final int currentPhoneNumberLength;

  const FetchCurrentPhoneNumberLengthFromTextEditingControllerEvent(
      {required this.currentPhoneNumberLength});
}
