class PhoneNumberValidation {
  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber!.isEmpty) {
      return "Phone Number is Required";
    } else {
      if (phoneNumber.isNotEmpty && phoneNumber.length < 11) {
        return "Invalid Phone Number";
      } else {
        return null;
      }
    }
  }
}
