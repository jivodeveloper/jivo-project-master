import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myproject/Dialogue/TransTypeCheck.dart';
import 'package:myproject/SapModel/Branches.dart';
import 'package:myproject/SapModel/PostSap.dart';
import 'package:myproject/SapModel/TransType.dart';
import 'package:myproject/utils/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'SapDashboard.dart';

const double _kPickerSheetHeight = 216.0;

class SapBackRight extends StatefulWidget {
  @override
  _SapBackRightState createState() => _SapBackRightState();
}

class _SapBackRightState extends State<SapBackRight> {
  DateTime selectedDate = DateTime.now();
  String _mySelection = "";
  List data = []; //edited line
  bool get hasFocus => false;

  bool editable = true;
  bool _validate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime todate = DateTime.now();
  DateTime date = DateTime.now();

  DateTime dateTime = DateTime.now();
  int id=0;
  String userId="";
  String transType="";
  String branch="";
  String createdBy="";
  String rights="";

  List<Branches> _getbranches = [];

  String selectedbranch="";

  final String branchdata =
      '[{"id":"-1","Name":"Select"},{"id":"Oil","Name":"Oil"},{"id":"Wheatgrass","Name":"Wheatgrass"}]';

  String selectedRights="";
  List<Map> _rightsData = [
    {"id": "-1", "Name": "Select"},
    {"id": "n'A'", "Name": "Add"},
    {"id": "n'U'", "Name": "Update"}
  ];

  final String sapUserUrl = Constant.ip_url + "Sap/getSAPUsers";

  static final createSapRightsUrl = Constant.ip_url + "Sap/createSapRights";
  bool loading = false;
  final String gettransTypeUrl =Constant.ip_url + 'Sap/getTransType';

  String selecteduserId="";
  int sapid = 0;
  List<TransType> transTypeList=[];

