import 'package:chatty/View_Models/Authentication/firebase_phone_number_authentication.dart';
import 'package:chatty/Views/Screens/otp_verifying_screen.dart';
import 'package:chatty/Views/Widgets/Phone_Number_Login_Screens/enter_phone_number_text_form_field.dart';
import 'package:flutter/material.dart';

class PhoneNumberLoginPage extends StatefulWidget {
  const PhoneNumberLoginPage({super.key});
  static const String pageName = "/phoneNumberLoginPage";

  @override
  State<PhoneNumberLoginPage> createState() => _PhoneNumberLoginPageState();
}

late TextEditingController _phoneNumberTextEditingController;

final formKey = GlobalKey<FormState>();

class _PhoneNumberLoginPageState extends State<PhoneNumberLoginPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _phoneNumberTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 6,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "Enter Your Mobile Number We Will Send You OTP",
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        EnterPhoneNumberTextFormField(
                            phoneNumberTextEditingController:
                                _phoneNumberTextEditingController),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                PhoneAuthentication
                                    .sendVerificationCodeToPhoneNumber(
                                        _phoneNumberTextEditingController.text);
                                // Navigator.of(context)
                                //     .pushNamed(OTPVerifyingScreen.pageName);
                              }
                            },
                            child: Container(
                              width: width * 0.5,
                              height: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.cyan,
                                    width: 2,
                                  )),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}