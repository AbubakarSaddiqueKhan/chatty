import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterOTPCustomWidget extends StatelessWidget {
  const EnterOTPCustomWidget({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan, width: 2)),
      child: Center(
        child: TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          cursorHeight: 12,
          controller: textEditingController,
          cursorColor: Colors.cyan,
          textAlignVertical: TextAlignVertical.center,
          style:
              const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
          maxLength: 1,
          maxLines: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              counter: SizedBox.shrink(), border: InputBorder.none),
        ),
      ),
    );
  }
}
