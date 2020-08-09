import 'package:fire_manager/app/locator.dart';
import 'package:fire_manager/common/ui/busy_button.dart';
import 'package:fire_manager/ui/views/items/items_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class AddItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemViewModel>.nonReactive(
      builder: (BuildContext context, ItemViewModel model, Widget child) =>
          Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Add item.",
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
              const SizedBox(
                height: 12,
              ),
              _AddItemForm(),
            ],
          ),
        ),
      ),
      disposeViewModel: false,
      viewModelBuilder: () => locator<ItemViewModel>(),
    );
  }
}

class _AddItemForm extends HookViewModelWidget<ItemViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget buildViewModelWidget(BuildContext context, ItemViewModel model) {
    final nameNode = useFocusNode();
    final companyNode = useFocusNode();
    final rateNode = useFocusNode();
    final tagNode = useFocusNode();
    final nameController = useTextEditingController();
    final companyController = useTextEditingController();
    final rateController = useTextEditingController();
    final tagController = useTextEditingController();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              focusNode: nameNode,
              controller: nameController,
              validator: (val) {
                if (val.isEmpty) {
                  return "Empty name provided";
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(companyNode);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Name",
                labelText: "Name",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              focusNode: companyNode,
              controller: companyController,
              validator: (val) {
                if (val.isEmpty) {
                  return "Empty company provided";
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(rateNode);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Company",
                labelText: "Company",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              focusNode: rateNode,
              controller: rateController,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val.isEmpty) {
                  return "Empty rate provided";
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(tagNode);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Rate",
                labelText: "Rate",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              focusNode: tagNode,
              controller: tagController,
              validator: (val) {
                if (val.isEmpty) {
                  return "Empty tag provided";
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tag",
                labelText: "Tag",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BusyButton(
              busy: model.isBusy,
              title: "Add Item",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  model
                      .addItem(
                    name: nameController.text,
                    company: companyController.text,
                    tag: tagController.text,
                    rate: rateController.text,
                  )
                      .then(
                    (value) {
                      if (value is bool && value) {
                        // _formKey.currentState.reset();

                      }
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
