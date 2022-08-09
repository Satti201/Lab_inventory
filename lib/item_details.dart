import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:lab_inventory/Api_Services/api_services.dart';
import 'package:lab_inventory/Models/container_model.dart';
import 'package:lab_inventory/Models/status_model.dart';


class ItemDetails extends StatefulWidget {
  final ContainerModel containerModel;
  final String lName;
  const ItemDetails(this.containerModel, this.lName, {Key? key})
      : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  ApiServices api = ApiServices();
  final _updateUserFormKey = GlobalKey<FormState>();

  String _updatedUserName = '';
  String _updatedUserEmail = '';
  late String initialUserName;
  late String initialUserEmail;
  List<StatusModel> _statusList=[];


  @override
  void initState() {
    super.initState();
    setState(() {
      _refreshStatusList();
    });
  }


  Future _refreshStatusList() async {
    List<StatusModel> statusList = await api.fetchStatus();
    _statusList = [];

    setState(() {
      for (var i = 0; i < statusList.length; i++) {
        _statusList.add(statusList[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.green[900],
        title: Text(widget.lName),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          //color: Colors.yellow,
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        toolbarOpacity: 0.8,
        elevation: 0,
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    color: Colors.grey[200],
                    child: Text(
                      widget.containerModel.itemName,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Ink(
                        child: IconButton(
                          onPressed: () {/*
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Do you want to suspend this user!',
                                    ),
                                    titleTextStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            String message =
                                            await api.deleteUser(widget
                                                .containerModel.userId
                                                .toString());
                                            _showToast(context, message);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Yes')),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No')),
                                    ],
                                  );
                                });
                         */ },
                          icon: const Icon(
                            Icons.delete,
                          ),
                          color: Colors.red,
                        ),
                        decoration: const ShapeDecoration(
                            color: Colors.cyanAccent, shape: CircleBorder()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Ink(
                        child: IconButton(
                          onPressed: () {/*
                            setState(() {
                              initialUserName = widget.containerModel.userName;
                              initialUserEmail = widget.containerModel.userEmail;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                *//*shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),*//*
                                elevation: 8,
                                child: Form(
                                  key: _updateUserFormKey,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Editing' + widget.rName,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            //color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(20.0),
                                            ),
                                            //border: InputBorder.none,
                                            contentPadding:
                                            const EdgeInsets.all(5.0),
                                            labelText: 'UserName',
                                            labelStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),

                                            hintText: widget.containerModel.userName,
                                            hintStyle: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter UserName!';
                                            } else if (value ==
                                                initialUserName) {
                                              return 'UserName is same as initial';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              _updatedUserName = value!;
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            //color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(20.0),
                                            ),
                                            //border: InputBorder.none,
                                            contentPadding:
                                            const EdgeInsets.all(5.0),
                                            labelText: 'UserEmail',
                                            labelStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),

                                            hintText:
                                            widget.containerModel.userEmail,
                                            hintStyle: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          keyboardType:
                                          TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter UserName!';
                                            } else if (value ==
                                                initialUserName) {
                                              return 'Email is same as initial';
                                            } else if (isEmail(value) ==
                                                false) {
                                              return 'Email format is not correct';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              _updatedUserEmail = value!;
                                            });
                                          },
                                        ),
                                        Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.spaceEvenly,
                                          spacing: 10.0,
                                          runSpacing: 20.0,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel')),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  if (_updateUserFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    _updateUserFormKey
                                                        .currentState!
                                                        .save();
                                                    containerModel useModel = containerModel(
                                                        userId: widget
                                                            .containerModel.userId,
                                                        roleId: widget
                                                            .containerModel.roleId,
                                                        userEmail:
                                                        _updatedUserEmail,
                                                        userName:
                                                        _updatedUserName,
                                                        userPassword: widget
                                                            .containerModel
                                                            .userPassword);

                                                    String message=await api.updateUser(useModel);
                                                    _showToast(context, message);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);

                                                  }
                                                },
                                                child: const Text('Update')),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          */},
                          icon: const Icon(
                            Icons.edit,
                          ),
                          color: Colors.blue,
                        ),
                        decoration: const ShapeDecoration(
                            color: Colors.cyanAccent, shape: CircleBorder()),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ID:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.containerModel.containerId.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Company Name:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.containerModel.company,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Processor Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.containerModel.processorName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Generation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.containerModel.generation,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Base Speed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.containerModel.baseSpeed.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.lName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _getStatusName(widget.containerModel.status.toString()),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.containerModel.totalAmount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Barcode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: BarcodeWidget(
                        barcode: Barcode.code128(),
                        data: widget.containerModel.barcode,
                        width: 100,
                        height: 100,
                        drawText: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  String _getStatusName(String id){
    for(int i=0; i<_statusList.length; i++){
      if(_statusList[i].statusId.toString()==id){
        return _statusList[i].statusType;
      }
    }
    return '';
  }


  bool isEmail(String string) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}
