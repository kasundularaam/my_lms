class ValueValidator {
  static bool validateEmail({required String email}) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      return true;
    } else {
      return false;
    }
  }

  static bool validatePassword({required String password}) {
    if (password.length > 5) {
      return true;
    } else {
      return false;
    }
  }
}
