import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String name;
  final String tag;
  final String company;
  final String rate;
  final String id;
  final String partNo;

  ItemModel({
    this.name,
    this.partNo,
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
    String partNo,
    String id,
  }) {
    return ItemModel(
      name: name ?? this.name,
      tag: tag ?? this.tag,
      company: company ?? this.company,
      rate: rate ?? this.rate,
      id: id ?? this.id,
      partNo: partNo ?? this.partNo,
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
      partNo: documentData['part no'],
    );
  }
  @override
  String toString() {
    return 'ItemModel(name: $name, tag: $tag, company: $company, rate: $rate, id: $id,partNo: $partNo)';
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'tag': tag,
      'company': company,
      'rate': rate,
      'part no': partNo,
    };
  }
}
