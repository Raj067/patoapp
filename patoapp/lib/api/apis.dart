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

final List<String> primaryUnits = [
  'BAGS (Bags)',
  'BOTTLES (Btl)',
  'BOX (Box)',
  'BUNDLES (Bdl)',
  'CANS (Can)',
  'CARTONS (Ctn)',
  'DOZENS (Dzn)',
  'GRAMMES (gm)',
  'KILOGRAMS (Kg)',
  'LITRE (Ltr)',
  'METERS (Mtr)',
  'MILILITRE (Ml)',
  'NUMBERS (Nos)',
  'PACKS (Pac)',
  'PAIRS (Prs)',
  'PIECES (Pcs)',
];
