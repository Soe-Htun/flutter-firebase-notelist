import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notelist/constants.dart';
import 'package:flutter_firebase_notelist/services/lang_services.dart';
import 'package:flutter_firebase_notelist/screens/add_screen.dart';
import 'package:flutter_firebase_notelist/screens/edit_screen.dart';
import 'package:flutter_firebase_notelist/screens/home_screen.dart';
import 'package:get/get.dart';

import 'helper/binding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      // translations: Messages(),
      // translationsKeys: AppTranslation.translationKeys ,
      // locale: const Locale('my', 'MM'),
      // locale: Get.deviceLocale,
      // fallbackLocale: const Locale('my', 'MM'),

      translations: LangService(),
      locale: LangService.locale,
      fallbackLocale: LangService.callBackLocale,

      theme: ThemeData(
        primarySwatch: Palatte.kColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor, displayColor: kTextColor)
      ),
      // home: HomeScreen(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const HomeScreen()),
        GetPage(name: "/edit", page: () => const DetailScreen()),
        GetPage(name: "/add", page: () => AddScreen(), fullscreenDialog: true)
      ],
    );
  }
}

class Palatte {
  static const MaterialColor kColor = MaterialColor(
    0xFF0C9869,
     <int, Color> {
      50: Color(0xFF0C9869),
      100: Color(0xFF0C9869),
      200: Color(0xFF0C9869),
      300: Color(0xFF0C9869),
      400: Color(0xFF0C9869),
      500: Color(0xFF0C9869),
      600: Color(0xFF0C9869),
      700: Color(0xFF0C9869),
      800: Color(0xFF0C9869),
      900: Color(0xFF0C9869) 
    }
  );
}