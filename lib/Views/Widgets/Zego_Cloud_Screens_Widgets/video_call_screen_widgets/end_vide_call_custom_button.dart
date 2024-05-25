import 'package:chatty/View_Models/Custom_Codes/zego_cloud_send_call_invitation_custom_code.dart';
import 'package:flutter/material.dart';

class EndVideCallCustomButton extends StatelessWidget {
  const EndVideCallCustomButton({super.key, required this.callId});
  final String callId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.red),
        ),
        onPressed: () async {
          await quitOnGoingCall(callId: callId, context: context);
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.call_end,
          size: 30,
          color: Colors.white,
        ));
  }
}
