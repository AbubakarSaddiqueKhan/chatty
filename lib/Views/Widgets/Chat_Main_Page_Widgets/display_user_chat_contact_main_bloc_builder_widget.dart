import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Display_User_Chat_Contacts_Data_Bloc/display_user_chat_contacts_data_bloc.dart';
import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Update_User_Contact_Length_Bloc/update_user_contacts_length_bloc.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/display_user_chat_contacts_bloc_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayUserChatContactMainBlocBuilderWidget extends StatelessWidget {
  const DisplayUserChatContactMainBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return BlocBuilder<UpdateUserContactsLengthBloc,
        UpdateUserContactsLengthState>(
      builder: (context, state) {
        if (state is UpdateUserContactsLengthInitialState) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.4,
                  width: width,
                ),
                const Text(
                  "Add User to start chatting with him / her",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.cyan,
                  ),
                ),
              ],
            ),
          );
        } else if (state is UpdateUserContactsLengthLoadingState) {
          return Column(
            children: [
              SizedBox(
                height: height * 0.4,
                width: width,
              ),
              const CircularProgressIndicator(
                color: Colors.cyan,
                strokeWidth: 5,
              ),
            ],
          );
        } else if (state is UpdateUserContactsLengthLoadedState) {
          context.read<DisplayUserChatContactsDataBloc>().add(
              FetchAllUserContactDataFromFireStoreEvent(
                  userContactPhoneNumberList:
                      state.userContactPhoneNumberList));
          List<String> userContactPhoneNumbersList =
              state.userContactPhoneNumberList;
          return DisplayUserChatContactsBlocBuilderWidget(
              userContactPhoneNumbersList: userContactPhoneNumbersList);
        } else {
          return const Center(
            child: Text(
              "Something went wrong at our side we are trying to manage it . Please wait sometime",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.cyan,
              ),
            ),
          );
        }
      },
    );
  }
}
