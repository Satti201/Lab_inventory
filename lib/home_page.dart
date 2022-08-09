import 'package:flutter/material.dart';
import 'package:lab_inventory/Models/role_model.dart';
import 'package:lab_inventory/Models/user_model.dart';
import 'package:lab_inventory/admin_home_page/view_user.dart';
import 'package:lab_inventory/inventory_home_page.dart';
import 'package:lab_inventory/location_home_page.dart';
import 'package:lab_inventory/search_menu.dart';
import 'package:lab_inventory/view_demand.dart';

import 'logout_menu.dart';

class HomePage extends StatefulWidget {
  final List<UserModel> userList;
  final List<RolesModel> _roleList;
  final UserModel userModel;
  const HomePage(this.userList, this._roleList, this.userModel, {Key? key})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
      appBar: AppBar(
        //backgroundColor: Colors.blue[900],
        title: const Text('Home Page'),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          //color: Colors.yellow,
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        toolbarOpacity: 0.8,
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                padding: const EdgeInsets.all(8.0),
                value: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.search, color: Colors.red,),
                        Text(
                          'used',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                padding: const EdgeInsets.all(8.0),
                value: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.search, color: Colors.red,),
                        Text(
                          'Faulty',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                padding: const EdgeInsets.all(8.0),
                value: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.search, color: Colors.red,),
                        Text(
                          'Discard',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (item) => SearchMenu.selectedItem(context, item),
          ),
        ],
      ),
      body: Material(
        color: Colors.white70,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewUser1(
                                  widget.userModel, widget._roleList)));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        width: 2,
                        color: Colors.indigo,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.green,
                          height: 100,
                          width: 150,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Accounts',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InventoryHomePage()));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        width: 2,
                        color: Colors.indigo,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.green,
                          height: 100,
                          width: 150,
                          child: const Icon(
                            Icons.list_alt_outlined,
                            color: Colors.white70,
                            size: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Inventory',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LocationHomePage()));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        width: 2,
                        color: Colors.indigo,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.green,
                          height: 100,
                          width: 150,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.white70,
                            size: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Location',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewDemand()));
                    });

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        width: 2,
                        color: Colors.indigo,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.green,
                          height: 100,
                          width: 150,
                          child: const Icon(
                            Icons.list_alt_rounded,
                            color: Colors.white70,
                            size: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Demand',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
