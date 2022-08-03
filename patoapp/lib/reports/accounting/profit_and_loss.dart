import 'package:patoapp/backend/models/business_financial_data.dart';

class ProfitAndLoss {
  List<FinancialData> data;
  ProfitAndLoss({required this.data});
  double startingInventory() {
    return 0;
  }

  double closingInventory() {
    return 0;
  }

  double purchases() {
    return 0;
  }

  double costGoodsSold() {
    return 0;
  }

  double salesRevenue() {
    return 0;
  }

  double grossProfit() {
    return 0;
  }

  double netProfit() {
    return 0;
  }
    double openingCashInHand() {
    return 0;
  }
      double closingCashInHand() {
    return 0;
  }
}
