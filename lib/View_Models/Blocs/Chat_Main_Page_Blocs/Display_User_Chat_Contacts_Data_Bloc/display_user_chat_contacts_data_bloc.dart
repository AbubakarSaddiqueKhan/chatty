import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;
part 'display_user_chat_contacts_data_event.dart';
part 'display_user_chat_contacts_data_state.dart';

class DisplayUserChatContactsDataBloc extends Bloc<
    DisplayUserChatContactsDataEvent, DisplayUserChatContactsDataState> {
  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();

  List<UserContactDetail> userContactDetailList = [];

  DisplayUserChatContactsDataBloc()
      : super(DisplayUserChatContactsDataInitialState()) {
    on<FetchAllUserContactDataFromFireStoreEvent>(
        _mapFetchAllUserContactDataFromFireStoreEventToStates);
  }

  FutureOr<void> _mapFetchAllUserContactDataFromFireStoreEventToStates(
      FetchAllUserContactDataFromFireStoreEvent event,
      Emitter<DisplayUserChatContactsDataState> emit) async {
    try {
      for (var userPhoneNumber in event.userContactPhoneNumberList) {
        Map<String, dynamic>? contactData = await fireBaseFireStoreDatBase
            .fetchDataOfGivenPhoneNumber(phoneNumber: userPhoneNumber);

        String userDeviceToken =
            contactData?[FireBaseFireStoreDatBase.keyUserDeviceToken];

        String userFirstName =
            contactData?[FireBaseFireStoreDatBase.keyUserFirstName];

        String userImageUrl =
            contactData?[FireBaseFireStoreDatBase.keyUserImageURL];

        String userPhoneNumberData =
            contactData?[FireBaseFireStoreDatBase.keyUserPhoneNumber];

        String userLastName =
            contactData?[FireBaseFireStoreDatBase.keyUserPhoneNumber];

        UserContactDetail userContactDetail = UserContactDetail(
            userDeviceToken: userDeviceToken,
            userFirstName: userFirstName,
            userLastName: userLastName,
            userImageUrl: userImageUrl,
            userPhoneNumber: userPhoneNumber);

        developer.log("Current user data .... ${userContactDetail.toString()}");

        userContactDetailList.add(userContactDetail);
      }

      emit(DisplayUserChatContactsDataLoadedState(
          userContactDetailList: userContactDetailList));
    } catch (e) {
      print(e);
      emit(DisplayUserChatContactsDataErrorState());
    }
  }
}
