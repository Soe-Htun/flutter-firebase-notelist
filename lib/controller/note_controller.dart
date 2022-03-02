
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_notelist/model/note_model.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<NoteModel> noteList = RxList<NoteModel>([]);

  RxList<NoteModel> noteModelList = RxList<NoteModel>([]);

  @override

  void onInit() {
    super.onInit();

    collectionReference = firebaseFirestore.collection("Notes");
    noteList.bindStream(getAllNotes());
    wait();
    noteModelList = noteList;
  }

  @override
  void onReady(){
    noteList.bindStream(getAllNotes());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void wait() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  void addNote(
    String name, double amount
  ){
    collectionReference.add({ 
      'name': name, 
      'amount': amount
    }).whenComplete(() {
      Get.snackbar('success'.tr,
        'addSuccess'.tr,
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(microseconds: 2000)
      );
    });
  }

  void updateNote(
    String name, double amount, String docId
  ) {
    collectionReference.doc(docId).update({
      'name': name,
      'amount': amount,
    });
  }

  Stream<List<NoteModel>> getAllNotes() =>
  collectionReference.snapshots().map((query) => 
    query.docs.map((item) => NoteModel.fromMap(item)).toList()
  );

  void deleteData(String docId) {
    collectionReference.doc(docId).delete();
  }
  
}