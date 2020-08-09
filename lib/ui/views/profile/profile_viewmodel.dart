import 'package:fire_manager/app/setup_snackbar.dart';
import 'package:fire_manager/services/authentication_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class ProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;
  final NavigationService _navigationService;
  final SnackbarService _snackbarService;
  ProfileViewModel(this._authenticationService, this._navigationService,
      this._snackbarService);

  String get loggedInUserEmail => _authenticationService.userEmail;
  Future<void> logout() async {
    setBusy(true);
    await _authenticationService.logout();
    _navigationService.back();
    setBusy(false);
  }

  Future<void> onChangePasswordPressed() async {
    await _authenticationService.changePassword();
    await _authenticationService.logout();
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.success,
      title: "Password reset",
      message: "Password reset link sent to email!\nPlease login again",
      duration: const Duration(seconds: 2),
    );
  }
}
