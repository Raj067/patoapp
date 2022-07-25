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
      return "cash_sale";
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
      return false;
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

class BusinessGeneral {
  int salesWeek;
  int expensesWeek;
  int profitWeek;
  int salesMonth;
  int expensesMonth;
  int profitMonth;

  BusinessGeneral({
    required this.salesWeek,
    required this.expensesWeek,
    required this.profitWeek,
    required this.salesMonth,
    required this.expensesMonth,
    required this.profitMonth,
  });
}
