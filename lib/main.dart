import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_inventory/Models/user_model.dart';
import 'package:lab_inventory/pages/loginPage/login_page.dart';

import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoginPage(),
    );
  }
}
