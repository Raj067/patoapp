import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/reports/accounting/profit_and_loss.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfitLossReports extends StatefulWidget {
  const ProfitLossReports({Key? key}) : super(key: key);

  @override
  State<ProfitLossReports> createState() => _ProfitLossReportsState();
}

class _ProfitLossReportsState extends State<ProfitLossReports> {
  DateTimeRange pickedRangeDate = DateTimeRange(
    start: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 30,
    ),
    end: DateTime.now(),
  );
  ProfitAndLoss profitAndLoss = ProfitAndLoss(
    data: [],
    pickedRangeDate: DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    ),
  );
  fetchBusinessDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> business = await DBHelperBusiness.query();
    List<FinancialData> finalData = [];
    for (Map<String, dynamic> dx in business) {
      if (dx['shopId'] == shopId && dx['isInvoice'] == 0) {
        finalData.add(fromJsonBusiness(dx));
      }
    }
    finalData.sort((b, a) => a.date.compareTo(b.date));
    profitAndLoss =
        ProfitAndLoss(data: finalData, pickedRangeDate: pickedRangeDate);
    setState(() {});
  }

  @override
  void initState() {
    fetchBusinessDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profitAndLoss,
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
            DateTimeRange? pickedDate = await showDateRangePicker(
              context: context,
              firstDate: DateTime(DateTime.now().year - 1),
              lastDate: DateTime(DateTime.now().year + 1),
              currentDate: DateTime.now(),
              confirmText: "SELECT",
              saveText: "SELECT",
              helpText: "Select Transaction Date Range",
              initialDateRange: pickedRangeDate,
            );
            if (pickedDate != null) {
              setState(() {
                pickedRangeDate = pickedDate;
                fetchBusinessDB();
              });
            } else {}
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
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Sales Revenue',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.salesRevenue())}",
              style: const TextStyle(),
            )
          ],
        ),
      ),
      const Divider(height: 0, thickness: 1),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Cost of Goods Sold (COGS)',
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
                    'Starting Inventory',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.startingInventory())}",
              style: const TextStyle(color: patowaveErrorRed),
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
                    'Purchases',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.purchases())}",
              style: const TextStyle(color: patowaveErrorRed),
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
                    'Closing Inventory',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.closingInventory())}",
              style: const TextStyle(color: patowaveErrorRed),
            )
          ],
        ),
      ),
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
                    'Cost of Goods Sold',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.costGoodsSold())}",
              style: const TextStyle(color: patowaveErrorRed),
            )
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Direct Expenses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      profitAndLoss.allDirectExpensesData(),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Tax Payable',
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
                    'VAT',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(0)}",
              style: const TextStyle(color: patowaveErrorRed),
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
                    'Gross Profit',
                    style: TextStyle(fontSize: 14, color: patowaveGreen),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.grossProfit())}",
              style: const TextStyle(color: patowaveGreen),
            )
          ],
        ),
      ),
      const Divider(height: 0, thickness: 1),
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
                    'Other Income',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(0)}",
              style: const TextStyle(color: patowaveGreen),
            )
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Indirect Expenses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      profitAndLoss.allInDirectExpensesData(),
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
                    'Net Profit',
                    style: TextStyle(fontSize: 14, color: patowaveGreen),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.netProfit())}",
              style: const TextStyle(color: patowaveGreen),
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
