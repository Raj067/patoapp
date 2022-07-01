import 'package:flutter/material.dart';
import 'package:patoapp/reports/all_transactions.dart';
import 'package:patoapp/reports/balance_sheet.dart';
import 'package:patoapp/reports/cashflow.dart';
import 'package:patoapp/reports/day_book.dart';
import 'package:patoapp/reports/debt_reports.dart';
import 'package:patoapp/reports/expenses_reports.dart';
import 'package:patoapp/reports/inventory_reports.dart';
import 'package:patoapp/reports/inventory_summary.dart';
import 'package:patoapp/reports/profit_loss.dart';
import 'package:patoapp/reports/purchases_reports.dart';
import 'package:patoapp/reports/sales_reports.dart';
import 'package:patoapp/themes/light_theme.dart';

class MainReportsPage extends StatelessWidget {
  const MainReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports',
          style: TextStyle(color: Colors.white),
        ),
        // centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patowaveWhite,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Container(height: 10),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const ProfitLossReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Profit and Loss'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const DebtReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Debt Reports'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CashFlowReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Cashflow'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const BalanceSheet(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Balance sheet'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const DayBookReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Daybook'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const ExpensesReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Expenses Reports'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SalesReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Sales Reports'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const PurchasesReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Purchases Reports'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const InventoryReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Inventory Reports'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const InventorySummary(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Inventory Summary'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const AllTransactionsReports(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('All Transactions'),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
