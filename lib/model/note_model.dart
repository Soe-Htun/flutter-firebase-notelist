
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? docId;
  String? name;
  double? amount;
  // late Timestamp createdDate;

  NoteModel({
    this.docId,
    this.name,
    this.amount,
    // required this.createdDate
  });

  NoteModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"];
    amount = data["amount"];
    // createdDate = data["createdDate"];
  }
}