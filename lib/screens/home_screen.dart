
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_notelist/constants.dart';
import 'package:flutter_firebase_notelist/controller/lang_controller.dart';
import 'package:flutter_firebase_notelist/controller/note_controller.dart';
import 'package:flutter_firebase_notelist/screens/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteController noteController = Get.put(NoteController());

  final LangController langController = Get.put(LangController());

  // languageChooser(){
  // final List localeList = [
  //   {'name' : 'English', 'locale' : const Locale('en', 'US')},
  //   {'name' : 'Burmese', 'locale' : const Locale('bur', 'MN')},
  // ];

  // String dropdownValue = 'Burmese';
  

  languageChooser() {
    Get.defaultDialog(
      title: '',
      barrierDismissible: false,
      content: ListBody(
        children: [
          ListTile(
            title: const Text("English", style: TextStyle(color: kBackgroundColor)),
            onTap: (){
              langController.changeLanguage('en', 'US');
              Get.back();
            },
          ),
          ListTile(
            title: const Text("Burmese", style: TextStyle(color: kBackgroundColor)),
            onTap: (){
              langController.changeLanguage('bur', 'MN');
              Get.back();
            },
          )
        ],
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'note'.tr, 
          // style: const TextStyle(color: kBackgroundColor),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
              languageChooser();
            }, 
            child: Text(
               locale, 
              style:const TextStyle(color: kTextColor),
            )
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshotData) {
            if(snapshotData.hasData) {
              return ListView.builder(
                itemCount: snapshotData.data!.docs.length,
                itemBuilder: (context, index) {
                  final noteID = noteController.noteList[index];
                  final DocumentSnapshot documentSnapshot = snapshotData.data!.docs[index];
                  
                  return GestureDetector(
                    child: Card(
                      color: kPrimaryColor,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(documentSnapshot['name']),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(documentSnapshot['amount'].toString()),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: (){
                           // displayDeleteDialog(noteID.docId);
                              // Get.defaultDialog(
                              //   title: "delete".tr,
                              //   titleStyle: const TextStyle(fontSize: 20, color: kBackgroundColor),
                              //   middleText: 'sure ${documentSnapshot['name']} ?'.tr,
                              //   middleTextStyle: const TextStyle(color: kBackgroundColor),
                              //   textCancel: "cancel".tr,
                              //   cancelTextColor: kBackgroundColor,
                              //   textConfirm: "confirm".tr,
                              //   confirmTextColor: kBackgroundColor,
                              //   onCancel: (){
                              //     Get.back();
                              //   },
                              //   onConfirm: () {
                              //     noteController.deleteData(noteID.docId!);
                              //     Get.back();
                              //     Get.snackbar(
                              //       'success'.tr,
                              //       'deleteSuccess'.tr,
                              //       snackPosition: SnackPosition.BOTTOM,
                              //       animationDuration: const Duration(microseconds: 2000)
                              //     );
                              //   }
                              // );

                              Get.defaultDialog(
                                title: "delete".tr,
                                titleStyle: const TextStyle(fontSize: 20, color: kBackgroundColor),
                                content: Column(
                                  children: [
                                    // RichText(text: text)
                                    // Text('Hi', style: const TextStyle(color: kBackgroundColor),),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'sure'.tr,
                                            style: const TextStyle(color: kBackgroundColor) 
                                          ),
                                          TextSpan(
                                            text: " ${documentSnapshot['name']} ?",
                                            style: const TextStyle(color: kBackgroundColor)
                                          )
                                        ]
                                      )
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          child: Text("cancel".tr,
                                           style: const TextStyle(color: kBackgroundColor)
                                          ),
                                          onTap: () {
                                            Get.back();
                                          }
                                        ),
                                        GestureDetector(
                                          child: Text("confirm".tr, 
                                            style: const TextStyle(color: Colors.red)
                                          ),
                                          onTap: () {
                                            noteController.deleteData(noteID.docId!);
                                            Get.back();
                                            Get.snackbar(
                                              'success'.tr,
                                              'deleteSuccess'.tr,
                                              snackPosition: SnackPosition.BOTTOM,
                                              animationDuration: const Duration(microseconds: 2000)
                                            );
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                )
                              );
                          },
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed( "/details",
                        arguments: {
                          "id": noteID.docId,
                          "name" : documentSnapshot['name'].toString(),
                          "amount" : documentSnapshot['amount']
                        }
                      );
                    },
                  ); 
                }
              );
            } 

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator()
              )
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed("/add");
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: kTextColor,
        ),
        backgroundColor: kPrimaryColor,
      ),
    );
  }

  // displayDeleteDialog(String? docId) {
  //   Get.defaultDialog(
  //     title: "Delete Note",
  //     titleStyle: const TextStyle(fontSize: 20, color: kBackgroundColor),
  //     middleText: 'Are you sure to delete notes ?',
  //     middleTextStyle: const TextStyle(color: kBackgroundColor),
  //     textCancel: "Cancel",
  //     cancelTextColor: kBackgroundColor,
  //     textConfirm: "Confirm",
  //     confirmTextColor: kBackgroundColor,
  //     onCancel: (){},
  //     onConfirm: () {
  //       noteController.deleteData(docId!);
  //       Get.back();
  //     }
  //   );
  // }
}