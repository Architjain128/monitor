import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:montior/databaseRequests.dart';
import 'package:montior/scale.dart';
import "form.dart";
import 'listwrapper.dart';
import 'graph.dart';
import 'tile.dart';

final String appUserId = "0";

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archit App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyMainPage(),
    );
  }
}

class MyMainPage extends StatefulWidget {
  MyMainPage({Key? key}) : super(key: key);

  @override
  MyMainPageState createState() => MyMainPageState();
}

class MyMainPageState extends State<MyMainPage> {
  int couter = 0;
  void update() {
    setState(() {
      couter = couter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserData(appUserId),
      builder: (context, snapshot) {
        // print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.done) {
          var tmp = snapshot.data.toString();
          var decodedResponse = json.decode(tmp);

          var userName = decodedResponse["username"];
          var response = decodedResponse["bpdata"];

          Map<String, dynamic> temp = decodedResponse["bpdata"];
          temp.removeWhere((key, value) => key == "-1");

          Map<String, dynamic>? asc = Map.fromEntries(temp.entries.toList()
            ..sort((e1, e2) => e1.key.compareTo(e2.key)));
          Map<String, dynamic>? des = Map.fromEntries(temp.entries.toList()
            ..sort((e1, e2) => e2.key.compareTo(e1.key)));
          Entry entry;
          if (des.isEmpty) {
            entry = Entry("____-__-__ __:__", "__", "__");
          } else {
            var idx = des.keys.toList().first;
            entry = Entry(temp[idx]["date"].toString(),
                temp[idx]["sys"].toString(), temp[idx]["dia"].toString());
          }
          List<Entry> lis = [];
          for (final i in asc.values) {
            lis.add(Entry(dateparser(i["date"].toString()), i["sys"].toString(),
                i["dia"].toString()));
          }
          UserData _data = UserData(appUserId, userName, asc, des, lis, entry);
          return MyHomePage(data: _data, count: update);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserData data;
  Function count;
  MyHomePage({Key? key, required this.data, required this.count})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // UserData _data = widget.data;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text('Blood Pressure Monitor'),
              // Text(
              //   'Hello ${widget.data.userName}!',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(fontSize: 10),
              // ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Setting')));
              },
            ),
          ],
          bottom: TabBar(
            onTap: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.auto_graph),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MyCustomForm(data: widget.data, count: widget.count),
            MyChart(data: widget.data),
            MyListW(data: widget.data),
          ],
        ),
      ),
    );
  }
}
