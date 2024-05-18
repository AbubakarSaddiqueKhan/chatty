part of 'fetch_all_chat_of_given_user_bloc.dart';

@immutable
sealed class FetchAllChatOfGivenUserEvent {
  const FetchAllChatOfGivenUserEvent();
}

class FetchAllChatsOfUserFromFirebaseFirestoreEvent
    extends FetchAllChatOfGivenUserEvent {
  final String userPhoneNumber;
  final String chatPersonPhoneNumber;

  const FetchAllChatsOfUserFromFirebaseFirestoreEvent(
      {required this.userPhoneNumber, required this.chatPersonPhoneNumber});
}
