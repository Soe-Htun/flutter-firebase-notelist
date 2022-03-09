import 'package:flutter/material.dart';
import 'package:flutter_firebase_notelist/controller/note_controller.dart';
import 'package:flutter_firebase_notelist/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import 'home_screen.dart';

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
  TextEditingController date = TextEditingController();
  
  DateTime selectedDate= DateTime.now();

class _DetailScreenState extends State<DetailScreen> {

   _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: selectedDate, 
      firstDate: DateTime(2015), 
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: Get.arguments['name']);
    amountController = TextEditingController(text: Get.arguments['amount'].toString());
    date = TextEditingController(text: DateFormat('dd/MM/yyyy').format(selectedDate));
    return Scaffold(
      appBar: AppBar(
        title: Text('updateNote'.tr,),
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
                keyboardType: TextInputType.number,
                controller: amountController,
                text: 'amount'.tr,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: date,
                style: const TextStyle(
                  fontSize: 20,
                  color: kBackgroundColor
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              Expanded(child: Container()),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width,             
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                  onPressed: (){
                    noteController.updateNote(
                      nameController.text, 
                      double.parse(amountController.text.toString()), 
                      Get.arguments['id'],
                      selectedDate
                    );
                    Get.snackbar('success'.tr,
                      'updateSuccess'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      animationDuration: const Duration(microseconds: 2000)
                    );
                    Get.off(const HomeScreen());
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