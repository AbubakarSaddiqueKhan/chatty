import 'package:flutter/material.dart';

class EndVideCallCustomButton extends StatelessWidget {
  const EndVideCallCustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.red),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.call_end,
          size: 30,
          color: Colors.white,
        ));
  }
}
