import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String name;
  final String tag;
  final String company;
  final String rate;
  final String id;

  ItemModel({
    this.name,
    this.tag,
    this.company,
    this.rate,
    this.id,
  });

  ItemModel copyWith({
    String name,
    String tag,
    String company,
    String rate,
    String id,
  }) {
    return ItemModel(
      name: name ?? this.name,
      tag: tag ?? this.tag,
      company: company ?? this.company,
      rate: rate ?? this.rate,
      id: id ?? this.id,
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'tag': tag,
      'company': company,
      'rate': rate,
      'id': id,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemModel(
      name: map['name'],
      tag: map['tag'],
      company: map['company'],
      rate: map['rate'],
      id: map['id'],
    );
  }
  factory ItemModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    if (!snapshot.exists) return null;
    final Map<String, dynamic> documentData = snapshot.data;
    return ItemModel(
      id: snapshot.documentID,
      company: documentData['company'],
      name: documentData['name'],
      tag: documentData['tag'],
      rate: documentData['rate'],
    );
  }
  @override
  String toString() {
    return 'ItemModel(name: $name, tag: $tag, company: $company, rate: $rate, id: $id)';
  }

  Map<String, String> toVisibleMap() {
    return {
      'name': name,
      'tag': tag,
      'company': company,
      'rate': rate,
    };
  }
}
