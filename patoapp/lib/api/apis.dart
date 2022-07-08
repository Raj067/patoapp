import 'dart:convert';

import 'package:http/http.dart' as http;

Map d = {
  "access":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjYxMjM4NzU0LCJpYXQiOjE2NTY4Mzc4NjUsImp0aSI6ImMxZDNkOTc4MjMxNDRkYzE5ZGY3MzZjYzU2MDAyYTRiIiwidXNlcl9pZCI6MX0.zYVEki_oeBvDAFEUBdXQv-VeTKxuHzFzBkm-BShqwZY",
  "refresh":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NDY5NDc1NCwiaWF0IjoxNjU2OTE4NzU0LCJqdGkiOiJiNmExZTEzMTE2OTE0ZDBiOTdiNGIwM2YzODRiMGUyMiIsInVzZXJfaWQiOjF9.ybhW9rA_EVqOH7hawSuNazaFcONqqDP_Tgdbj4nuxK4"
};
String url = "http://localhost:8000";
String baseUrl = "$url/";
String imageBaseUrl = url;
String accessToken = d['access'];
const String refreshToken = "";

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
