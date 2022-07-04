import 'package:patoapp/data/customer_list.dart';

class FinancialData {
  String id;
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

  FinancialData({
    required this.date,
    required this.id,
    required this.details,
    required this.isCashSale,
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

  getTotalPrice() {
    return details[0];
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

  deleteTransaction() {}
}

class FinancialHeaderData {
  DateTime date;
  double income;
  double expenses;
  FinancialHeaderData({
    required this.date,
    required this.income,
    required this.expenses,
  });
  getTimeString() {
    return "${date.day}/${date.month}/${date.year}";
  }
}

List<FinancialHeaderData> allFinancialHeaderData() {
  return [
    FinancialHeaderData(
      date: DateTime(2022, 06, 24),
      income: 20200,
      expenses: 2300,
    ),
    FinancialHeaderData(
      date: DateTime(2022, 06, 23),
      income: 10300,
      expenses: 3200,
    ),
    FinancialHeaderData(
      date: DateTime(2022, 06, 22),
      income: 33300,
      expenses: 9800,
    ),
    FinancialHeaderData(
      date: DateTime(2022, 06, 21),
      income: 18500,
      expenses: 1800,
    ),
    FinancialHeaderData(
      date: DateTime(2022, 06, 20),
      income: 10400,
      expenses: 2300,
    ),
  ];
}

List<FinancialData> allFinancialData() {
  return [
    FinancialData(
      date: DateTime(2022, 06, 20),
      id: "1",
      isCashSale: true,
      // [[qty, description, price],]
      details: [
        6000,
        [
          [12, "sample", 124],
        ]
      ],
    ),
    FinancialData(
      date: DateTime(2022, 06, 20),
      id: "2",
      isCashSale: true,
      details: [2000, 2],
    ),
    FinancialData(
      date: DateTime(2022, 06, 20),
      name: "Anitha",
      id: "3",
      isCashSale: true,
      details: [2400, 28],
    ),
    FinancialData(
      date: DateTime(2022, 06, 20),
      name: "Rashidi",
      id: "4",
      isCashSale: false,
      isInvoice: true,
      details: [6400, SingleCustomer(amount: 6400, fullName: "Rashidi",id:90)],
    ),
    FinancialData(
      date: DateTime(2022, 06, 20),
      description: "Breakfast",
      id: "5",
      isCashSale: false,
      isExpenses: true,
      details: [800, 2],
    ),
    FinancialData(
      date: DateTime(2022, 06, 20),
      description: "Lunch",
      id: "6",
      isCashSale: false,
      isExpenses: true,
      details: [1500, 28],
    ),
    // 21 - 06 - 2022
    FinancialData(
      date: DateTime(2022, 06, 21),
      id: "7",
      isCashSale: true,
      details: [
        2100,
        [
          [12, "sample", 124],
        ]
      ],
    ),
    FinancialData(
      date: DateTime(2022, 06, 21),
      id: "8",
      isCashSale: true,
      details: [5000, 28],
    ),
    FinancialData(
      date: DateTime(2022, 06, 21),
      id: "9",
      isCashSale: true,
      details: [9000, 28],
    ),
    FinancialData(
      date: DateTime(2022, 06, 21),
      description: "Rashidi",
      id: "10",
      isCashSale: false,
      isPaymentIn: true,
      details: [1500, 28],
    ),
    FinancialData(
      date: DateTime(2022, 06, 21),
      description: "Breakfast",
      id: "11",
      isCashSale: false,
      isExpenses: true,
      details: [800, 28],
    ),
    FinancialData(
      date: DateTime(2022, 06, 21),
      description: "Bus fair",
      id: "12",
      isCashSale: false,
      isExpenses: true,
      details: [1000, 28],
    ),
  ];
}

List<Map> allBusinessFinancialData() {
  List<Map> finaldata = [];
  for (var element in allFinancialHeaderData()) {
    List data = [];
    for (var dx in allFinancialData()) {
      if (element.getTimeString() == dx.getTimeString()) {
        data.add(dx);
      }
    }
    if (data.isNotEmpty) {
      finaldata.add({
        "header": element,
        "data": data,
      });
    }
  }
  return finaldata;
}
// Activity 20/06/2022
// Cash Sale = 4 colgate = sh 6000
// Cash sale = 2 Doffi = sh 2000
// Anitha (cash sale) = 2kg sembe = sh 2400
// Rashidi (invoice) = 2 jamaa. 2 colgate = 6400
// Expenses = breakfast 800
// Expense = Lunch sh 1500
// Close day = Total sale 10,400 = total expenses 2300

// Activity 21/06/2022
// Cash Sale = 3 jamaa = sh 2100
// Cash sale = 2 omo = sh 5000
// cash sale = 3 Nido = sh 9000
// Rashidi (payment-in) = sh 2,400 = Balance due sh 4400
// Expenses = breakfast 800
// Bus fair = breakfast 1000
// Close day = Total sale 18,500 = total expenses 1800

// Activity 22/06/2022
// Cash Sale = 2 jamaa = sh 1400
// Cash sale = 6 omo = sh 15000
// Jumanne (cash sale) = 5 colgate = sh 12500
// Rashidi (payment-in) = sh 4400
// Expense = Purchase (OMO 4 bags) = sh 8000
// Expenses = breakfast 800
// Bus fair = breakfast 1000
// Day Book = Total sale 33,300 = total expenses 9800

// Activity 23/06/2022
// Cash Sale = 3 jamaa = sh 2100
// Cash Sale = 1 jamaa = sh 700
// Cash sale = 2 omo = sh 5000
// Jumanne (cash sale) = 1 omo = sh 2500
// Rashidi (Sale invoice) = 4kg sembe = sh 4800
// Expense = Purchase (jamaa 2 bars) = sh 900
// Expenses = breakfast 800
// expenses = lucnh 1500
// Close day = Total sale 10,300 = total expenses 3200

// Activity 24/06/2022
// Cash Sale = 3 colgate = sh 7500
// Cash Sale = 1 jamaa = sh 700
// Cash sale = 2 omo = sh 5000
// Vivian (cash sale) = 2 omo = sh 5000
// Rashidi (payment-in) = sh 2000 = balance due sh 2800
// Expenses = breakfast sh 800
// Lunch = breakfast sh 1500
// Close day = Total sale sh 20,200 = total expenses 2300

// Closing Balances Inventory as at 24/06/2022

class BusinessGeneral {
  String salesWeek;
  String expensesWeek;
  String profitWeek;
  String salesMonth;
  String expensesMonth;
  String profitMonth;

  BusinessGeneral({
    this.salesWeek = "43,000",
    this.expensesWeek = "12,000",
    this.profitWeek = "54,000",
    this.salesMonth = "9,000",
    this.expensesMonth = "78,900",
    this.profitMonth = '65000',
  });
}

BusinessGeneral businessGeneral = BusinessGeneral();
