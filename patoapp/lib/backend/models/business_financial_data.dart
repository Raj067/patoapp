import 'dart:convert';

import 'package:patoapp/backend/funcs/misc.dart';

class FinancialData {
  DateTime date;
  bool isCashSale = true;
  bool isExpenses = false;
  bool isPaymentIn = false;
  bool isPaymentOut = false;
  bool isInvoice = false;
  bool isPurchases = false;
  String name = "";
  String description = "";
  List details = [0, 0];
  int amount = 0;
  int discount = 0;
  String receipt = "";
  // For storing in the database
  String id;
  int shopId;
  // for frontend purposes only
  bool isDeleted = false;
  FinancialData({
    required this.date,
    required this.amount,
    required this.discount,
    required this.receipt,
    required this.details,
    required this.isCashSale,
    required this.id,
    required this.shopId,
    this.isExpenses = false,
    this.isPaymentIn = false,
    this.isPaymentOut = false,
    this.isInvoice = false,
    this.isPurchases = false,
    this.name = "",
    this.description = "",
  });

  String getDescriptionName() {
    if (name != "") {
      return name;
    } else {
      if (isCashSale) {
        return "Cash Sales";
      }
      if (isPaymentIn) {
        return "Payment In";
      }
      if (isExpenses) {
        return "Expenses";
      }
      if (isPaymentOut) {
        return "Payment Out";
      }
      if (isPurchases) {
        return "Purchases";
      }
      if (isInvoice) {
        return "Invoice";
      }
    }
    return "-";
  }

  String getDescriptionDetails() {
    if (description != "") {
      return description;
    } else {
      if (isCashSale) {
        return "Cash Sales";
      }
      if (isPaymentIn) {
        return "Payment In";
      }
      if (isExpenses) {
        return "Expenses";
      }
      if (isPaymentOut) {
        return "Payment Out";
      }
      if (isPurchases) {
        return "Purchases";
      }
      if (isInvoice) {
        return "Invoice";
      }
    }
    return "-";
  }

  getTransactionType() {
    if (isCashSale) {
      if (name == "Cash Sales") {
        return "cash_sale";
      }
      return "cash_sale_customer";
    }
    if (isPaymentIn || isPaymentOut) {
      return "payment";
    }
    if (isExpenses || isPurchases) {
      return "expenses";
    }
    return "";
  }

  List<int> getTransactionID() {
    List<int> data = [];
    for (var i in details) {
      data.add(i['id']);
    }
    return data;
  }

  bool isIncome() {
    if (isCashSale) {
      return true;
    }
    if (isPaymentIn) {
      return true;
    }
    if (isExpenses) {
      return false;
    }
    if (isPaymentOut) {
      return false;
    }
    if (isInvoice) {
      return true;
    }
    if (isPurchases) {
      return false;
    }
    return true;
  }

  getTimeString() {
    return "${date.day}/${date.month}/${date.year}";
  }

  deleteTransaction() {
    isDeleted = true;
    // SEND SOME RESPONSE TO THE BACKEND
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shopId': shopId,
      "date": date.toString(),
      'amount': amount,
      'discount': discount,
      'receipt': receipt,
      'name': name,
      'description': description,
      'details': jsonEncode(details),
      'isCashSale': boolToInt(isCashSale),
      'isExpenses': boolToInt(isExpenses),
      'isPaymentIn': boolToInt(isPaymentIn),
      'isPaymentOut': boolToInt(isPaymentOut),
      'isInvoice': boolToInt(isInvoice),
      'isPurchases': boolToInt(isPurchases),
    };
  }
}

FinancialData fromJsonBusiness(Map<String, dynamic> dx) {
  return FinancialData(
    date: DateTime.parse(dx['date']),
    isCashSale: intTobool(dx['isCashSale']),
    isPaymentIn: intTobool(dx['isPaymentIn']),
    isExpenses: intTobool(dx['isExpenses']),
    isPaymentOut: intTobool(dx['isPaymentOut']),
    isPurchases: intTobool(dx['isPurchases']),
    isInvoice: intTobool(dx['isInvoice']),
    name: dx['name'] ?? "",
    description: dx['description'] ?? "",
    details: jsonDecode(dx['details']),
    amount: dx['amount'],
    receipt: "${dx['receipt']}",
    discount: dx['discount'],
    id: "${dx['id']}",
    shopId: dx['shopId'],
  );
}
