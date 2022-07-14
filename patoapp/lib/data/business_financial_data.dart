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
  // for frontend purposes only
  bool isDeleted = false;
  FinancialData({
    required this.date,
    this.amount = 0,
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
    // if (getTransactionType() == "cash_sale") {}
    // if (getTransactionType() == "payment") {
    //   return details[0]['id'];
    // }
    // if (getTransactionType() == "expenses") {}
    List<int> data = [];
    for (var i in details) {
      data.add(i['id']);
    }
    return data;
  }

  // getTotalPrice() {
  //   return details[0];
  // }

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
}

class FinancialHeaderData {
  DateTime date;
  int income;
  int expenses;
  FinancialHeaderData({
    required this.date,
    required this.income,
    required this.expenses,
  });
  getTimeString() {
    return "${date.day}/${date.month}/${date.year}";
  }
}

// List<FinancialHeaderData> allFinancialHeaderData() {
//   return [
//     FinancialHeaderData(
//       date: DateTime(2022, 06, 24),
//       income: 20200,
//       expenses: 2300,
//     ),
//     FinancialHeaderData(
//       date: DateTime(2022, 06, 23),
//       income: 10300,
//       expenses: 3200,
//     ),
//     FinancialHeaderData(
//       date: DateTime(2022, 06, 22),
//       income: 33300,
//       expenses: 9800,
//     ),
//     FinancialHeaderData(
//       date: DateTime(2022, 06, 21),
//       income: 18500,
//       expenses: 1800,
//     ),
//     FinancialHeaderData(
//       date: DateTime(2022, 06, 20),
//       income: 10400,
//       expenses: 2300,
//     ),
//   ];
// }

// List<FinancialData> allFinancialData() {
//   return [
//     FinancialData(
//       date: DateTime(2022, 06, 20),
//       // id: 1,
//       isCashSale: true,
//       // [[qty, description, price],]
//       details: [
//         6000,
//         [
//           [12, "sample", 124],
//         ]
//       ],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 20),
//       // id: 2,
//       isCashSale: true,
//       details: [2000, 2],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 20),
//       name: "Anitha",
//       // id: 3,
//       isCashSale: true,
//       details: [2400, 28],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 20),
//       name: "Rashidi",
//       // id: 4,
//       isCashSale: false,
//       isInvoice: true,
//       details: [
//         6400,
//         SingleCustomer(
//             amount: 6400,
//             fullName: "Rashidi",
//             id: 90,
//             financialData: [],
//             address: "",
//             phoneNumber: "")
//       ],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 20),
//       description: "Breakfast",
//       // id: 5,
//       isCashSale: false,
//       isExpenses: true,
//       details: [800, 2],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 20),
//       description: "Lunch",
//       // id: 6,
//       isCashSale: false,
//       isExpenses: true,
//       details: [1500, 28],
//     ),
//     // 21 - 06 - 2022
//     FinancialData(
//       date: DateTime(2022, 06, 21),
//       // id: 7,
//       isCashSale: true,
//       details: [
//         2100,
//         [
//           [12, "sample", 124],
//         ]
//       ],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 21),
//       // id: 8,
//       isCashSale: true,
//       details: [5000, 28],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 21),
//       // id: 9,
//       isCashSale: true,
//       details: [9000, 28],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 21),
//       description: "Rashidi",
//       // id: 10,
//       isCashSale: false,
//       isPaymentIn: true,
//       details: [1500, 28],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 21),
//       description: "Breakfast",
//       // id: 11,
//       isCashSale: false,
//       isExpenses: true,
//       details: [800, 28],
//     ),
//     FinancialData(
//       date: DateTime(2022, 06, 21),
//       description: "Bus fair",
//       // id: 12,
//       isCashSale: false,
//       isExpenses: true,
//       details: [1000, 28],
//     ),
//   ];
// }

// List<Map> allBusinessFinancialData() {
//   List<Map> finaldata = [];
//   for (var element in allFinancialHeaderData()) {
//     List data = [];
//     for (var dx in allFinancialData()) {
//       if (element.getTimeString() == dx.getTimeString()) {
//         data.add(dx);
//       }
//     }
//     if (data.isNotEmpty) {
//       finaldata.add({
//         "header": element,
//         "data": data,
//       });
//     }
//   }
//   return finaldata;
// }

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
