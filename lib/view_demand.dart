import 'package:flutter/material.dart';
import 'package:lab_inventory/Api_Services/api_services.dart';
import 'package:lab_inventory/Models/demand_model.dart';
import 'package:lab_inventory/Models/role_model.dart';
import 'package:lab_inventory/Models/user_model.dart';
import 'package:lab_inventory/admin_home_page/view_users_details.dart';
import 'package:lab_inventory/logout_menu.dart';
import 'package:lab_inventory/widget/custom_app_bar.dart';

class ViewDemand extends StatelessWidget {
  const ViewDemand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: const Text('Demand'),
        actions: [
          PopupMenuButton<int>(
            offset: const Offset(-10, 40),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "Logout",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
            onSelected: (item) => LogMenu.selectedItem(context, item),
          ),
        ],
      ),
      body: const _ViewDemandBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Demand',
        elevation: 20,
        child: const Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
        onPressed: () {},
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

                      dataRowMinHeight: 40,
                      dataTextStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      headingRowColor: WidgetStateColor.resolveWith(
                          (states) => Colors.transparent),
                      headingRowHeight: 40,
                      headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
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
