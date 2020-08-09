import 'package:fire_manager/app/locator.dart';
import 'package:fire_manager/common/ui/busy_button.dart';
import 'package:fire_manager/ui/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      builder: (BuildContext context, LoginViewModel model, Widget child) =>
          Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 100,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Login.",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              _LoginForm(),
            ],
          ),
        ),
      ),
      disposeViewModel: false,
      viewModelBuilder: () => locator<LoginViewModel>(),
    );
  }
}

class _LoginForm extends HookViewModelWidget<LoginViewModel> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel model) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final emailNode = useFocusNode();
    final passwordNode = useFocusNode();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: email,
              focusNode: emailNode,
              validator: model.validateEmail,
              onChanged: model.updateEmail,
              // ignore: prefer_const_literals_to_create_immutables
              autofillHints: [AutofillHints.email],
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(passwordNode);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
                labelText: "Email",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: password,
              focusNode: passwordNode,
              validator: model.validatePassword,
              onChanged: model.updatePassword,
              // ignore: prefer_const_literals_to_create_immutables
              autofillHints: [AutofillHints.password],
              obscureText: true,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
                labelText: "Password",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BusyButton(
              busy: model.isBusy,
              title: "Login",
              onPressed: () {
                if (formKey.currentState.validate()) {
                  model.login();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
