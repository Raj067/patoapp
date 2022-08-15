import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/themes/light_theme.dart';

Future<Map> customerDataPrepared() async {
  // shop ID
  String? activeShop = await storage.read(key: 'activeShop');
  int shopId = int.parse(activeShop ?? '0');

  List<Map<String, dynamic>> customers = await DBHelperCustomer.query();
  List<SingleCustomer> finalData = [];
  double receivable = 0;
  double payable = 0;
  for (Map<String, dynamic> e in customers) {
    if (e['shopId'] == shopId) {
      if (fromJsonCustomer(e).isToReceive()) {
        receivable += fromJsonCustomer(e).amount;
      } else {
        payable += fromJsonCustomer(e).amount * -1;
      }

      finalData.add(fromJsonCustomer(e));
    }
  }
  return {'payable': payable, 'receivable': receivable};
}

class ProfitAndLoss {
  List<FinancialData> data;
  DateTimeRange pickedRangeDate;
  ProfitAndLoss({
    required this.data,
    required this.pickedRangeDate,
  });
  double startingInventory() {
    // for temporaly

    return closingInventory() - purchases();
  }

  double closingInventory() {
    double val = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isBefore(pickedRangeDate.end)) {
        if (dx.isPurchases) {
          val += dx.amount;
        }
      }
    }
    return val;
  }

  double purchases() {
    double val = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isPurchases) {
          val += dx.amount;
        }
      }
    }
    return val;
  }

  double costGoodsSold() {
    double cogas = startingInventory() + purchases();
    return cogas - closingInventory();
  }

  double salesRevenue() {
    double val1 = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isCashSale || dx.isInvoice) {
          val1 += dx.amount;
        }
      }
    }
    return val1;
  }

  double grossProfit() {
    return salesRevenue() - (costGoodsSold() + totalDirectExpenses());
  }

  double netProfit() {
    return grossProfit() - totalInDirectExpenses();
  }

  double openingCashInHand() {
    double val1 = 0;
    double val2 = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isBefore(pickedRangeDate.start)) {
        if (dx.isCashSale || dx.isPaymentIn || dx.isInvoice) {
          val1 += dx.amount;
        } else {
          val2 += dx.amount;
        }
      }
    }
    return val1 - val2;
  }

  double closingCashInHand() {
    double val1 = 0;
    double val2 = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isBefore(pickedRangeDate.end)) {
        if (dx.isCashSale || dx.isPaymentIn || dx.isInvoice) {
          val1 += dx.amount;
        } else {
          val2 += dx.amount;
        }
      }
    }
    return val1 - val2;
  }

  double totalDirectExpenses() {
    double val = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isExpenses &&
            directExpenses.contains(dx.getDescriptionName().toLowerCase())) {
          val += dx.amount;
        }
      }
    }
    return val;
  }

  double totalInDirectExpenses() {
    double val = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isExpenses &&
            !directExpenses.contains(dx.getDescriptionName().toLowerCase())) {
          val += dx.amount;
        }
      }
    }
    return val;
  }

  Widget allDirectExpensesData() {
    List<Widget> myData = [];
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isExpenses &&
            directExpenses.contains(dx.getDescriptionName().toLowerCase())) {
          myData.add(Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dx.getDescriptionName(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(width: 20),
                Text(
                  "Tsh ${formatter.format(dx.amount)}",
                  style: const TextStyle(color: patowaveErrorRed),
                )
              ],
            ),
          ));
        }
      }
    }
    return Column(children: myData);
  }

  Widget allInDirectExpensesData() {
    List<Widget> myData = [];
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isExpenses &&
            !directExpenses.contains(dx.getDescriptionName().toLowerCase())) {
          myData.add(Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dx.getDescriptionName(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(width: 20),
                Text(
                  "Tsh ${formatter.format(dx.amount)}",
                  style: const TextStyle(color: patowaveErrorRed),
                )
              ],
            ),
          ));
        }
      }
    }
    return Column(children: myData);
  }

  double totalMoneyIn() {
    double val = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isCashSale || dx.isPaymentIn || dx.isInvoice) {
          val += dx.amount;
        }
      }
    }
    return val;
  }

  double totalMoneyOut() {
    double val = 0;
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isExpenses || dx.isPaymentOut || dx.isPurchases) {
          val += dx.amount;
        }
      }
    }
    return val;
  }

  // double accountReceivableBalanceSheet() {
  //   Map data = customerDataPrepared() as Map;
  //   double val = data['receivable'];
  //   return val;
  // }

  // double accountPayableBalanceSheet() {
  //   Future<Map> data = customerDataPrepared();
  //   double val = data['payable'];
  //   return val;
  // }

  double totalAssetBalanceSheet() {
    // pluss the inventory in hand
    return closingCashInHand();
  }

  Widget allMoneyIn() {
    List<Widget> myData = [];
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isCashSale || dx.isPaymentIn || dx.isInvoice) {
          myData.add(Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dx.getDescriptionName(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(width: 20),
                Text(
                  "Tsh ${formatter.format(dx.amount)}",
                  style: const TextStyle(color: patowaveGreen),
                )
              ],
            ),
          ));
        }
      }
    }
    return Column(children: myData);
  }

  Widget allMoneyOut() {
    List<Widget> myData = [];
    for (FinancialData dx in data) {
      DateTime date = dx.date;
      if (date.isAfter(pickedRangeDate.start) &&
          date.isBefore(pickedRangeDate.end)) {
        if (dx.isExpenses || dx.isPaymentOut || dx.isPurchases) {
          myData.add(Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dx.getDescriptionName(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(width: 20),
                Text(
                  "Tsh ${formatter.format(dx.amount)}",
                  style: const TextStyle(color: patowaveErrorRed),
                )
              ],
            ),
          ));
        }
      }
    }
    return Column(children: myData);
  }
}
