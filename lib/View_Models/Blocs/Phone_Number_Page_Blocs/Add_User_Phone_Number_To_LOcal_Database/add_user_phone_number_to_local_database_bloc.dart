import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatty/View_Models/Local_Database/shared_preference_locaal_data_base.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;
part 'add_user_phone_number_to_local_database_event.dart';
part 'add_user_phone_number_to_local_database_state.dart';

class AddUserPhoneNumberToLocalDatabaseBloc extends Bloc<
    AddUserPhoneNumberToLocalDatabaseEvent,
    AddUserPhoneNumberToLocalDatabaseState> {
  SharedPreferenceLocalDataBase sharedPreferenceLocalDataBase =
      SharedPreferenceLocalDataBase();
  AddUserPhoneNumberToLocalDatabaseBloc()
      : super(AddUserPhoneNumberToLocalDatabaseInitialState()) {
    on<AddGivenUserPhoneNumberToLocalDatabaseSharedPreferenceEvent>(
        _mapAddGivenUserPhoneNumberToLocalDatabaseSharedPreferenceEventToStates);
  }

  FutureOr<void>
      _mapAddGivenUserPhoneNumberToLocalDatabaseSharedPreferenceEventToStates(
          AddGivenUserPhoneNumberToLocalDatabaseSharedPreferenceEvent event,
          Emitter<AddUserPhoneNumberToLocalDatabaseState> emit) async {
    emit(AddUserPhoneNumberToLocalDatabaseLoadingState());
    try {
      String enteredPhoneNumber = event.userPhoneNumber;

      developer.log("Entered phone Number .... $enteredPhoneNumber");

      String userCorrectedPhoneNumber =
          enteredPhoneNumber.replaceFirst('+92', '0');

      developer.log("Corrected phone number ...... $userCorrectedPhoneNumber");

      bool isUserAdded = await sharedPreferenceLocalDataBase
          .addUserMobilePhoneNumberToLocalDatabase(
              phoneNumber: userCorrectedPhoneNumber);

      developer
          .log("Is user phone nunber added successfylly ..... $isUserAdded");

      emit(AddUserPhoneNumberToLocalDatabaseLoadedState(
          isUserPhoneNumberAddedSuccessfully: isUserAdded));
    } catch (e) {
      emit(AddUserPhoneNumberToLocalDatabaseErrorState());
    }
  }
}
