part of 'fetch_all_chat_of_given_user_bloc.dart';

@immutable
sealed class FetchAllChatOfGivenUserState {
  const FetchAllChatOfGivenUserState();
}

final class FetchAllChatOfGivenUserInitialState
    extends FetchAllChatOfGivenUserState {}

final class FetchAllChatOfGivenUserLoadingState
    extends FetchAllChatOfGivenUserState {}

final class FetchAllChatOfGivenUserLoadedState
    extends FetchAllChatOfGivenUserState {
  final List<ChatDetailModel> allChatsOfUserList;

  const FetchAllChatOfGivenUserLoadedState({required this.allChatsOfUserList});
}

final class FetchAllChatOfGivenUserErrorState
    extends FetchAllChatOfGivenUserState {}
