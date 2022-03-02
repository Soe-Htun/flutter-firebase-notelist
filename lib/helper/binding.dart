import 'package:flutter_firebase_notelist/controller/note_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteController());
  }
}