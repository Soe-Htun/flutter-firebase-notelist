
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_notelist/model/note_model.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<NoteModel> noteList = RxList<NoteModel>([]);


  // late final List<NoteModel> listData;
  // late List<Map<String, dynamic>> listData =[];

  @override

  void onInit() {
    super.onInit();

    collectionReference = firebaseFirestore.collection("Notes");
    noteList.bindStream(getAllNotes());
    wait();
  }

  @override
  void onReady(){
    noteList.bindStream(getAllNotes());
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  void wait() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  void addNote(
    String name, double amount
    , DateTime dateTime
  ){
    collectionReference.add({ 
      'name': name, 
      'amount': amount,
      // 'createdDate': createdDate
      'datetime' : dateTime
    }).whenComplete(() {
      Get.snackbar('success'.tr,
        'addSuccess'.tr,
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(microseconds: 2000)
      );
    });
  }

  void updateNote(
    String name, double amount, String docId, DateTime dateTime
  ) {
    collectionReference.doc(docId).update({
      'name': name,
      'amount': amount,
      'datetime': dateTime
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