import 'package:chatty/Model/user_contact_detail_data_model.dart';
import 'package:chatty/View_Models/Blocs/Chat_Detailed_Page_Blocs/Fetch_User_Data_From_Firestore_Bloc/fetch_user_data_from_firestore_bloc.dart';
import 'package:chatty/Views/Widgets/Chat_Detailed_Screen_Widgets/fetch_all_chat_custom_bloc_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayUserAllChatsCustomWidget extends StatelessWidget {
  const DisplayUserAllChatsCustomWidget(
      {super.key, required this.userContactDetail});
  final UserContactDetail userContactDetail;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 92,
      child: BlocBuilder<FetchUserDataFromFirestoreBloc,
          FetchUserDataFromFirestoreState>(
        builder: (context, state) {
          if (state is FetchUserDataFromFirestoreInitialState) {
            return const SizedBox.shrink();
          } else if (state is FetchUserDataFromFirestoreLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
                strokeWidth: 5,
              ),
            );
          } else if (state is FetchUserDataFromFirestoreLoadedState) {
            String userImageUrl = state.userData.userImageUrl;
            String userPhoneNumber = state.userData.userPhoneNumber;
            return FetchAllChatCustomBlocBuilderWidget(
                userContactDetail: userContactDetail,
                userImageUrl: userImageUrl,
                userPhoneNumber: userPhoneNumber);
          } else {
            return const Center(
              child: Text(
                "Something went wrong at our end . We are trying to fix it",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.cyan),
              ),
            );
          }
        },
      ),
    );
  }
}
