import 'dart:async';

import 'package:chatty/Views/Screens/phone_number_login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String pageName = "/splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double logoScaleValue = 0;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context)
          .pushReplacementNamed(PhoneNumberLoginPage.pageName),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(() {
              logoScaleValue = 1;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: AnimatedScale(
          duration: const Duration(seconds: 1),
          scale: logoScaleValue,
          child: SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
