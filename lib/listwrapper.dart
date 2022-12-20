import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'package:montior/form.dart';
import 'package:montior/scale.dart';
import 'databaseRequests.dart';
import 'tile.dart';
import 'scale.dart';
import 'list.dart';

class MyListW extends StatefulWidget {
  final UserData data;
  const MyListW({Key? key, required this.data}) : super(key: key);

  @override
  MyListWState createState() => MyListWState();
}

// Create a corresponding State class, which holds data related to the form.
class MyListWState extends State<MyListW> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      children: [
        Expanded(flex: 0, child: MyScale()),
        Expanded(child: MyList(data: widget.data)),
      ],
    );
  }
}
