
import 'package:flutter/material.dart';
import 'package:lab_inventory/Models/location_categorie_model.dart';
import 'package:lab_inventory/Models/location_model.dart';
import 'package:lab_inventory/location_items.dart';

import 'Api_Services/api_services.dart';
import 'logout_menu.dart';

class ViewLocations extends StatelessWidget {
  final LocationCategoryModel lcModel;
  const ViewLocations(this.lcModel, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightGreen[800],
      appBar: AppBar(
        //backgroundColor: Colors.green[900],
        title: const Text('Locations'),
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
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text("Logout")
                    ],
                  )),
            ],
            onSelected: (item) => LogMenu.selectedItem(context, item),
          ),
        ],
      ),
      body: _ViewLocationBody(lcModel),
    );
  }
}

class _ViewLocationBody extends StatefulWidget {
  final LocationCategoryModel lcModel;
  const _ViewLocationBody(this.lcModel, {Key? key}) : super(key: key);

  @override
  _ViewLocationBodyState createState() => _ViewLocationBodyState();
}

class _ViewLocationBodyState extends State<_ViewLocationBody> {
  final ApiServices api = ApiServices();

  DataRow _createRow(LocationModel lModel) {
    return DataRow(
      key: ValueKey(lModel.lId),
      onSelectChanged: (selected) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LocationItems(lModel)));
      },
      cells: [
        DataCell(
          Text(lModel.lName),
        ),
        DataCell(
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ],
                  )),
              PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ],
                  )),
            ],
            onSelected: (item) async {
              switch (item) {
                case 0:
                  break;
                case 1:
                  break;
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      //color: Colors.grey[200],
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        //padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _showLocationColumn(),
          ],
        ),
      ),
    );
  }

  _showLocationColumn() => Expanded(
    child: FutureBuilder<List<LocationModel>>(
      future: api.fetchLocation(widget.lcModel.lcId.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: DataTable(
              columnSpacing: 10,
              dividerThickness: 5,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 1)),
              dataRowHeight: 80,
              dataTextStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontSize: 16),
              headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey),
              headingRowHeight: 80,
              headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
              //horizontalMargin: 10,
              showBottomBorder: true,
              showCheckboxColumn: false,
              columns: const [
                DataColumn(
                  label: Text('Number'),
                  numeric: false,
                  tooltip: 'Name',
                ),
                DataColumn(
                  label: Text('Popup'),
                  numeric: false,
                  tooltip: 'Update and Delete',
                ),
              ],
              rows: snapshot.data!.map((e) => _createRow(e)).toList(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    ),
  );

  void _showToast(BuildContext context, String str) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          str,
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: SnackBarAction(
            label: 'Hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
