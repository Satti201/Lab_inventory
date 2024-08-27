import 'package:flutter/material.dart';
import 'package:lab_inventory/pages/loginPage/login_page.dart';

class LogMenu {
  LogMenu.selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false);
        break;
    }
  }
}
