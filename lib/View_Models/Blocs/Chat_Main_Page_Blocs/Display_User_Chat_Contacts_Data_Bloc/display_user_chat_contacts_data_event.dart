part of 'display_user_chat_contacts_data_bloc.dart';

@immutable
sealed class DisplayUserChatContactsDataEvent {
  const DisplayUserChatContactsDataEvent();
}

class FetchAllUserContactDataFromFireStoreEvent
    extends DisplayUserChatContactsDataEvent {
  final List<String> userContactPhoneNumberList;

  const FetchAllUserContactDataFromFireStoreEvent(
      {required this.userContactPhoneNumberList});
}
