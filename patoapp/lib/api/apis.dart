import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
const storage = FlutterSecureStorage();

String url = "http://localhost:8000";
// String url = "https://api.patowave.com";
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

// final List<String> primaryUnits = [
//   'BAGS (Bags)',
//   'BOTTLES (Btl)',
//   'BOX (Box)',
//   'BUNDLES (Bdl)',
//   'CANS (Can)',
//   'CARTONS (Ctn)',
//   'DOZENS (Dzn)',
//   'GRAMMES (gm)',
//   'KILOGRAMS (Kg)',
//   'LITRE (Ltr)',
//   'METERS (Mtr)',
//   'MILILITRE (Ml)',
//   'NUMBERS (Nos)',
//   'PACKS (Pac)',
//   'PAIRS (Prs)',
//   'PIECES (Pcs)',
// ];

final List<String> primaryUnits = [
  'Bags',
  'Bottles',
  'Box',
  'Bundles',
  'Cans',
  'Ctn',
  'Dzn',
  'gm',
  'Kg',
  'Litre',
  'Meter',
  'Mlliliter',
  'Numbers',
  'Packs',
  'Pairs',
  'Pcs',
  'Items',
];

final List<String> serviceUnit = [
  "Per Ride",
  "Per Work",
  "Per Session",
  "Per Minutes ",
  "Per Hours",
  "Per Day",
  "Per Week",
  "Per Month",
  "Per Day",
  "Per Night",
  "Per Unit",
];

List<String> expenses = [
  "Purchase",
  "Carriage Inward",
  "Royalties charge",
  "Sales Commission",
  "Unloading Charge",
  "Rent",
  "Food",
  "Breakfast",
  "Printing",
  "Repair and Maintenance",
  "Equipment",
  "Fuel",
  "Utilities",
  "Training",
  "Insurance",
  "Advertisement",
  "Payroll",
  "Commission",
  "Electricity",
  "Taxes",
  "License fee",
  "Packaging material",
  "Furniture and fitting",
  "Loans and advances",
  "Service fee",
  "Software subscription",
  "Transport",
  "Other direct expenses",
  "Other indirect expenses",
];
