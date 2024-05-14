part of 'upload_suer_data_to_firebase_firestore_bloc.dart';

@immutable
sealed class UploadSuerDataToFirebaseFirestoreState {}

final class UploadSuerDataToFirebaseFirestoreInitialState
    extends UploadSuerDataToFirebaseFirestoreState {}

final class UploadSuerDataToFirebaseFirestoreLoadingState
    extends UploadSuerDataToFirebaseFirestoreState {}

final class UploadSuerDataToFirebaseFirestoreLoadedState
    extends UploadSuerDataToFirebaseFirestoreState {}

final class UploadSuerDataToFirebaseFirestoreErrorState
    extends UploadSuerDataToFirebaseFirestoreState {}
