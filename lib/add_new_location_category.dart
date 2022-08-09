import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_inventory/Models/location_categorie_model.dart';

import 'Api_Services/api_services.dart';
import 'logout_menu.dart';

class AddNewLocationCategory extends StatefulWidget {
  const AddNewLocationCategory({Key? key}) : super(key: key);

  @override
  _AddNewLocationCategoryState createState() => _AddNewLocationCategoryState();
}

class _AddNewLocationCategoryState extends State<AddNewLocationCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightGreen[800],
      appBar: AppBar(
        //backgroundColor: Colors.green[900],
        title: const Text('Add New Location Category'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 2.0,
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
      body: const LocationCategoryBody(),
    );
  }
}

class LocationCategoryBody extends StatefulWidget {
  const LocationCategoryBody({Key? key}) : super(key: key);

  @override
  _LocationCategoryBodyState createState() => _LocationCategoryBodyState();
}

class _LocationCategoryBodyState extends State<LocationCategoryBody> {
  final _addNewLocationCategoryKey = GlobalKey<FormState>();
  LocationCategoryModel lcModel=LocationCategoryModel(lcId: 0, lcName: '');
  final ApiServices api = ApiServices();

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      height: height,
      width: width,
      child: _programs(),
    );
  }

  // program form
  _programs() => Form(
    key: _addNewLocationCategoryKey,
    child: SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Location Category',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _locationCategoryTextFormField(),
              const SizedBox(
                height: 20,
              ),
              _saveLocCatButton(),
            ],
          ),
        ),
      ),
    ),
  );


  // Program form field
  _locationCategoryTextFormField() => TextFormField(
    style: const TextStyle(
      fontSize: 18,
      letterSpacing: 2.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: const EdgeInsets.all(5.0),
      labelText: 'Categeroy Name',
      labelStyle: const TextStyle(
        letterSpacing: 2.0,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      hintText: 'Enter Category Name',
      hintStyle: const TextStyle(
        letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    keyboardType: TextInputType.name,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
    ],
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Enter Category Name!';
      }
      return null;
    },
    onSaved: (value) {
      setState(() {
        lcModel.lcName = value!;
      });
    },
  );


  // save PLO Button
  _saveLocCatButton() => Container(
    alignment: Alignment.bottomRight,
    padding: const EdgeInsets.all(5.0),
    child: ElevatedButton(
      onPressed: () async {
        if (_addNewLocationCategoryKey.currentState!.validate()) {
          _addNewLocationCategoryKey.currentState!.save();
          String str=await api.insertLocationCategory(lcModel);
          _showToast(context, str);
          await Future.delayed(const Duration(seconds: 2));
          _addNewLocationCategoryKey.currentState!.reset();
          Navigator.pop(context);
        }
      },
      child: const Text('Save'),
      style: ElevatedButton.styleFrom(
        //primary: Colors.lightGreen[900],
        //onPrimary: Colors.yellow,
        textStyle: const TextStyle(
          letterSpacing: 2.0,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: const StadiumBorder(),
      ),
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
