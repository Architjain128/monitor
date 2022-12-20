import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'package:montior/form.dart';

Color findColor(String? a, String? b) {
  if (a == "__") return Colors.black12;
  int tmp = int.parse(a!);
  if (b == "sys") {
    if (tmp < 90) {
      return Color.fromRGBO(52, 192, 235, 0.2);
    } else if (tmp < 120) {
      return Color.fromRGBO(44, 153, 37, 0.2);
    } else if (tmp < 140) {
      return Color.fromRGBO(250, 137, 7, 0.2);
    } else {
      return Color.fromRGBO(255, 0, 0, 0.2);
    }
    return Colors.black12;
  }
  if (b == "dia") {
    if (tmp < 60) {
      return Color.fromRGBO(52, 192, 235, 0.2);
    } else if (tmp < 80) {
      return Color.fromRGBO(44, 153, 37, 0.2);
    } else if (tmp < 90) {
      return Color.fromRGBO(250, 137, 7, 0.2);
    } else {
      return Color.fromRGBO(255, 0, 0, 0.2);
    }
    return Colors.black12;
  }
  return Colors.black;
}

String? dateparser(String? date) {
  String? newDate;
  List<String> tmp = date!.split(" ");
  List<String> tmp2 = tmp[0].split("-");
  List<String> tmp3 = tmp[1].split(".")[0].split(":");
  newDate =
      tmp2[2] + '-' + tmp2[1] + "-" + tmp2[0] + " " + tmp3[0] + ":" + tmp3[1];

  return newDate;
}

class MyDataTile extends StatefulWidget {
  final String title;
  final Entry data;
  const MyDataTile({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  MyDataTileState createState() => MyDataTileState();
}

// Create a corresponding State class, which holds data related to the form.
class MyDataTileState extends State<MyDataTile> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      // margin: const EdgeInsets.all(10),
      margin: widget.title == "Lastest"
          ? EdgeInsets.all(10)
          : EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 20),
      // padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      alignment: Alignment.center,
      child: Column(children: [
        Row(children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              // color: widget.title != "Latest"
              //     ? findColor(widget.data.sys!, "sys")
              //     : null,
              color: findColor(widget.data.sys!, "sys"),
              child: Column(children: [
                Text("SYS"),
                Text(
                  widget.data.sys!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ]),
            ),
          ),
          VerticalDivider(
              width: 2,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Colors.white),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              // color: widget.title != "Latest"
              //     ? findColor(widget.data.dia!, "dia")
              //     : null,
              color: findColor(widget.data.dia!, "dia"),

              child: Column(children: [
                Text("DIA"),
                Text(
                  widget.data.dia!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ]),
            ),
          ),
          VerticalDivider(
            width: 2,
            thickness: 1,
            indent: 20,
            endIndent: 0,
            color: Colors.white,
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              // color: findColor(widget.data.sys!, "sys"),
              child: Column(children: [
                Text(widget.title == "Latest" ? "LAST READING" : "DATE"),
                Text(
                  dateparser(widget.data.date!)!,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ]),
            ),
          ),
        ]),
      ]),
      decoration: BoxDecoration(
        color: Colors.white,
        border: widget.title != "Latest"
            ? Border.all(
                color: Colors.black,
                width: 2.0,
              )
            : Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
        borderRadius: BorderRadius.circular(10.0),
        // gradient: LinearGradient(
        // begin: Alignment.topCenter, colors: [Colors.white, Colors.white30]),
        boxShadow: [
          BoxShadow(
              color: Colors.grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
        ],
      ),
    );
  }
}
