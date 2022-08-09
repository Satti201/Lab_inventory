import 'package:flutter/material.dart';
import 'package:lab_inventory/inventory_home_page.dart';

import 'main.dart';

class SearchMenu {

  SearchMenu.selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  const InventoryHomePage()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  const InventoryHomePage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  const InventoryHomePage()));
        break;
    }
  }

}
