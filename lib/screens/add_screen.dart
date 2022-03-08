import 'package:flutter_firebase_notelist/constants.dart';
import 'package:flutter_firebase_notelist/controller/note_controller.dart';
import 'package:flutter_firebase_notelist/screens/home_screen.dart';
import 'package:flutter_firebase_notelist/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddScreen extends StatefulWidget {
  AddScreen({ Key? key }) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController name = TextEditingController();

  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();

  NoteController noteController = Get.put(NoteController());

  DateTime selectedDate= DateTime.now();

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
    date = TextEditingController(text: DateFormat('yyyy-MM-dd').format(selectedDate));
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
              keyboardType: TextInputType.number,
              controller: amount,
              text: 'amount'.tr,
            ),
            // TextButton(
            //   child: Text("${selectedDate.toLocal()}".split(' ')[0], 
            //     style: const TextStyle(color: kBackgroundColor),
            //   ),
            //   onPressed: () {
            //     _selectDate(context);
            //   },
            // ),
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
              width: double.infinity,             
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                onPressed: (){
                  noteController.addNote(
                    name.text, 
                    double.parse(amount.value.text.toString()),
                    selectedDate
                    // formatted
                    // DateTime.now()
                  );
                  Get.snackbar('success'.tr,
                    'addSuccess'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                    animationDuration: const Duration(microseconds: 2000)
                  );
                  Get.off(const HomeScreen());
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