import 'package:fire_manager/app/locator.dart';
import 'package:fire_manager/datamodels/item_model.dart';
import 'package:fire_manager/ui/views/items/items_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemViewModel>.reactive(
      builder: (BuildContext context, ItemViewModel model, Widget child) =>
          Scaffold(
        floatingActionButton: model.isLoggedIn
            ? FloatingActionButton(
                onPressed: model.onAddPressed,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null,
        appBar: AppBar(
          title: const Text("Items"),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: model.profilePressed,
            )
          ],
        ),
        body: _getBody(model, context),
      ),
      disposeViewModel: false,
      viewModelBuilder: () => locator<ItemViewModel>(),
    );
  }

  Widget _getBody(ItemViewModel model, BuildContext context) {
    if (model.items == null || model.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }
    if (model.hasError) {
      return Center(child: Text(model.modelError));
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columnSpacing: 8,
          sortColumnIndex: 1,
          showCheckboxColumn: false,
          horizontalMargin: 16,
          columns: model
              .getColumns()
              .map(
                (String item) => DataColumn(
                  label: Text(
                    item.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              .toList(),
          rows: model.items.asMap().entries.map(
            (entry) {
              final int index = entry.key;
              final ItemModel item = entry.value;
              return DataRow(
                onSelectChanged: model.isLoggedIn
                    ? (_) {
                        model.onEditPressed(item);
                      }
                    : null,
                cells: [
                  DataCell(Text((index + 1).toString())),
                  ...item.toMap().values.map(
                        (e) => DataCell(
                          Text(
                            e,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                  if (model.isLoggedIn)
                    const DataCell(
                      Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    )
                ].toList(),
                key: Key(item.id),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
