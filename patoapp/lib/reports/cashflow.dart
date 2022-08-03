import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/reports/accounting/profit_and_loss.dart';
import 'package:patoapp/themes/light_theme.dart';

class CashFlowReports extends StatefulWidget {
  const CashFlowReports({Key? key}) : super(key: key);

  @override
  State<CashFlowReports> createState() => _CashFlowReportsState();
}

class _CashFlowReportsState extends State<CashFlowReports> {
  DateTimeRange pickedRangeDate = DateTimeRange(
    start: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 7,
    ),
    end: DateTime.now(),
  );
  ProfitAndLoss profitAndLoss = ProfitAndLoss(data: []);
  fetchBusinessDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> business = await DBHelperBusiness.query();
    List<FinancialData> finalData = [];
    for (Map<String, dynamic> dx in business) {
      if (dx['shopId'] == shopId && dx['isInvoice'] == 0) {
        DateTime date = DateTime.parse(dx['date']);
        if (date.isAfter(pickedRangeDate.start) &&
            date.isBefore(pickedRangeDate.end)) {
          finalData.add(fromJsonBusiness(dx));
        }
      }
    }
    finalData.sort((b, a) => a.date.compareTo(b.date));
    profitAndLoss = ProfitAndLoss(data: finalData);
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
        title: const Text(
          'Cashflow',
          style: TextStyle(color: Colors.white),
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
                // shape: const RoundedRectangleBorder(
                //   borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(15),
                //     bottomRight: Radius.circular(15),
                //   ),
                // ),
                child: ListView(
                  children: _allFinancialData(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Container(
              decoration: BoxDecoration(
                color: patowavePrimary.withAlpha(100),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Closing Cash In-Hand"),
                    Text(
                      "Tsh ${formatter.format(profitAndLoss.closingCashInHand())}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: patowaveGreen,
                      ),
                    ),
                  ],
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
                    'Opening Cash In-Hand',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.openingCashInHand())}",
              style: const TextStyle(
                color: patowaveGreen,
              ),
            )
          ],
        ),
      ),
      const Divider(height: 0, thickness: 1),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Money-In',
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
                    'Closing Inventory',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.closingInventory())}",
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
                    'Total Money-In',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(profitAndLoss.costGoodsSold())}",
              style: const TextStyle(color: patowaveGreen),
            )
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Money-Out',
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
                    'Cost of Goods Sold',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(10000)}",
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
                    'Total Money-Out',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            Text(
              "Tsh ${formatter.format(10000)}",
              style: const TextStyle(
                color: patowaveErrorRed,
              ),
            )
          ],
        ),
      ),
    ];

    return data;
  }
}
