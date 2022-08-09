import 'package:flutter/material.dart';
import 'package:lab_inventory/Api_Services/api_services.dart';
import 'package:lab_inventory/Models/container_model.dart';
import 'package:lab_inventory/Models/location_model.dart';
import 'package:lab_inventory/item_details.dart';

class InventoryHomePage extends StatefulWidget {
  const InventoryHomePage({Key? key}) : super(key: key);

  @override
  State<InventoryHomePage> createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  ApiServices api=ApiServices();
  final stockController=TextEditingController();
  String qSearch='';
  List<ContainerModel>  _stockList=[];
  List<ContainerModel>  _newStockList=[];
  List<ContainerModel>  _usedList=[];
  List<ContainerModel>  _newUsedList=[];
  List<ContainerModel>  _faultyList=[];
  List<ContainerModel>  _newFaultyList=[];
  List<ContainerModel>  _discardList=[];
  List<ContainerModel>  _newDiscardList=[];
  List<LocationModel> _locationList=[];

  DataRow _createRow(ContainerModel containerModel) {
    return DataRow(
      key:  ValueKey(containerModel.containerId),
      onSelectChanged: (selected) {
        String locationName=_getLocationName(containerModel.locationId);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemDetails(containerModel, locationName)));
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
  void initState() {
    super.initState();
    setState(() {
      _refreshStockList();
      _refreshUsedList();
      _refreshFaultyList();
      _refreshDiscardList();
      _refreshLocationList();
      _newStockList=[];
    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("USED"),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("STOCK"),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("FAULTY"),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("DISCARD"),
                ),
              ),
            ],
          ),
          //backgroundColor: Colors.green[900],
          title: const Text('Inventory'),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          centerTitle: true,
          toolbarHeight: 80.0,
          toolbarOpacity: 0.8,
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            _used(),
            _stock(),
            _faulty(),
            _discard(),
          ],
        ),
      ),
    );
  }

  _discard()=>Container(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white70,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: const EdgeInsets.all(5.0),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              labelText: 'Search',
              labelStyle: const TextStyle(
                letterSpacing: 2.0,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Search Here',
              hintStyle: const TextStyle(
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            controller: stockController,
            keyboardType: TextInputType.text,
            onChanged: (value){
              setState(() {
                qSearch=value;/*
                    stockController.addListener(() {
                      _newStockList=_getNewStockList(qSearch);});*/
                _newDiscardList=_getNewDiscardList(qSearch);
              });
            },
            onSubmitted: (value){
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        qSearch==''?_showDiscard():_showDiscardSearchedData(),
      ],
    ),
  );

  _used() => Container(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white70,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: const EdgeInsets.all(5.0),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              labelText: 'Search',
              labelStyle: const TextStyle(
                letterSpacing: 2.0,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Search Here',
              hintStyle: const TextStyle(
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            controller: stockController,
            keyboardType: TextInputType.text,
            onChanged: (value){
              setState(() {
                qSearch=value;/*
                    stockController.addListener(() {
                      _newStockList=_getNewStockList(qSearch);});*/
                _newUsedList=_getNewUsedList(qSearch);
              });
            },
            onSubmitted: (value){
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        qSearch==''?_showUsed():_showUsedSearchedData(),
      ],
    ),
  );

  _stock() => Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  contentPadding: const EdgeInsets.all(5.0),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  labelText: 'Search',
                  labelStyle: const TextStyle(
                    letterSpacing: 2.0,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Search Here',
                  hintStyle: const TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                controller: stockController,
                keyboardType: TextInputType.text,
                onChanged: (value){
                  setState(() {
                    qSearch=value;/*
                    stockController.addListener(() {
                      _newStockList=_getNewStockList(qSearch);});*/
                    _newStockList=_getNewStockList(qSearch);
                  });
                },
                onSubmitted: (value){
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            qSearch==''?_showStock():_showStockSearchedData(),
          ],
        ),
      );

  _showStockSearchedData()=>Expanded(
    child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          //columnSpacing: 60,
          dividerThickness: 5,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 1)),
          /*dataRowColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) => states.contains(MaterialState.selected)
                          ? Colors.blue
                          : Colors.grey),*/
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
          rows: _newStockList.map((e) => _createRow(e)).toList(),
        )),
  );

  _showFaultySearchedData()=>Expanded(
    child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          //columnSpacing: 60,
          dividerThickness: 5,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 1)),
          /*dataRowColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) => states.contains(MaterialState.selected)
                          ? Colors.blue
                          : Colors.grey),*/
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
          rows: _newFaultyList.map((e) => _createRow(e)).toList(),
        )),
  );

  _showDiscardSearchedData()=>Expanded(
    child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          //columnSpacing: 60,
          dividerThickness: 5,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 1)),
          /*dataRowColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) => states.contains(MaterialState.selected)
                          ? Colors.blue
                          : Colors.grey),*/
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
          rows: _newDiscardList.map((e) => _createRow(e)).toList(),
        )),
  );


  _showUsedSearchedData()=>Expanded(
    child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          //columnSpacing: 60,
          dividerThickness: 5,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 1)),
          /*dataRowColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) => states.contains(MaterialState.selected)
                          ? Colors.blue
                          : Colors.grey),*/
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
          rows: _newUsedList.map((e) => _createRow(e)).toList(),
        )),
  );
  //*****************************
  _showStock() => Expanded(
    child: FutureBuilder<List<ContainerModel>>(
      future: api.fetchStock(),
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


  //*****************************
  _showUsed() => Expanded(
    child: FutureBuilder<List<ContainerModel>>(
      future: api.fetchUsed(),
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


  //*****************************
  _showFaulty() => Expanded(
    child: FutureBuilder<List<ContainerModel>>(
      future: api.fetchFaulty(),
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


  //*****************************
  _showDiscard() => Expanded(
    child: FutureBuilder<List<ContainerModel>>(
      future: api.fetchDiscard(),
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


  _faulty() => Container(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white70,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: const EdgeInsets.all(5.0),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              labelText: 'Search',
              labelStyle: const TextStyle(
                letterSpacing: 2.0,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Search Here',
              hintStyle: const TextStyle(
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            controller: stockController,
            keyboardType: TextInputType.text,
            onChanged: (value){
              setState(() {
                qSearch=value;/*
                    stockController.addListener(() {
                      _newStockList=_getNewStockList(qSearch);});*/
                 _newFaultyList=_getNewFaultyList(qSearch);
              });
            },
            onSubmitted: (value){
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        qSearch==''?_showFaulty():_showFaultySearchedData(),
      ],
    ),
  );


  _refreshStockList() async {
    List<ContainerModel> x = await api.fetchStock();
    setState(() {
      _stockList = x;
    });
  }
  _refreshUsedList() async {
    List<ContainerModel> x = await api.fetchUsed();
    setState(() {
      _usedList = x;
    });
  }

  _refreshFaultyList() async {
    List<ContainerModel> x = await api.fetchFaulty();
    setState(() {
      _faultyList = x;
    });
  }

  _refreshDiscardList() async {
    List<ContainerModel> x = await api.fetchDiscard();
    setState(() {
      _discardList = x;
    });
  }

  _getLocationName(int lid){
    for(int i=0; i<_locationList.length; i++){
      if(_locationList[i].lId==lid){
        return _locationList[i].lName;
      }
    }
    return '';
  }

  List<ContainerModel> _getNewStockList(String data){
    List<ContainerModel> x=[];
    _newStockList=[];
    x=_stockList;
    for(int i=0; i<data.length; i++){
      for(int j=0; j<x.length; j++){
        if(data[i]!=_stockList[j].itemName[i]){
          x.remove(x[j]);
        }
      }
    }
    return x;
  }


  List<ContainerModel> _getNewUsedList(String data){
    List<ContainerModel> x=[];
    _newUsedList=[];
    x=_usedList;
    for(int i=0; i<data.length; i++){
      for(int j=0; j<x.length; j++){
        if(data[i]!=_usedList[j].itemName[i]){
          x.remove(x[j]);
        }
      }
    }
    return x;
  }

  List<ContainerModel> _getNewFaultyList(String data){
    List<ContainerModel> x=[];
    _newFaultyList=[];
    x=_faultyList;
    for(int i=0; i<data.length; i++){
      for(int j=0; j<x.length; j++){
        if(data[i]!=_faultyList[j].itemName[i]){
          x.remove(x[j]);
        }
      }
    }
    return x;
  }


  List<ContainerModel> _getNewDiscardList(String data){
    List<ContainerModel> x=[];
    _newDiscardList=[];
    x=_discardList;
    for(int i=0; i<data.length; i++){
      for(int j=0; j<x.length; j++){
        if(data[i]!=_discardList[j].itemName[i]){
          x.remove(x[j]);
        }
      }
    }
    return x;
  }

  _refreshLocationList() async {
    List<LocationModel> x = await api.fetchAllLocation();
    setState(() {
      _locationList = x;
    });
  }

}
