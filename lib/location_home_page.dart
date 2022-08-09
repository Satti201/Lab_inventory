import 'package:flutter/material.dart';
import 'package:lab_inventory/Api_Services/api_services.dart';
import 'package:lab_inventory/Models/location_categorie_model.dart';
import 'package:lab_inventory/view_locations.dart';

import 'add_new_location_category.dart';

class LocationHomePage extends StatefulWidget {
  const LocationHomePage({Key? key}) : super(key: key);

  @override
  State<LocationHomePage> createState() => _LocationHomePageState();
}

class _LocationHomePageState extends State<LocationHomePage> {
  //final Future<List<LocationCategoryModel>> lCategory;
  ApiServices api = ApiServices();
  String dropDownValue = 'Labs';

  var items = ['Labs', 'Faculty', 'Office'];

  _LocationHomePageState(/*{required this.lCategory}*/);

  DataRow _createRow(LocationCategoryModel lcModel) {
    return DataRow(
      key: ValueKey(lcModel.lcId),
      onSelectChanged: (selected) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewLocations(lcModel)));
      },
      cells: <DataCell>[
        DataCell(
          Text(
            lcModel.lcName,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
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
                  String str = await api.deleteLocationCategory(lcModel.lcId.toString());
                  _showToast(context, str);
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
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.green[900],
        title: const Text('Location'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        toolbarOpacity: 0.8,
        elevation: 0,
      ),
      body: Material(
        color: Colors.grey[200],
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _showLocationCategoryColumn(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        backgroundColor: Colors.indigo[900],
        //foregroundColor: Colors.yellowAccent,
        child: const Icon(Icons.add),
        // label: const Text('Add Plo'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewLocationCategory()));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
        shape: const CircularNotchedRectangle(),
        color: Colors.green[900],
      ),
    );
  }

  _showLocationCategoryColumn() => Expanded(
        child: FutureBuilder<List<LocationCategoryModel>>(
          future: api.fetchLocationCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 0,
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
                        label: Text('Location Categories'),
                        numeric: false,
                        tooltip: 'categories name',
                      ),
                      DataColumn(
                        label: Text('pop up'),
                        numeric: false,
                        tooltip: 'Pop up',
                      ),
                    ],
                    rows: snapshot.data!.map((e) => _createRow(e)).toList(),
                  ),
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
