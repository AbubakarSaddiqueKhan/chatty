import 'package:chatty/View_Models/Blocs/Chat_Main_Page_Blocs/Display_User_Chat_Contacts_Data_Bloc/display_user_chat_contacts_data_bloc.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_local_chat_list.dart';
import 'package:chatty/Views/Widgets/Chat_Main_Page_Widgets/chat_main_page_custom_user_chat_buddies_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayUserChatContactsBlocBuilderWidget extends StatelessWidget {
  const DisplayUserChatContactsBlocBuilderWidget(
      {super.key, required this.userContactPhoneNumbersList});
  final List<String> userContactPhoneNumbersList;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return BlocBuilder<DisplayUserChatContactsDataBloc,
        DisplayUserChatContactsDataState>(
      builder: (context, state) {
        if (state is DisplayUserChatContactsDataInitialState) {
          return ChatMainPageCustomLocalChatList(
              userContactPhoneNumbersList: userContactPhoneNumbersList);
        } else if (state is DisplayUserChatContactsDataLoadingState) {
          return Column(
            children: [
              SizedBox(
                height: height * 0.4,
                width: width,
              ),
              const CircularProgressIndicator(
                color: Colors.lightBlueAccent,
                strokeWidth: 5,
              ),
            ],
          );
        } else if (state is DisplayUserChatContactsDataLoadedState) {
          return ChatMainPageCustomUserChatBuddiesWidget(state: state);
        } else {
          return ChatMainPageCustomLocalChatList(
              userContactPhoneNumbersList: userContactPhoneNumbersList);
        }
      },
    );
  }
}
