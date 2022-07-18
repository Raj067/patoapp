import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
const storage = FlutterSecureStorage();

String url = "http://localhost:8000";
String baseUrl = "$url/";
String imageBaseUrl = url;
var formatter = NumberFormat('#,###,###');

Map<String, String> getAuthHeaders(String accessToken) {
  Map<String, String> authHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    "Authorization": "Bearer $accessToken",
  };
  return authHeaders;
}

// Map<String, String> authHeaders = {
//   'Content-Type': 'application/json; charset=UTF-8',
//   "Authorization": "Bearer accessToken",
// };
