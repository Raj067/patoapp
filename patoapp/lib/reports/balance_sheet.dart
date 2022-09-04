import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/reports/accounting/profit_and_loss.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BalanceSheet extends StatefulWidget {
  const BalanceSheet({Key? key}) : super(key: key);

  @override
  State<BalanceSheet> createState() => _BalanceSheetState();
}

class _BalanceSheetState extends State<BalanceSheet> {
  DateTimeRange pickedRangeDate = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month),
    end: DateTime(DateTime.now().year, DateTime.now().month)
        .add(const Duration(days: 29)),
  );
  double inventoryInHandBalanceSheetVal = 0;
  ProfitAndLoss profitAndLoss = ProfitAndLoss(
    pickedRangeDate: DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    ),
  );
  fetchBusinessDB(){
    profitAndLoss =
        ProfitAndLoss(pickedRangeDate: pickedRangeDate);
    setState(() {});
  }

  inventoryInHandBalanceSheet() async {
    double val = 0;
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> products = await DBHelperProduct.query();
    for (Map<String, dynamic> e in products) {
      if (e['shopId'] == shopId) {
        val += fromJsonProduct(e).quantity * fromJsonProduct(e).purchasesPrice;
      }
    }
    inventoryInHandBalanceSheetVal = val;

    setState(() {});
  }

  @override
  void initState() {
    fetchBusinessDB();
    inventoryInHandBalanceSheet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.balanceSheet,
          style: const TextStyle(color: Colors.white),
        ),
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
      body: Column(
        children: [
          _searchBox(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                color: patowavePrimary.withAlpha(100),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Details"),
                    Text("Amount "),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: ListView(
                  children: _allFinancialData(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _searchBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          onTap: () async {
            // DateTimeRange? pickedDate = await showDateRangePicker(
            //   context: context,
            //   firstDate: DateTime(DateTime.now().year - 1),
            //   lastDate: DateTime(DateTime.now().year + 1),
            //   currentDate: DateTime.now(),
            //   confirmText: "SELECT",
            //   saveText: "SELECT",
            //   helpText: "Select Transaction Date Range",
            //   initialDateRange: pickedRangeDate,
            // );
            // if (pickedDate != null) {
            //   setState(() {
            //     pickedRangeDate = pickedDate;
            //     fetchBusinessDB();
            //   });
            // } else {}
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.search),
                Row(
                  children: [
                    Text(
                      DateFormat('EEE, d/M/y').format(pickedRangeDate.start),
                      style: const TextStyle(
                        fontSize: 14,
                        color: patowaveWarning,
                      ),
                    ),
                    const Text(
                      " to ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      DateFormat('EEE, d/M/y').format(pickedRangeDate.end),
                      style: const TextStyle(
                        fontSize: 14,
                        color: patowaveWarning,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/svg/calendar.svg",
                  height: 25,
                  width: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _allFinancialData() {
    List<Widget> data = [
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Assets',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: patowaveGreen,
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Current Assets',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Cash In-Hand',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.closingCashInHand())}",
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Inventory In-Hand',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(inventoryInHandBalanceSheetVal)}",
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Account Receivable',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.accountReceivable())}",
            )
          ],
        ),
      ),
      const Divider(height: 0, thickness: 1),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Total Asset',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.totalAssetBalanceSheet() + inventoryInHandBalanceSheetVal)}",
            )
          ],
        ),
      ),
      const Divider(height: 0, thickness: 1),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Liabilities',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: patowaveErrorRed,
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Current Liabilities',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Account Payable',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.accountPayable())}",
            )
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Equity',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Owner's Equity",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.totalAssetBalanceSheet() + inventoryInHandBalanceSheetVal - profitAndLoss.accountPayable())}",
            )
          ],
        ),
      ),
      const Divider(height: 0, thickness: 1),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Total Liabilities & Equity',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.totalAssetBalanceSheet() + inventoryInHandBalanceSheetVal)}",
            )
          ],
        ),
      ),
      const Divider(height: 0, thickness: 1),
      Container(height: 10),
    ];

    return data;
  }
}
