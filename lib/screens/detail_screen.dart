import 'package:flutter/material.dart';
import 'package:flutter_firebase_notelist/controller/note_controller.dart';
import 'package:flutter_firebase_notelist/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../constants.dart';

class DetailScreen extends StatefulWidget {
  // final String name;
  // final double amount;
  const DetailScreen({ Key? key,
    // required this.name,
    // required this.amount
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}
  final NoteController noteController = Get.put(NoteController());
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();


class _DetailScreenState extends State<DetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: Get.arguments['name']);
    amountController = TextEditingController(text: Get.arguments['amount'].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('updateNote'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFIeld(
                controller: nameController,
                text: 'name'.tr,
              ),
              const SizedBox(height: 10),
              CustomTextFIeld(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
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
                    noteController.updateNote(
                      nameController.text, 
                      double.parse(amountController.text.toString()), 
                      Get.arguments['id']
                    );
                    Get.snackbar('success'.tr,
                      'updateSuccess'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      animationDuration: const Duration(microseconds: 2000)
                    );
                    Get.back();
                  }, 
                  child: Text(
                    'updateNote'.tr,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kTextColor),
                  )
                ),
              )
            ],
          )
      ),
    );
  }
}