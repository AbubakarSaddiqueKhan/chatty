part of 'upload_suer_data_to_firebase_firestore_bloc.dart';

@immutable
sealed class UploadSuerDataToFirebaseFirestoreEvent {
  const UploadSuerDataToFirebaseFirestoreEvent();
}

class UploadUserProvidedDataToFirebaseFireStoreEvent
    extends UploadSuerDataToFirebaseFirestoreEvent {
  final String userDeviceToken;
  final String userFirstName;
  final String userLastName;
  final String userPhoneNumber;
  final String userImageUrl;

  const UploadUserProvidedDataToFirebaseFireStoreEvent(
      {required this.userDeviceToken,
      required this.userFirstName,
      required this.userLastName,
      required this.userPhoneNumber,
      required this.userImageUrl});
}
