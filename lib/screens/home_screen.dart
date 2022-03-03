
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_notelist/constants.dart';
import 'package:flutter_firebase_notelist/services/lang_services.dart';
import 'package:flutter_firebase_notelist/controller/note_controller.dart';
import 'package:flutter_firebase_notelist/model/note_model.dart';
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

  // final LangController langController = Get.put(LangController());

  TextEditingController searchController = TextEditingController();

  List<NoteModel> currentList = [];
  List<NoteModel> results = [];

  // List<Map<String, dynamic>> currentList = [];
  String searchKey = '';

  String _selectedLang = LangService.langs.first;

  @override
  initState() {
    currentList = noteController.noteList;
    super.initState();
  }

  Widget customSearch(){
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 40,
            child: TextField(
              style: const TextStyle(color: Colors.black),
              controller: searchController,
              onChanged: (value) => _searchTips(value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                // suffixIcon: searchKey.isNotEmpty
                // ? CustomIconButton(
                //   onPress: _clearSearchKey,
                //   icon: Icons.clear)
                //   : null,
                suffixIcon: searchKey.isNotEmpty
                ? IconButton(
                  onPressed: (){
                    clearSearchKey();
                  },
                  icon:const Icon(Icons.clear)
                ) : null,

                filled: true,
                
                fillColor: const Color(0xfff5f6fa),
                hintText: 'Search...',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0
                  )
                )
              ),
              
            ),
          ),
        ],
      ),
    );
  }

  DropdownButton languageChooser() {
    return DropdownButton<String>(
      dropdownColor: kPrimaryColor,
      icon: const Icon(Icons.arrow_drop_down, color: kTextColor,),
      value: _selectedLang,
      items: LangService.langs.map((String lang) {
        return DropdownMenuItem<String>(
          child: Text(lang,
            // style: TextStyle(color: kBackgroundColor),
          ),
          value: lang,
        );
      }).toList(),
      onChanged: (String? val) {
        setState(() {
          _selectedLang = val!;
        });
        LangService().changeLanguage(val!);
      },
    );
  }

  void _searchTips(String enteredKey) {
    searchKey = enteredKey;

    if(searchKey.isEmpty) {
      // var results = noteController.noteList
      results = noteController.noteList;
    } else {
      results = noteController.noteList
      .where((val) => 
        val.name!.toLowerCase().contains(enteredKey.toLowerCase())).toList();
    }

    // Refresh UI
    setState(() {
      currentList = results;
    });
  }

  clearSearchKey() {
    searchController.clear();
    searchKey = '';
    _searchTips(searchKey);
  }



  Widget build(BuildContext context) {
    String locale = Intl.getCurrentLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'note'.tr,
        ),
        centerTitle: true,
        leadingWidth: 180,
        leading: customSearch(),
        actions: [
          // customSearch()
          languageChooser()
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
                  // final noteID = noteController.noteList[index];
                  //final DocumentSnapshot documentSnapshot = snapshotData.data!.docs[index];
                  
                  return GestureDetector(
                    child: Card(
                      color: kPrimaryColor,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(currentList[index].name.toString()),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(currentList[index].amount.toString()),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: (){
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
                                          text: " ${currentList[index].name} ?",
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
                                          noteController.deleteData(currentList[index].docId!);
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
                          "id": currentList[index].docId,
                          "name" : currentList[index].name.toString(),
                          "amount" : currentList[index].amount
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