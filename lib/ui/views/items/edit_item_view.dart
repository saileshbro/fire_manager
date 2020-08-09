import 'package:fire_manager/app/locator.dart';
import 'package:fire_manager/common/ui/busy_button.dart';
import 'package:fire_manager/datamodels/item_model.dart';
import 'package:fire_manager/ui/views/items/items_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class EditItemView extends StatelessWidget {
  final ItemModel itemModel;

  const EditItemView({Key key, @required this.itemModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemViewModel>.nonReactive(
      builder: (BuildContext context, ItemViewModel model, Widget child) =>
          Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.onDeletePressed(itemModel),
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Edit item.",
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
              const SizedBox(
                height: 12,
              ),
              _EditItemForm(itemModel),
            ],
          ),
        ),
      ),
      disposeViewModel: false,
      viewModelBuilder: () => locator<ItemViewModel>(),
    );
  }
}

class _EditItemForm extends HookViewModelWidget<ItemViewModel> {
  final ItemModel itemModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _EditItemForm(this.itemModel);
  @override
  Widget buildViewModelWidget(BuildContext context, ItemViewModel model) {
    final nameNode = useFocusNode();
    final companyNode = useFocusNode();
    final rateNode = useFocusNode();
    final tagNode = useFocusNode();
    final partNode = useFocusNode();
    final nameController = useTextEditingController(text: itemModel.name);
    final companyController = useTextEditingController(text: itemModel.company);
    final rateController = useTextEditingController(text: itemModel.rate);
    final tagController = useTextEditingController(text: itemModel.tag);
    final partController = useTextEditingController(text: itemModel.partNo);
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
                FocusScope.of(context).requestFocus(partNode);
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
            TextFormField(
              focusNode: partNode,
              controller: partController,
              validator: (val) {
                if (val.isEmpty) {
                  return "Empty part no provided";
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Part No",
                labelText: "Part No",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BusyButton(
              busy: model.isBusy,
              title: "Edit Item",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  model.editItem(
                    id: itemModel.id,
                    name: nameController.text,
                    company: companyController.text,
                    tag: tagController.text,
                    rate: rateController.text,
                    partNo: partController.text,
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
