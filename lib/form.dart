import 'dart:io';
import 'package:flutter_html/flutter_html.dart';

import "scale.dart";
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'tile.dart';
import 'databaseRequests.dart';

class MyCustomForm extends StatefulWidget {
  final UserData data;
  Function count;
  MyCustomForm({Key? key, required this.data, required this.count})
      : super(key: key);

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  String? _sys = "100";
  String? _dia = "80";
  String? _date = DateTime.now().toString();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
        child: Column(children: [
      // Container(
      //     child: Text(
      //   "Hello ${widget.data.userName}!",
      //   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
      // )),
      MyScale(),
      MyDataTile(title: "Latest", data: widget.data.latest),
      Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'SYS ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                        ),
                      )),
                  hintText: '100',
                  labelText: 'Systolic ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _sys = value;
                },
              ),
              TextFormField(
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2),
                decoration: const InputDecoration(
                  // icon: Icon(Icons.phone),
                  prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'DIA ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                        ),
                      )),
                  hintText: '80',
                  labelText: 'Diastolic',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _dia = value;
                },
              ),
              DateTimePicker(
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2),
                  type: DateTimePickerType.dateTime,
                  initialValue: _date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date and Time',
                  // onChanged: (val) => print(val),
                  validator: (val) {
                    // print(val);
                    return null;
                  },
                  onChanged: (val) {
                    _date = val;
                  }),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                margin: const EdgeInsets.all(4),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a Snackbar.
                      submitUserData(widget.data.userId, _date, _sys, _dia)
                          .whenComplete(() {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("Added")));
                        widget.count();
                      });
                      // print(jsonEncode(newEntry));

                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}

class Entry {
  String? date;
  String? sys;
  String? dia;
  Entry(this.date, this.sys, this.dia);
  Map toJson() => {
        'date': date,
        'sys': sys,
        'dia': dia,
      };
}