  Future<String> getSWData() async {
    var res = await http.get(Uri.parse(sapUserUrl),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
      loading =  false;
    });
    return "Success";
  }

  Future<List<TransType>> getTransTypeFunc() async {
    var response = await http.get(Uri.parse(gettransTypeUrl));
    print("${response.body}");
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      var tag = items.map<TransType>((json) => TransType.fromJson(json)).toList();
      print(tag);
      return items.map<TransType>((json) => TransType.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load internet');
    }
  }


  _displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return TranstypeCheck(
              transTypeList: this.transTypeList,
              onItemsSelected: (List<int> selectedIndexes) {},
              onDialogueCancelled:
                  (Map<String, List<int>> selectDeSelectMap) {});
        });
  }



  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      // color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.red,
          fontSize: 15.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildFromDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: date,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() => date = newDateTime);
                },
              ),
            );
          },
        );
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  'From Date',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  DateFormat.yMd().format(date),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            )
          ]),
    );
  }

  Widget _buildtoDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: todate,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() => todate = newDateTime);
                },
              ),
            );
          },
        );
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  'To Date',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  DateFormat.yMd().format(todate),
                  style: const TextStyle(
                      fontSize: 15.0,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            )
          ]
       ),
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: dateTime,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() => dateTime = newDateTime);
                },
              ),
            );
          },
        );
      },
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                'Till Date',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(2)),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                DateFormat.yMMMd().add_jm().format(dateTime),
                style: const TextStyle(
                    fontSize: 15.0,
                    //   fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
    setState(() {
      loading  = true;
    });
    this.getSWData();

  }


  @override
  Widget build(BuildContext context) {
    final jsondata = JsonDecoder().convert(branchdata);
    _getbranches = (jsondata).map<Branches>((item) => Branches.fromJson(item)).toList();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(
            'Back Date Permission',
            style: TextStyle(fontSize: 18.0),
          ),
        ),

        body: Padding(
            padding: const EdgeInsets.all(0),
            child: new ListView(padding: EdgeInsets.all(1), children: <Widget>[
              Form(
                key: _formKey,
                autovalidate: _validate,
                child: SingleChildScrollView(
                    child: Container(
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  'User Id',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(4),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  items: data.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValueSelected) {
                                    setState(() {
                                      _mySelection = newValueSelected!;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please Select User Id';
                                    }
                                    return null;
                                  },
                                  value: '_PSU_1',
                                  hint: Text(
                                    'Select User',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                          ]),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  'Voucher',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: RaisedButton(
                                  child: Text(
                                    'Select Voucher',
                                    style: TextStyle(
                                      //   fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  color: Colors.indigo[900],
                                  onPressed: () async {

                                    if (transTypeList.length == 0) {

                                      transTypeList = await getTransTypeFunc();
                                    }
                                    _displayDialog(context);
                                  },
                                ),
                              ),
                            ),
                          ]),
                      Divider(),
                      Row(children: <Widget>[
                        Flexible(
                          child: Container(
                              //padding: const EdgeInsets.all(8),
                              child: _buildFromDatePicker(context)),
                        ),
                      ]),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                  //  padding: const EdgeInsets.all(8),
                                  child: _buildtoDatePicker(context)),
                            ),
                          ]),
                      Divider(),
                      Row(children: <Widget>[
                        Flexible(
                          child: Container(
                              // padding: const EdgeInsets.all(8),
                              child: _buildDateAndTimePicker(context)),
                        ),
                      ]),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  'Rights',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: DropdownButtonHideUnderline(
                                    child: new DropdownButtonFormField<String>(
                                      items: _rightsData.map((Map map) {
                                        return new DropdownMenuItem<String>(
                                          value: map["id"].toString(),
                                          child: new Text(
                                            map["Name"],
                                          ),
                                        );
                                      }).toList(),
                                  hint: new Text(
                                    "Select Rights",
                                    style: TextStyle(
                                        //   fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                  validator: (String? value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please Select Rights';
                                    }
                                    return null;
                                  },
                                  value: "-1",
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedRights = newValue!;
                                    });

                                    print(selectedRights);
                                  },

                                )),
                              ),
                            )
                          ]),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  'Branch',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Divider(),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: DropdownButtonHideUnderline(
                                  child: new DropdownButtonFormField<String>(
                                    items: _getbranches.map((Branches map) {
                                      return new DropdownMenuItem<String>(
                                        value: map.name,
                                        child: new Text(
                                          map.name,
                                        ),
                                      );
                                    }).toList(),
                                    hint: new Text(
                                      "Select Branch",
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    value: "Select",
                                    onChanged: (String? newValue1) {
                                      setState(() {
                                        this.selectedbranch = newValue1!;
                                      });
                                      //  print(selectedRegion);
                                    },
                                    validator: (String? value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please Select branch';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            )
                          ]),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: new RaisedButton(
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 15,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  color: Colors.indigo[900],
                                  elevation: 4.0,
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    if (_formKey.currentState!.validate()) {
                                      id = int.parse(prefs.getString("id")!);

                                      List<String> selectedTransTypes =
                                          [];

                                      for (var i = 0;
                                          i < transTypeList.length;
                                          i++) {
                                        if (transTypeList[i].isSelected) {
                                          selectedTransTypes
                                              .add(transTypeList[i].id);
                                        }
                                      }

                                      PostSap newSapRightsPermission =
                                          new PostSap(
                                              sapid: 0,
                                              userId: _mySelection,
                                              transType: selectedTransTypes,
                                              fromDate: date.toString(),
                                              toDate: todate.toString(),
                                              timeLimit: dateTime.toString(),
                                              branch: selectedbranch,
                                              rights: selectedRights,
                                              createdBy: id.toString());

                                      debugPrint(id.toString());
                                      debugPrint(todate.toString());

                                      debugPrint(_mySelection);
                                      debugPrint(date.toString());
                                   //   debugPrint(selectedTransTypes);
                                      debugPrint(dateTime.toString());
                                      debugPrint(selectedbranch);
                                      debugPrint(selectedRights);

                                      var jsonData = newSapRightsPermission.toJson();

                                      createSapRightsfunc(jsonData);
                                    }
                                  }),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SapDashboard()),
                                  );
                                },
                                child: const Text(
                                  'Back',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                elevation: 4.0,
                                color: Colors.indigo[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider()
                    ]))),
              )
            ])));
  }



  Future<http.Response> createSapRightsfunc(
      Map<String, dynamic> postJsonData) async {
     // showToast("inside createSapRightsfunc");
     var body = json.encode(postJsonData);
     var response = await http.post(Uri.parse(createSapRightsUrl),
        headers: {"Content-Type": "application/json"}, body: body);
   //   print("Response:${response.body}");
     if (response.body.contains("Done")) {
    //   print("Done");
       Fluttertoast.showToast(
        msg: "Successfully Stored",
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,

        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.indigo,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SapDashboard()),
      );
    }else{

       print("else ");
     }

    return response;
  }
}
