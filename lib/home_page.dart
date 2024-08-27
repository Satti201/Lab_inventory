import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_inventory/Models/role_model.dart';
import 'package:lab_inventory/Models/user_model.dart';
import 'package:lab_inventory/admin_home_page/view_user.dart';
import 'package:lab_inventory/inventory_home_page.dart';
import 'package:lab_inventory/location_home_page.dart';
import 'package:lab_inventory/search_menu.dart';
import 'package:lab_inventory/view_demand.dart';
import 'package:lab_inventory/widget/custom_app_bar.dart';

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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        //backgroundColor: Colors.blue[900],
        title: const Text('Home Page'),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.deepPurple,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                padding: EdgeInsets.all(8.0),
                value: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          'used',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                padding: EdgeInsets.all(8.0),
                value: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          'Faulty',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                padding: EdgeInsets.all(8.0),
                value: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.deepPurple,
                        ),
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
      body: SingleChildScrollView(
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
                            builder: (context) =>
                                ViewUser1(widget.userModel, widget._roleList)));
                  });
                },
                child: buildWrapWidget(icon: Icons.person, title: 'Accounts'),
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
                child: buildWrapWidget(
                    icon: Icons.list_alt_outlined, title: 'Inventory'),
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
                child: buildWrapWidget(
                    icon: Icons.location_pin, title: 'Location'),
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
                child: buildWrapWidget(
                    icon: Icons.list_alt_rounded, title: 'Demand'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildWrapWidget({required IconData icon, required String title}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              width: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: CupertinoColors.lightBackgroundGray,
              ),
              child: Icon(
                icon,
                color: Colors.deepPurple,
                size: 80,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
}
