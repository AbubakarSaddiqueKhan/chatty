import 'package:chatty/View_Models/Blocs/Phone_Number_Page_Blocs/Update_Phone_Number_Length_BLoc/update_phone_number_length_bloc.dart';
import 'package:chatty/Views/Screens/otp_verifying_screen.dart';
import 'package:chatty/Views/Screens/phone_number_login_page.dart';
import 'package:chatty/Views/Screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.pageName:
      return CupertinoPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case PhoneNumberLoginPage.pageName:
      return CupertinoPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => UpdatePhoneNumberLengthBloc(),
          child: const PhoneNumberLoginPage(),
        ),
      );

    case OTPVerifyingScreen.pageName:
      return CupertinoPageRoute(
        builder: (context) => const OTPVerifyingScreen(),
      );

    default:
      null;
  }
}
