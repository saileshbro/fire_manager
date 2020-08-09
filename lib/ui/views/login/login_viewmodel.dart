import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class LoginViewModel extends BaseViewModel {
  String _email;
  String _password;

  String validateEmail(String value) {
    if (value.contains("@")) {
      return null;
    }
    return "Invalid email provided!";
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return "Minimum 8 letters required.";
    }
    return null;
  }

  // ignore: use_setters_to_change_properties
  void updateEmail(String email) {
    _email = email;
  }

  // ignore: use_setters_to_change_properties
  void updatePassword(String password) {
    _password = password;
  }

  void login() {}
}
