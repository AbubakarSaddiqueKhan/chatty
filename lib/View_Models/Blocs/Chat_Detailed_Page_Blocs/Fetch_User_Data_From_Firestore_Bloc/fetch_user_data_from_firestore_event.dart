part of 'fetch_user_data_from_firestore_bloc.dart';

@immutable
sealed class FetchUserDataFromFirestoreEvent {
  const FetchUserDataFromFirestoreEvent();
}

class FetchUserAllDataFromFirebaseEvent
    extends FetchUserDataFromFirestoreEvent {
  const FetchUserAllDataFromFirebaseEvent();
}
