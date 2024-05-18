import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Firebase/Firebase_Firestore_Database/firebase_fire_store.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:chatty/Views/Screens/find_user_screen.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

part 'fetch_user_data_from_firestore_event.dart';
part 'fetch_user_data_from_firestore_state.dart';

class FetchUserDataFromFirestoreBloc extends Bloc<
    FetchUserDataFromFirestoreEvent, FetchUserDataFromFirestoreState> {
  FireBaseFireStoreDatBase fireBaseFireStoreDatBase =
      FireBaseFireStoreDatBase();
  FetchUserDataFromFirestoreBloc()
      : super(FetchUserDataFromFirestoreInitialState()) {
    on<FetchUserDataFromFirestoreEvent>(
        _mapFetchUserDataFromFirestoreEventToStates);
  }

  FutureOr<void> _mapFetchUserDataFromFirestoreEventToStates(
      FetchUserDataFromFirestoreEvent event,
      Emitter<FetchUserDataFromFirestoreState> emit) async {
    try {
      emit(FetchUserDataFromFirestoreLoadingState());

      SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
          SharedPreferenceLocalDataBase();
      String? userMobileNumber = await sharedPreferenceLocalDataBase
          .fetchUserPhoneNumberFromLocalDatabase();

      Map<String, dynamic>? userData = await fireBaseFireStoreDatBase
          .fetchDataOfGivenPhoneNumber(phoneNumber: userMobileNumber!);

      String userDeviceToken =
          userData?[FireBaseFireStoreDatBase.keyUserDeviceToken];

      String userFirstName =
          userData?[FireBaseFireStoreDatBase.keyUserFirstName];

      String userImageUrl = userData?[FireBaseFireStoreDatBase.keyUserImageURL];

      String userPhoneNumberData =
          userData?[FireBaseFireStoreDatBase.keyUserPhoneNumber];

      String userLastName = userData?[FireBaseFireStoreDatBase.keyUserLastName];

      UserContactDetail userContactDetail = UserContactDetail(
          userDeviceToken: userDeviceToken,
          userFirstName: userFirstName,
          userLastName: userLastName,
          userImageUrl: userImageUrl,
          userPhoneNumber: userPhoneNumberData);

      developer.log("Current user data .... ${userContactDetail.toString()}");

      emit(FetchUserDataFromFirestoreLoadedState(userData: userContactDetail));
    } catch (e) {
      print(e);
      emit(FetchUserDataFromFirestoreErrorState());
    }
  }
}
