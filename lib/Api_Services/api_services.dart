
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:lab_inventory/Models/container_model.dart';
import 'package:lab_inventory/Models/demand_model.dart';
import 'package:lab_inventory/Models/location_categorie_model.dart';
import 'package:lab_inventory/Models/location_model.dart';
import 'package:lab_inventory/Models/role_model.dart';
import 'package:lab_inventory/Models/status_model.dart';
import 'package:lab_inventory/Models/user_model.dart';


import 'ip_address.dart';

class ApiServices {
  final IpAddress _ip = IpAddress();


  //********************Status


//fetch Status
  Future<List<StatusModel>> fetchStatus() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Status/AllStatus'));

    //print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => StatusModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Stock');
    }
  }



  //********************Container


//fetch Stock
  Future<List<ContainerModel>> fetchLocationItems(String locId) async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Containers/AllContainers?lId=$locId'));

    //print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => ContainerModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Stock');
    }
  }


//fetch Stock
  Future<List<ContainerModel>> fetchStock() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Containers/AllContainerStock'));

    //print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => ContainerModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Stock');
    }
  }


//fetch Used
  Future<List<ContainerModel>> fetchUsed() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Containers/AllContainerUsed'));

    //print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => ContainerModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Used');
    }
  }


//fetch Faulty
  Future<List<ContainerModel>> fetchFaulty() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Containers/AllContainerFaulty'));

    //print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => ContainerModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Faulty');
    }
  }


//fetch Discard
  Future<List<ContainerModel>> fetchDiscard() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Containers/AllContainerDiscard'));

    //print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => ContainerModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Discard');
    }
  }



  //******************User


//fetch Users
  Future<List<UserModel>> fetchUser() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Users/AllUsers'));

    //print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => UserModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load User');
    }
  }


  //insert User
  Future<String> insertUser(UserModel userModel) async {
    String iP=_ip.ipAddress;
    Response response = await post(
        Uri.parse(
            'http://$iP/lab_inventory_system/api/Users/AddUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(userModel.toUserMap()));

    print(response);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      String message=jsonDecode(response.body);
      return message;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to insert User.');
    }
  }

  Future<String> deleteUser(String userId) async {
    String iP=_ip.ipAddress;
    final http.Response response = await http.get(
      Uri.parse(
          'http://$iP/lab_inventory_system/api/Users/DeleteUser?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      String message=jsonDecode(response.body);
      return message;
      //return ProgramModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete User.');
    }
  }


  //update User
  Future<String> updateUser(UserModel userModel) async {
    String iP=_ip.ipAddress;
    Response response = await post(
        Uri.parse(
            'http://$iP/lab_inventory_system/api/Users/UpdateUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(userModel.toUserMap()));
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      String message=jsonDecode(response.body);
      return message;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update User.');
    }
  }



  //***********************Role**************
  //fetch Roles
  Future<List<RolesModel>> fetchRoles() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Roles/AllRoles'));

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => RolesModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Roles');
    }
  }


  //insert Location Category
  Future<String> insertLocationCategory(LocationCategoryModel lcModel) async {
    String iP = _ip.ipAddress;
    Response response = await post(
        Uri.parse(
            'http://$iP/lab_inventory_system/api/LocationCategories/AddLocationCategories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(lcModel.toLocationCategoryMap()));

    print(response);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      String message = jsonDecode(response.body);
      return message;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Location Category.');
    }
  }


  //fetch Location Category
  Future<List<LocationCategoryModel>> fetchLocationCategory() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/LocationCategories/AllLocationCategories'));

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => LocationCategoryModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Location Category');
    }
  }


  //delete program
  Future<String> deleteLocationCategory(String id) async {
    String iP = _ip.ipAddress;
    final Response response = await get(
      Uri.parse(
          'http://$iP/lab_inventory_system/api/LocationCategories/DeleteLocationCategories?lc_id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      String message=jsonDecode(response.body);
      return message;
      //return ProgramModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete Category.');
    }
  }

  //***********************************Location


  //fetch Location
  Future<List<LocationModel>> fetchAllLocation() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Locations/getAllLocation'));

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => LocationModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Location Category');
    }
  }


  //fetch Location
  Future<List<LocationModel>> fetchLocation(String lcId) async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Locations/AllLocation?locCategoryId=$lcId'));

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => LocationModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Location Category');
    }
  }

  //*********************Demand

  //fetch programs
  Future<List<DemandModel>> fetchDemand() async {
    String iP=_ip.ipAddress;
    Response response = await get(Uri.parse(
        'http://$iP/lab_inventory_system/api/Demands/AllDemand'));

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => DemandModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Demand');
    }
  }

}