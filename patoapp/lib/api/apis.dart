import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Map d = {
  "refresh":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTE1MTQ0NywiaWF0IjoxNjU3Mzc1NDQ3LCJqdGkiOiI5YTgyMDg3ZmM2YTM0YTlkYTIxOGE4OTNmOTM5OTIyNiIsInVzZXJfaWQiOjF9.PUAqkOFtu5w6Y_Dpz00tiyn_9Rlm9Xn4-xvi2ceyA88",
  "access":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjYxNjk1NDQ3LCJpYXQiOjE2NTczNzU0NDcsImp0aSI6IjZhZWJlZWQ2OTIwOTQxOGM4ZGY3NmE1OWE0M2ViZmFiIiwidXNlcl9pZCI6MX0.3FXaqg2VH689OK8uFkybT4oY68xd_wP5cGn3EkiCymw"
};
String url = "http://localhost:8000";
String baseUrl = "$url/";
String imageBaseUrl = url;
String accessToken = d['access'];
const String refreshToken = "";
var formatter = NumberFormat('#,###,###');

Map<String, String> authHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  "Authorization": "Bearer $accessToken",
};

loadingInventoryData(String path) async {
  var data = await http.get(
    Uri.parse(baseUrl + path),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $accessToken",
    },
  );
  // // For error and and codes redirect to login page
  // if (data.statusCode != 401) {
  //   return jsonDecode(data.body);
  // } else {}
  // print(data);
  // print(data.statusCode);

  return jsonDecode(data.body);
}
