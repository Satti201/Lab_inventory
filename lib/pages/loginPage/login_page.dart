import 'package:flutter/material.dart';
import 'package:lab_inventory/widget/custom_app_bar.dart';
import 'package:lab_inventory/widget/custom_text_field.dart';

import '../../Api_Services/api_services.dart';
import '../../Models/role_model.dart';
import '../../Models/user_model.dart';
import '../../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApiServices api = ApiServices();
  final _loginFormKey = GlobalKey<FormState>();
  bool _showPassword = true;
  bool isLoading = false;
  String email = "";
  String password = "";
  bool listTileValue = false;
  final UserModel _userModel = UserModel(
      userId: 0, roleId: 0, userEmail: '', userName: '', userPassword: '');

  List<UserModel> _userList = [];
  List<RolesModel> _roleList = [];

  @override
  void initState() {
    setState(() {
      _refreshUserList();
      _refreshRoleTypeList();
    });
    super.initState();
  }

  Future _refreshUserList() async {
    List<UserModel> userList = await api.fetchUser();
    _userList = [];
    setState(() {
      for (var i = 0; i < userList.length; i++) {
        _userList.add(userList[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: Text("Log in")),
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Container(
            height: height,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: width * 0.60,
                  height: height * 0.30,
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      'assets/biitLogo.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                _emailTextField(),
                const SizedBox(
                  height: 20,
                ),
                _passwordTextField(),
                const SizedBox(
                  height: 10,
                ),
                SwitchListTile(
                  title: const Text(
                    'Remember me',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  value: listTileValue,
                  activeColor: Colors.deepPurple,
                  // Deep blue for the active thumb color
                  activeTrackColor: Colors.blueAccent,
                  // A lighter shade of blue for the active track
                  inactiveTrackColor: Colors.grey.shade300,
                  // Light grey for inactive track
                  inactiveThumbColor: Colors.grey.shade100,
                  onChanged: (bool value) {
                    setState(() {
                      listTileValue = value;
                    });
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                _loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Email form field
  _emailTextField() => CustomTextField(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        prefixIcon: const Icon(
          Icons.email_rounded,
          color: Colors.deepPurple,
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Your Email/UserName!';
          }
          return null;
        },
        onSaved: (value) {
          if (isEmail(value!) == true) {
            setState(() {
              _userModel.userEmail = value;
            });
          } else {
            setState(() {
              _userModel.userName = value;
            });
          }
        },
        labelText: 'Email/UserName',
        hintText: 'xyz@gmail.com',
      );

// Password form field
  _passwordTextField() => CustomTextField(
        obscureText: _showPassword,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        labelText: 'Password',
        hintText: 'Enter Your Password',
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.deepPurple,
        ),
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Your Password!';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            _userModel.userPassword = value!;
          });
        },
      );

  // Login Button
  _loginButton() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_loginFormKey.currentState!.validate()) {
              await _refreshUserList();
              _loginFormKey.currentState!.save();
              bool logged = _checkLogin();
              if (logged == true) {
                setState(() {
                  _refreshRoleTypeList();
                });
                setState(() => isLoading = true);
                await Future.delayed(const Duration(seconds: 3));
                if (listTileValue == false) {
                  _loginFormKey.currentState!.reset();
                }
                setState(() => isLoading = false);
                setState(() {
                  print('user List ' + _userList.length.toString());
                  print('Role List ' + _roleList.length.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage(_userList, _roleList, _userModel)));
                });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Please Enter correct Data!",
                        ),
                        titleTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _loginFormKey.currentState!.reset();
                              },
                              child: const Text('Back')),
                        ],
                      );
                    });
              }
            }
          },
          child: isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(width: 24),
                      Text('Please Wait'),
                    ])
              : const Text('LOG IN'),
          style: ElevatedButton.styleFrom(
            //primary: Colors.lightGreen[900],
            //onPrimary: Colors.yellow,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            shape: const StadiumBorder(),
          ),
        ),
      );

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

  //login
  bool _checkLogin() {
    for (int i = 0; i < _userList.length; i++) {
      if (_userList[i].userEmail == _userModel.userEmail &&
          _userList[i].userPassword == _userModel.userPassword) {
        setState(() {
          _userModel.userName = _userList[i].userName;
          _userModel.userId = _userList[i].userId;
          _userModel.roleId = _userList[i].roleId;
        });
        return true;
      } else if (_userList[i].userPassword == _userModel.userPassword &&
          _userList[i].userName == _userModel.userName) {
        setState(() {
          _userModel.userEmail = _userList[i].userEmail;
          _userModel.userId = _userList[i].userId;
          _userModel.roleId = _userList[i].roleId;
        });
        return true;
      }
    }
    return false;
  }

  _refreshRoleTypeList() async {
    List<RolesModel> x = await api.fetchRoles();
    setState(() {
      _roleList = x;
    });
  }
}
