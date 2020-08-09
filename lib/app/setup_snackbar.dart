import 'package:fire_manager/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
// ignore: implementation_imports
import "package:get/src/navigation/snackbar/snack.dart";

enum SnackbarType { success, error }
void setupSnackbar() {
  final service = locator<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      backgroundColor: Colors.green,
      titleColor: Colors.white,
      messageColor: Colors.white,
      borderRadius: 1,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      backgroundColor: Colors.redAccent,
      titleColor: Colors.white,
      messageColor: Colors.white,
      borderRadius: 1,
    ),
  );
}
