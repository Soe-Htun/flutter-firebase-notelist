
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? docId;
  String? name;
  double? amount;
  Timestamp? datetime;

  NoteModel({
    this.docId,
    this.name,
    this.amount,
    this.datetime
  });

  NoteModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"];
    amount = data["amount"];
    datetime = data["datetime"];
    // createdDate = data["createdDate"];
  }
}