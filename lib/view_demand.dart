import 'package:flutter/material.dart';
import 'package:lab_inventory/Api_Services/api_services.dart';
import 'package:lab_inventory/Models/demand_model.dart';
import 'package:lab_inventory/Models/role_model.dart';
import 'package:lab_inventory/Models/user_model.dart';
import 'package:lab_inventory/admin_home_page/view_users_details.dart';
import 'package:lab_inventory/logout_menu.dart';

class ViewDemand extends StatelessWidget {
  const ViewDemand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightGreen[800],
      appBar: AppBar(
        //backgroundColor: Colors.green[900],
        title: const Text('Demand'),
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
      body: const _ViewDemandBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Demand',
        elevation: 20,
        //backgroundColor: Colors.lightGreen[900],
        //foregroundColor: Colors.yellowAccent,
        child: const Icon(Icons.add),
        //label: const Text('Add Program'),
        onPressed: () {},
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
}

class _ViewDemandBody extends StatefulWidget {
  const _ViewDemandBody({Key? key}) : super(key: key);

  @override
  _ViewDemandBodyState createState() => _ViewDemandBodyState();
}

class _ViewDemandBodyState extends State<_ViewDemandBody> {
  ApiServices api = ApiServices();
  List<DemandModel> _demandList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _refreshDemandList();
    });
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text('Name'),
        numeric: false,
        tooltip: 'Name',
      ),
      const DataColumn(
        label: Text('Qty'),
        numeric: false,
        tooltip: 'Qty',
      ),
      const DataColumn(
        label: Text('T. Expenditure'),
        numeric: false,
        tooltip: 'Total Expenditure',
      ),
    ];
  }

  DataRow _createRow(DemandModel demandModel) {
    return DataRow(
      key: ValueKey(demandModel.demandId),
      onSelectChanged: (selected) {
        /*
        String rName=getRoleType(userModel.roleId);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewUserDetails(userModel, rName)));
      */
      },
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text(demandModel.demandName),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text(demandModel.qty.toString()),
          ),
        ),
        DataCell(
          Text(demandModel.total.toString()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Divider(
            height: 10,
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      //columnSpacing: 60,
                      dividerThickness: 5,
/*
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple, width: 1)),
dataRowColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) => states.contains(MaterialState.selected)
                          ? Colors.blue
                          : Colors.grey),
*/

                      dataRowHeight: 80,
                      dataTextStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontSize: 16),
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey),
                      headingRowHeight: 80,
                      headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                      horizontalMargin: 10,
                      showBottomBorder: true,
                      showCheckboxColumn: false,
                      columns: _createColumns(),
                      rows: _demandList.map((e) => _createRow(e)).toList(),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _refreshDemandList() async {
    List<DemandModel> x = await api.fetchDemand();
    setState(() {
      _demandList = x;
    });
  }
}
