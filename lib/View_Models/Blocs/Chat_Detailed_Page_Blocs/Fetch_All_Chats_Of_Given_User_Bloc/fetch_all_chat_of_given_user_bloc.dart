import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatty/Model/chat_detail_model.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:meta/meta.dart';

part 'fetch_all_chat_of_given_user_event.dart';
part 'fetch_all_chat_of_given_user_state.dart';

class FetchAllChatOfGivenUserBloc
    extends Bloc<FetchAllChatOfGivenUserEvent, FetchAllChatOfGivenUserState> {
  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();
  List<ChatDetailModel> allChatsOfUser = [];
  FetchAllChatOfGivenUserBloc() : super(FetchAllChatOfGivenUserInitialState()) {
    on<FetchAllChatsOfUserFromFirebaseFirestoreEvent>(
        _mapFetchAllChatsOfUserFromFirebaseFirestoreEventToStates);
  }

  FutureOr<void> _mapFetchAllChatsOfUserFromFirebaseFirestoreEventToStates(
      FetchAllChatsOfUserFromFirebaseFirestoreEvent event,
      Emitter<FetchAllChatOfGivenUserState> emit) async {
    emit(FetchAllChatOfGivenUserLoadingState());
    try {
      allChatsOfUser =
          await fireBaseFireStoreDatBase.fetchAllChatsOfGivenContact(
              userPhoneNumber: event.userPhoneNumber,
              contactPhoneNumber: event.chatPersonPhoneNumber);

      emit(FetchAllChatOfGivenUserLoadedState(
          allChatsOfUserList: allChatsOfUser));
    } catch (e) {
      emit(FetchAllChatOfGivenUserErrorState());
    }
  }
}
