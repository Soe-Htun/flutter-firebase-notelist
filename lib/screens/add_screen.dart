import 'package:flutter_firebase_notelist/constants.dart';
import 'package:flutter_firebase_notelist/controller/note_controller.dart';
import 'package:flutter_firebase_notelist/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScreen extends StatelessWidget {
  AddScreen({ Key? key }) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  NoteController noteController = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('addNote'.tr),
        centerTitle: true,
        // elevation: 0,
        // backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFIeld(
              controller: name,
              text: 'name'.tr,
            ),
            const SizedBox(height: 10),
            CustomTextFIeld(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: amount,
              text: 'amount'.tr,
            ),
            Expanded(child: Container()),
            Container(
              height: 55,
              width: double.infinity,             
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                onPressed: (){
                  noteController.addNote(
                    name.text, 
                    double.parse(amount.value.text.toString())
                  );
                  Get.snackbar('success'.tr,
                    'addSuccess'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                    animationDuration: const Duration(microseconds: 2000)
                  );
                  Get.back();
                }, 
                child: Text(
                  'addNote'.tr,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kTextColor),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}