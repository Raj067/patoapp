import 'dart:convert';

class SingleCustomer {
  String fullName = "";
  String email;
  String address;
  int amount = 0;
  int id;
  int shopId;
  String phoneNumber;
  List financialData;

  SingleCustomer({
    required this.fullName,
    required this.address,
    this.email = "",
    required this.amount,
    required this.financialData,
    required this.id,
    required this.shopId,
    required this.phoneNumber,
  });
  isToReceive() {
    if (amount >= 0) {
      return true;
    } else {
      return false;
    }
  }

  getAmount() {
    if (amount >= 0) {
      return amount;
    } else {
      return -amount;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shopId': shopId,
      'amount': amount,
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'financialData': jsonEncode(financialData),
    };
  }
}

SingleCustomer fromJsonCustomer(Map<String, dynamic> e) {
  return SingleCustomer(
    id: e['id'],
    shopId: e['shopId'],
    amount: e['amount'],
    fullName: e['fullName'],
    address: e['address'],
    phoneNumber: "${e['phoneNumber']}",
    email: e['email'],
    financialData: jsonDecode(e['financialData']),
  );
}
