import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/backend/models/customer_list.dart';

class Accounting {
  List<SingleCustomer> customersList;
  List<FinancialData> businessList;
  DateTimeRange pickedRangeDate;
  int shopId;
  Accounting({
    required this.customersList,
    required this.businessList,
    required this.pickedRangeDate,
    required this.shopId,
  });

  double accountPayable() {
    double payable = 0;
    for (SingleCustomer customer in customersList) {
      if (customer.shopId == shopId) {
        if (!customer.isToReceive()) {
          payable += customer.amount * -1;
        }
      }
    }
    return payable;
  }

  double accountReceivable() {
    double receivable = 0;
    for (SingleCustomer customer in customersList) {
      if (customer.shopId == shopId) {
        if (customer.isToReceive()) {
          receivable += customer.amount;
        }
      }
    }
    return receivable;
  }

  double costGoodsSold() {
    double cogas = startingInventory() + purchases();
    return cogas - closingInventory();
  }

  double closingInventory() {
    double val = 0;
    for (FinancialData dx in businessList) {
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
    for (FinancialData dx in businessList) {
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

  double startingInventory() {
    // for temporaly

    return closingInventory() - purchases();
  }

  double salesRevenue() {
    double val1 = 0;
    for (FinancialData dx in businessList) {
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
    for (FinancialData dx in businessList) {
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
    for (FinancialData dx in businessList) {
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
    for (FinancialData dx in businessList) {
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
    for (FinancialData dx in businessList) {
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

  double totalMoneyIn() {
    double val = 0;
    for (FinancialData dx in businessList) {
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
    for (FinancialData dx in businessList) {
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

  double totalAssetBalanceSheet() {
    // pluss the inventory in hand
    return closingCashInHand();
  }
}
