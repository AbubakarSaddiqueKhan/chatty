import 'package:chatty/Views/Widgets/OTP_Verifying_Screen_Widgets/enter_otp_custom_widget.dart';
import 'package:flutter/material.dart';

class EnterOtpCustomWidgetsList extends StatelessWidget {
  const EnterOtpCustomWidgetsList(
      {super.key,
      required this.otpFirstDigitTextEditingController,
      required this.otpSecondDigitTextEditingController,
      required this.otpThirdDigitTextEditingController,
      required this.otpForthDigitTextEditingController,
      required this.otpFifthDigitTextEditingController,
      required this.otpSixthDigitTextEditingController});
  final TextEditingController otpFirstDigitTextEditingController;
  final TextEditingController otpSecondDigitTextEditingController;
  final TextEditingController otpThirdDigitTextEditingController;
  final TextEditingController otpForthDigitTextEditingController;
  final TextEditingController otpFifthDigitTextEditingController;
  final TextEditingController otpSixthDigitTextEditingController;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
      height: 45,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EnterOTPCustomWidget(
                textEditingController: otpFirstDigitTextEditingController),
            EnterOTPCustomWidget(
                textEditingController: otpSecondDigitTextEditingController),
            EnterOTPCustomWidget(
                textEditingController: otpThirdDigitTextEditingController),
            EnterOTPCustomWidget(
                textEditingController: otpForthDigitTextEditingController),
            EnterOTPCustomWidget(
                textEditingController: otpFifthDigitTextEditingController),
            EnterOTPCustomWidget(
                textEditingController: otpSixthDigitTextEditingController)
          ],
        ),
      ),
    );
  }
}
