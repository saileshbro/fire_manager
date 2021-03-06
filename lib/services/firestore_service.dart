import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_manager/datamodels/item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final CollectionReference _itemsCollectionReference =
      Firestore.instance.collection("items");
  final StreamController<List<ItemModel>> _itemsController =
      StreamController<List<ItemModel>>();
  Stream<List<ItemModel>> get items => _itemsController.stream;
  FirestoreService() {
    _itemsCollectionReference.snapshots().listen(_onItemsChanged);
  }
  void _onItemsChanged(QuerySnapshot snapshot) {
    final List<ItemModel> list = _getItemsFromQuerySnapshot(snapshot);
    _itemsController.add(list);
  }

  List<ItemModel> _getItemsFromQuerySnapshot(QuerySnapshot snapshot) {
    final List<ItemModel> items = [];
    final List<DocumentSnapshot> documents = snapshot.documents;
    if (documents.isNotEmpty) {
      for (final DocumentSnapshot docSnapshot in documents) {
        items.add(ItemModel.fromDocumentSnapshot(docSnapshot));
      }
    }
    return items;
  }

  Future addItem({
    @required ItemModel model,
  }) async {
    await _itemsCollectionReference.add(model.toMap());
    return;
  }

  Future deleteItem(String id) async {
    final DocumentReference reference = _itemsCollectionReference.document(id);
    await reference.delete();
  }

  Future editItem({@required String id, @required ItemModel model}) async {
    final DocumentReference reference = _itemsCollectionReference.document(id);
    await reference.updateData(model.toMap());
  }
}
