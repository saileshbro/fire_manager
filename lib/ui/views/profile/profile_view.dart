import 'package:fire_manager/app/locator.dart';
import 'package:fire_manager/common/ui/busy_button.dart';
import 'package:fire_manager/ui/views/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, ProfileViewModel model, child) => Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "You are currently logged in as:",
                        style: TextStyle(color: Colors.black, fontSize: 26),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        model.loggedInUserEmail,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BusyButton(
                        busy: false,
                        title: "Change Password",
                        onPressed: model.onChangePasswordPressed,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BusyButton(
                        busy: model.isBusy,
                        title: "Logout",
                        onPressed: model.logout,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        disposeViewModel: false,
        viewModelBuilder: () => locator<ProfileViewModel>());
  }
}
