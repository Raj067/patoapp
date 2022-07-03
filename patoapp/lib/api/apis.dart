import 'package:http/http.dart' as http;

Map d = {
  "access":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjU2ODQwODY1LCJpYXQiOjE2NTY4MjgxODMsImp0aSI6Ijk3MDRlOTc2MzNiNDRmNzU4YmI1NDk5MDY4Y2NlZGM3IiwidXNlcl9pZCI6MX0.4PFvO2D9AIDlVhmg2lwn1VLTlhC7Io6CaRfFvYuJAyE",
  "refresh":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NDYxMzg2NSwiaWF0IjoxNjU2ODM3ODY1LCJqdGkiOiI1MGEyOWI1Y2ZlYmM0ZThhYjY5ZGRlYzliNjg1Zjk4MSIsInVzZXJfaWQiOjF9.u-tvaFpWbcGqPbBObdc4NClVdX66CaDYwGosLiX8rOo"
};
const String baseUrl = "http://192.168.43.7:8000/";
String accessToken = d['access'];
const String refreshToken = "";

loadingInventoryData(String path) async {
  var data = await http.get(
    Uri.parse(baseUrl + path),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $accessToken",
    },
  );
  print(data.body);
  return data.body;
}
