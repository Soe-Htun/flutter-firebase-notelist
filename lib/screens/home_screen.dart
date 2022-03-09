import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_notelist/constants.dart';
import 'package:flutter_firebase_notelist/services/lang_services.dart';
import 'package:flutter_firebase_notelist/controller/note_controller.dart';
import 'package:flutter_firebase_notelist/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteController noteController = Get.put(NoteController());

  TextEditingController searchController = TextEditingController();

  List<NoteModel> currentList = [];
  List<NoteModel> results = [];

  String searchKey = '';

  String _selectedLang = LangService.langs.first;

  Icon custIcon = const Icon(Icons.search);
  Widget cusSearchBar = Text('note'.tr);

  @override
  initState() {
    currentList = noteController.noteList;
    // final DateTime now = DateTime.now();
    // final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String formatted = formatter.format(now);
    // print("Formatted----- $formatted");
    super.initState();
  }

  customSearch(){
    // Text search = Text("search".tr);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        alignment: Alignment.centerLeft,
        child: TextField(
          controller: searchController,
          onChanged: (value) => _searchTips(value),
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            hintText: 'search'.tr,
            hintStyle: const TextStyle(color: kTextColor),
            border: InputBorder.none,
          ),
          
        ),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(lang,
              // style: TextStyle(color: kBackgroundColor),
            ),
          ),
          // child: lang == _selectedLang? 
          // Text(lang,
          //   style: const TextStyle(color: kBackgroundColor),
          // ) : Text(lang),
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
  
  @override
  Widget build(BuildContext context) {
    // String locale = Intl.getCurrentLocale();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: cusSearchBar,
        automaticallyImplyLeading: false,
        // leading: Text(Get.locale.toString() == "my_MM" ? "HI" : "Elde"),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                if(custIcon.icon == Icons.search) {
                  custIcon = const Icon(Icons.cancel);
                  cusSearchBar = customSearch();
                } else {
                  custIcon = const Icon(Icons.search);
                  cusSearchBar = Text('note'.tr);
                  clearSearchKey();
                }
              });
            },
            icon: custIcon
          ),
          const SizedBox(width: 18),
          // cus,
          // Text(DateTime.parse(timestamp.toDate().toString())),
          // Text(DateTime)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              languageChooser(),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshotData) {
            if(snapshotData.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator()
                )
              );
            } else if(snapshotData.data == null) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text("nodata".tr, 
                  style: const TextStyle(
                    color: kBackgroundColor,
                    fontSize: 20
                    ),
                  )
                )
              );
            } else {
              return ListView.builder(
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  // final noteID = noteController.noteList[index];
                  //final DocumentSnapshot documentSnapshot = snapshotData.data!.docs[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        // currentList[index].r
                        // currentList.removeAt(index);
                        Get.defaultDialog(
                          title: "delete".tr,
                          titleStyle: const TextStyle(fontSize: 20, color: kBackgroundColor),
                          content: Column(
                            children: [
                              // RichText(text: text)
                              // Text('Hi', style: const TextStyle(color: kBackgroundColor),),
                              Get.locale.toString() == "my_MM" ?
                              Text.rich(
                                TextSpan(
                                  children: [
                                    
                                    TextSpan(
                                      text: " ${currentList[index].name} ",
                                      style: const TextStyle(color: kBackgroundColor, fontWeight: FontWeight.bold)
                                    ),
                                    TextSpan(
                                      text: 'to'.tr,
                                      style: const TextStyle(color: kBackgroundColor) 
                                    ),
                                    TextSpan(
                                      text: 'sure'.tr,
                                      style: const TextStyle(color: kBackgroundColor) 
                                    )
                                  ]
                                )
                              ) 
                              :
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'sure'.tr,
                                      style: const TextStyle(color: kBackgroundColor) 
                                    ),
                                    TextSpan(
                                      text: " ${currentList[index].name} ?",
                                      style: const TextStyle(color: kBackgroundColor, fontWeight: FontWeight.bold)
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

                        // noteController.deleteData(currentList[index].docId!);
                        // Get.snackbar(
                        //   'success'.tr,
                        //   'deleteSuccess'.tr,
                        //   snackPosition: SnackPosition.BOTTOM,
                        //   animationDuration: const Duration(microseconds: 2000)
                        // );
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete,
                        color: Colors.white,
                      ),
                    ),

                    child: GestureDetector(
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
                          trailing: Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(currentList[index].datetime!.toDate().toString()))),
                        ),
                      ),
                      onTap: () {
                        Get.toNamed( "/edit",
                          arguments: {
                            "id": currentList[index].docId,
                            "name" : currentList[index].name.toString(),
                            "amount" : currentList[index].amount
                          }
                        );
                      },
                    ),
                  ); 
                }
              );
            } 

            // else if(snapshotData.connectionState == ConnectionState.waiting) {
            //   return SizedBox(
            //     height: MediaQuery.of(context).size.height,
            //     child: const Center(
            //       child: CircularProgressIndicator()
            //     )
            //   );
            // }
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
        // tooltip: 'TT',
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