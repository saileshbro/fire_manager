import 'package:fire_manager/services/authentication_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class LoginViewModel extends BaseViewModel {
  String _email;
  String _password;
  final AuthenticationService _authenticationService;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  LoginViewModel(this._authenticationService, this._navigationService,
      this._dialogService);
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

  void updateEmail(String email) {
    _email = email;
  }

  void updatePassword(String password) {
    _password = password;
  }

  Future<void> login() async {
    setBusy(true);
    final result = await _authenticationService.loginWithEmail(
        email: _email, password: _password);
    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.back();
      } else {
        await _dialogService.showDialog(
            title: "Login Failure", description: "Unable to login");
      }
    } else {
      await _dialogService.showDialog(
          title: "Login Failure", description: result);
    }
  }
}
