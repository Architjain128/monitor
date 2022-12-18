import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'package:montior/form.dart';
import 'databaseRequests.dart';
import 'tile.dart';

class MyList extends StatefulWidget {
  final UserData data;
  const MyList({Key? key, required this.data}) : super(key: key);

  @override
  MyListState createState() => MyListState();
}

// Create a corresponding State class, which holds data related to the form.
class MyListState extends State<MyList> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  List<Widget> _generateList(UserData data) {
    List<Widget> tileList = [];
    for (final i in data.des.values) {
      tileList.add(new MyDataTile(
        data: Entry(
            i["date"].toString(), i["sys"].toString(), i["dia"].toString()),
        title: "",
      ));
    }
    print(tileList.length);
    if (tileList.length == 0) {
      tileList.add(Container(child: Text("No Entry yet")));
    }
    return tileList;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
        margin: const EdgeInsets.all(10),
        // padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        alignment: Alignment.center,
        child: widget.data.des.values.toList().length == 0
            ? Container(
                child: Text(
                "No entry yet!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ))
            : ListView.builder(
                itemCount: widget.data.des.values.toList().length,
                itemBuilder: (BuildContext context, int index) {
                  return MyDataTile(
                    title: "L",
                    data: Entry(
                      widget
                          .data
                          .des[widget.data.des.keys.toList()[index].toString()]
                              ["date"]
                          .toString(),
                      widget
                          .data
                          .des[widget.data.des.keys.toList()[index].toString()]
                              ["sys"]
                          .toString(),
                      widget
                          .data
                          .des[widget.data.des.keys.toList()[index].toString()]
                              ["dia"]
                          .toString(),
                    ),
                  );
                },
              ));
  }
}
