import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'dart:collection';
import 'form.dart';

var baseURL = "health-8a33d-default-rtdb.asia-southeast1.firebasedatabase.app";

String? datestamp(String? date) {
  date = date!.replaceAll(" ", "");
  date = date.replaceAll("-", "");
  date = date.replaceAll(":", "");
  date = date.replaceAll(".", "");
  return date;
}

Future<String> fetchUserData(String? userId) async {
  var url = Uri.https(baseURL, '/users/' + userId! + ".json");
  var dResponse = await http.get(url);
  return dResponse.body.toString();
}

Future<void> submitUserData(
    String? userId, String? date, String? sys, String? dia) async {
  var url = Uri.https(baseURL, '/users/' + userId! + "/bpdata.json");
  String? key = datestamp(date);
  var body = json.encode({
    key: {
      "date": date.toString(),
      "sys": sys.toString(),
      "dia": dia.toString(),
    }
  });
  print(body);
  var dResponse = await http.patch(url, body: body);
  // return dResponse.st;
}

class UserData {
  final String userId;
  final String userName;
  Map<String, dynamic> asc;
  Map<String, dynamic> des;
  Entry latest;
  UserData(this.userId, this.userName, this.asc, this.des, this.latest);
}
// print(await http.read(Uri.https('example.com', 'foobar.txt')));
