import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/Controller.dart';
import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MyController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: "/login",
        getPages: [
          GetPage(name: "/login", page: ()=> const LoginPage()),
          GetPage(name: "/home", page: ()=> const HomePage())
        ]
    );
  }
}