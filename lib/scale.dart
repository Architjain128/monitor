import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'package:montior/form.dart';
import 'databaseRequests.dart';
import 'tile.dart';

// Create a corresponding State class, which holds data related to the form.
class MyScale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(3),
                color: Color.fromRGBO(52, 192, 235, 0.8),
                child: Text("Low",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(3),
                color: Color.fromRGBO(44, 153, 37, 0.8),
                child: Text("Normal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(3),
                color: Color.fromRGBO(250, 137, 7, 0.8),
                child: Text("Pre-High",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(3),
                color: Color.fromRGBO(255, 0, 0, 0.8),
                child: Text("High",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ],
        ));
  }
}
