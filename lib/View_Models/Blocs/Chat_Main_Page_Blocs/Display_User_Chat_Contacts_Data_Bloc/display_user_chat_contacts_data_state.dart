part of 'display_user_chat_contacts_data_bloc.dart';

@immutable
sealed class DisplayUserChatContactsDataState {
  const DisplayUserChatContactsDataState();
}

final class DisplayUserChatContactsDataInitialState
    extends DisplayUserChatContactsDataState {}

final class DisplayUserChatContactsDataLoadingState
    extends DisplayUserChatContactsDataState {}

final class DisplayUserChatContactsDataLoadedState
    extends DisplayUserChatContactsDataState {
  final List<UserContactDetail> userContactDetailList;

  const DisplayUserChatContactsDataLoadedState(
      {required this.userContactDetailList});
}

final class DisplayUserChatContactsDataErrorState
    extends DisplayUserChatContactsDataState {}
