import 'package:flutter/material.dart';
import 'package:lab_inventory/Api_Services/api_services.dart';
import 'package:lab_inventory/Models/location_categorie_model.dart';
import 'package:lab_inventory/view_locations.dart';
import 'package:lab_inventory/widget/custom_app_bar.dart';

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
              const PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ],
                  )),
              const PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
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
                  String str =
                      await api.deleteLocationCategory(lcModel.lcId.toString());
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
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: Text('Location'),
      ),
      body: Container(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        child: const Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewLocationCategory()));
        },
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
