import 'package:flutter/material.dart';

class UpdateUserProfileNameTextFormField extends StatelessWidget {
  const UpdateUserProfileNameTextFormField(
      {super.key,
      required this.phoneNumberTextEditingController,
      required this.labelText});

  final TextEditingController phoneNumberTextEditingController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return "Name is required";
          } else {
            return null;
          }
        },
        maxLines: 1,
        cursorColor: Colors.green,
        cursorHeight: 15,
        controller: phoneNumberTextEditingController,
        onChanged: (value) {},
        style: const TextStyle(color: Colors.teal),
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
            Icons.person_outline_rounded,
            color: Colors.cyan,
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
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.cyan),
        ),
      ),
    );
  }
}
