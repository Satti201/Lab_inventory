import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lab_inventory/Api_Services/api_services.dart';
import 'package:lab_inventory/Models/role_model.dart';
import 'package:lab_inventory/Models/user_model.dart';
import 'package:lab_inventory/widget/custom_app_bar.dart';
import 'package:lab_inventory/widget/custom_text_field.dart';

class AddNewUser extends StatefulWidget {
  final List<RolesModel> _roleList;

  const AddNewUser(this._roleList, {Key? key}) : super(key: key);

  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: Text('Add New User')),
      body: Material(color: Colors.white, child: UserBody(widget._roleList)),
    );
  }
}

class UserBody extends StatefulWidget {
  final List<RolesModel> _roleList;

  const UserBody(this._roleList, {Key? key}) : super(key: key);

  @override
  _UserBodyState createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  final _addNewUsersKey = GlobalKey<FormState>();
  UserModel userModel = UserModel(
      userId: 0, roleId: 0, userEmail: '', userName: '', userPassword: '');
  final ApiServices api = ApiServices();
  RolesModel? value;
  List<RolesModel> items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      items = widget._roleList.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      height: height,
      width: width,
      child: _users(),
    );
  }

  // program form
  _users() => Form(
        key: _addNewUsersKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _userName(),
              const SizedBox(
                height: 10,
              ),
              _emailTextField(),
              const SizedBox(
                height: 10,
              ),
              _passwordTextField(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Select Role',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildDropDown(),
              const SizedBox(
                height: 20,
              ),
              _saveUserButton(),
            ],
          ),
        ),
      );

  // User Name field
  _userName() => CustomTextField(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        hintText: 'Enter User Name',
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter User Name!';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            userModel.userName = value!;
          });
        },
        labelText: 'User Name',
      );

  //Email
  _emailTextField() => CustomTextField(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        prefixIcon: const Icon(
          Icons.email_rounded,
          color: Colors.black,
        ),
        labelText: 'Email',
        hintText: 'Enter Your Email',
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Your Email!';
          } else if (isEmail(value) == false) {
            return 'Please Enter correct Format @something.com!';
          }

          return null;
        },
        onSaved: (value) {
          setState(() {
            userModel.userEmail = value!;
          });
        },
      );

  _passwordTextField() => CustomTextField(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.black,
        ),
        labelText: 'Password',
        hintText: 'Enter Your Password',
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Your Password!';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            userModel.userPassword = value!;
          });
        },
      );

  // save PLO Button
  _saveUserButton() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_addNewUsersKey.currentState!.validate()) {
              if (value == null) {
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Please Select Role!',
                        ),
                        titleTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok')),
                        ],
                      );
                    });
              } else {
                userModel.roleId = value!.roleId;
              }
              _addNewUsersKey.currentState!.save();
              print('user Name: ' + userModel.userName);
              print('user Email: ' + userModel.userEmail);
              print('user Password: ' + userModel.userPassword);
              print('user Role id: ' + userModel.roleId.toString());
              print('user id: ' + userModel.userId.toString());
              String message = await api.insertUser(userModel);
              _showToast(context, message);
              _addNewUsersKey.currentState!.reset();
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: SnackBarAction(
            label: 'Hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  /// Check if a String is a valid email.
  /// Return true if it is valid.
  bool isEmail(String string) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  buildDropDown() => Container(
        width: Get.width,
        decoration: BoxDecoration(
          //color: Colors.lightGreen[900],
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<RolesModel>(
            hint: const Text('none'),
            dropdownColor: CupertinoColors.lightBackgroundGray,
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items
                .map(
                  (RolesModel item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item.roleType,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() {
              this.value = value;
            }),
          ),
        ),
      );
}
