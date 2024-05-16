import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;
part 'update_user_contacts_length_event.dart';
part 'update_user_contacts_length_state.dart';

class UpdateUserContactsLengthBloc
    extends Bloc<UpdateUserContactsLengthEvent, UpdateUserContactsLengthState> {
  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();

  SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
      SharedPreferenceLocalDataBase();

  List<String> userAllContactsPhoneNumber = [];
  UpdateUserContactsLengthBloc()
      : super(UpdateUserContactsLengthInitialState()) {
    on<UpdateUserContactListFromGivenFirebaseContactListEvent>(
        _mapUpdateUserContactListFromGivenFirebaseContactListEventToStates);
  }

  FutureOr<void>
      _mapUpdateUserContactListFromGivenFirebaseContactListEventToStates(
          UpdateUserContactListFromGivenFirebaseContactListEvent event,
          Emitter<UpdateUserContactsLengthState> emit) async {
    emit(UpdateUserContactsLengthLoadingState());
    try {
      String? userMobileNumber = await sharedPreferenceLocalDataBase
          .fetchUserPhoneNumberFromLocalDatabase();

      userAllContactsPhoneNumber =
          await fireBaseFireStoreDatBase.fetchAllChatContactsOfGivenNumber(
              userPhoneNumber: userMobileNumber!);

      developer.log(
          "User all contacts. ..... ${userAllContactsPhoneNumber.toString()}");

      emit(UpdateUserContactsLengthLoadedState(
          userContactPhoneNumberList: userAllContactsPhoneNumber));
    } catch (e) {
      emit(UpdateUserContactsLengthErrorState());
    }
  }
}
