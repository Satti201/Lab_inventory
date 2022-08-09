
import 'package:flutter/material.dart';
import 'package:lab_inventory/Models/container_model.dart';
import 'package:lab_inventory/Models/location_model.dart';
import 'package:lab_inventory/item_details.dart';

import 'Api_Services/api_services.dart';
import 'logout_menu.dart';

class LocationItems extends StatelessWidget {
  final LocationModel lModel;
  const LocationItems(this.lModel, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightGreen[800],
      appBar: AppBar(
        //backgroundColor: Colors.green[900],
        title: const Text('Items'),
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
      body: _ViewLocationBody(lModel),
    );
  }
}

class _ViewLocationBody extends StatefulWidget {
  final LocationModel lModel;
  const _ViewLocationBody(this.lModel, {Key? key}) : super(key: key);

  @override
  _ViewLocationBodyState createState() => _ViewLocationBodyState();
}

class _ViewLocationBodyState extends State<_ViewLocationBody> {
  final ApiServices api = ApiServices();

  DataRow _createRow(ContainerModel containerModel) {
    return DataRow(
      key: ValueKey(containerModel.containerId),
      onSelectChanged: (selected) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemDetails(containerModel, widget.lModel.lName)));
      },
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text(containerModel.itemName),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text(containerModel.company),
          ),
        ),
        DataCell(
          Text(containerModel.totalAmount.toString()),
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
            _showLocationItemColumn(),
          ],
        ),
      ),
    );
  }

  _showLocationItemColumn() => Expanded(
    child: FutureBuilder<List<ContainerModel>>(
      future: api.fetchLocationItems(widget.lModel.lId.toString()),
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
                  label: Text('Item Name'),
                  numeric: false,
                  tooltip: 'Name',
                ),
                DataColumn(
                  label: Text('Company'),
                  numeric: false,
                  tooltip: 'Company',
                ),
                DataColumn(
                  label: Text('T.Amount'),
                  numeric: false,
                  tooltip: 'Total Amount',
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
