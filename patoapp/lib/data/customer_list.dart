import 'dart:math';

class SingleCustomer {
  String fullName = "";
  String email;
  int amount = 0;
  int id = 0;
  String phoneNumber;
  List financial_data;

  SingleCustomer({
    required this.fullName,
    this.email = "",
    required this.amount,
    required this.financial_data,
    required this.id,
    this.phoneNumber = "",
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
}

// allCustomerDetails() {
//   return [
//     SingleCustomer(
//       fullName: "Rajabu",
//       email: "Mrisho",
//       amount: 8977,
//       isToReceive: false,
//       phoneNumber: "255679190720",
//       id: 1,
//     ),
//     SingleCustomer(
//       fullName: "Salehe",
//       email: "Mrisho",
//       amount: 7800,
//       isToReceive: true,
//       phoneNumber: "255679190721",
//       id: 2,
//     ),
//   ];
// }
