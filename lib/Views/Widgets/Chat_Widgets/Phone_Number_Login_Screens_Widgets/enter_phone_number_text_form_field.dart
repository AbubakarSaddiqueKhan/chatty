import 'package:chatty/View_Models/Validations/phone_number_validation.dart';
import 'package:chatty/View_Models/Blocs/Phone_Number_Page_Blocs/Update_Phone_Number_Length_BLoc/update_phone_number_length_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterPhoneNumberTextFormField extends StatelessWidget {
  const EnterPhoneNumberTextFormField(
      {super.key, required this.phoneNumberTextEditingController});

  final TextEditingController phoneNumberTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          return PhoneNumberValidation.validatePhoneNumber(value);
        },
        maxLength: 11,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLines: 1,
        controller: phoneNumberTextEditingController,
        onChanged: (value) {
          context.read<UpdatePhoneNumberLengthBloc>().add(
              FetchCurrentPhoneNumberLengthFromTextEditingControllerEvent(
                  currentPhoneNumberLength: value.length));
        },
        style: const TextStyle(color: Colors.brown),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.teal,
              width: 2,
              strokeAlign: 2,
            ),
          ),
          icon: const Icon(
            Icons.phone,
            color: Colors.cyan,
          ),
          counter: BlocBuilder<UpdatePhoneNumberLengthBloc,
              UpdatePhoneNumberLengthState>(
            builder: (context, state) {
              if (state is UpdatePhoneNumberLengthInitialState) {
                return Text(
                  "${state.initialPhoneNumberLength}/11",
                  style: const TextStyle(color: Colors.amber),
                );
              } else if (state is UpdatePhoneNumberLengthLoadedState) {
                return Text(
                  "${state.currentPhoneNumberLength}/11",
                  style: const TextStyle(color: Colors.amber),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.cyan, strokeAlign: 2, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.red, strokeAlign: 2, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.cyan, strokeAlign: 2, width: 2)),
          labelText: "Phone Number",
          labelStyle: const TextStyle(color: Colors.cyan),
        ),
      ),
    );
  }
}
