import 'package:chatty/Views/Screens/update_user_profile_screen.dart';
import 'package:chatty/Views/Widgets/OTP_Verifying_Screen_Widgets/enter_otp_custom_widgets_list.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class OTPVerifyingScreen extends StatefulWidget {
  const OTPVerifyingScreen({super.key});
  static const String pageName = "/otpVerifyingPageName";

  @override
  State<OTPVerifyingScreen> createState() => _OTPVerifyingScreenState();
}

// late String userOtpCode;

late TextEditingController _otpFirstDigitTextEditingController;
late TextEditingController _otpSecondDigitTextEditingController;
late TextEditingController _otpThirdDigitTextEditingController;
late TextEditingController _otpForthDigitTextEditingController;
late TextEditingController _otpFifthDigitTextEditingController;
late TextEditingController _otpSixthDigitTextEditingController;

class _OTPVerifyingScreenState extends State<OTPVerifyingScreen> {
  late String userMobilePhoneNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _otpFirstDigitTextEditingController = TextEditingController();
    _otpSecondDigitTextEditingController = TextEditingController();
    _otpThirdDigitTextEditingController = TextEditingController();
    _otpForthDigitTextEditingController = TextEditingController();
    _otpFifthDigitTextEditingController = TextEditingController();
    _otpSixthDigitTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _otpFirstDigitTextEditingController.dispose();
    _otpSecondDigitTextEditingController.dispose();
    _otpThirdDigitTextEditingController.dispose();
    _otpForthDigitTextEditingController.dispose();
    _otpFifthDigitTextEditingController.dispose();
    _otpSixthDigitTextEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userMobilePhoneNumber =
        ModalRoute.of(context)!.settings.arguments as String;

    // userOtpCode = userDataRecord.$2;
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Enter Verification Code We We Send To Your Device",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
          EnterOtpCustomWidgetsList(
              otpFirstDigitTextEditingController:
                  _otpFirstDigitTextEditingController,
              otpSecondDigitTextEditingController:
                  _otpSecondDigitTextEditingController,
              otpThirdDigitTextEditingController:
                  _otpThirdDigitTextEditingController,
              otpForthDigitTextEditingController:
                  _otpForthDigitTextEditingController,
              otpFifthDigitTextEditingController:
                  _otpFifthDigitTextEditingController,
              otpSixthDigitTextEditingController:
                  _otpSixthDigitTextEditingController),
          InkWell(
            onTap: () {
              if (_otpFirstDigitTextEditingController.text.isEmpty ||
                  _otpSecondDigitTextEditingController.text.isEmpty ||
                  _otpThirdDigitTextEditingController.text.isEmpty ||
                  _otpForthDigitTextEditingController.text.isEmpty ||
                  _otpFifthDigitTextEditingController.text.isEmpty ||
                  _otpSixthDigitTextEditingController.text.isEmpty) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
                developer.log("Errrrrrrrrrrrrrrrrrrrrr");
              } else {
                String currentEnteredOTP =
                    "${_otpFirstDigitTextEditingController.text}${_otpSecondDigitTextEditingController.text}${_otpThirdDigitTextEditingController.text}${_otpForthDigitTextEditingController.text}${_otpFifthDigitTextEditingController.text}${_otpSixthDigitTextEditingController.text}";
                developer.log("Entered Otp..............$currentEnteredOTP");

                Navigator.of(context).pop(currentEnteredOTP);
              }
            },
            child: Container(
              width: width * 0.5,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              child: Text(
                "Verify OTP",
                style: TextStyle(
                    color: Colors.teal.shade300,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
