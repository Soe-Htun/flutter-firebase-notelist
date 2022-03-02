
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? docId;
  String? name;
  double? amount;

  NoteModel({
    this.docId,
    this.name,
    this.amount,
  });

  NoteModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"];
    amount = data["amount"];
  }
}