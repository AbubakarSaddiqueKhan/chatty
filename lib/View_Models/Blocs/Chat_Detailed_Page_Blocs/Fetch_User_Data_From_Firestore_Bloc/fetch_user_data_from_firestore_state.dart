part of 'fetch_user_data_from_firestore_bloc.dart';

@immutable
sealed class FetchUserDataFromFirestoreState {
  const FetchUserDataFromFirestoreState();
}

final class FetchUserDataFromFirestoreInitialState
    extends FetchUserDataFromFirestoreState {}

final class FetchUserDataFromFirestoreLoadingState
    extends FetchUserDataFromFirestoreState {}

final class FetchUserDataFromFirestoreLoadedState
    extends FetchUserDataFromFirestoreState {
  final UserContactDetail userData;

  const FetchUserDataFromFirestoreLoadedState({required this.userData});
}

final class FetchUserDataFromFirestoreErrorState
    extends FetchUserDataFromFirestoreState {}
