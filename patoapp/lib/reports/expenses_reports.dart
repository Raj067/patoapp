import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpensesReports extends StatefulWidget {
  const ExpensesReports({Key? key}) : super(key: key);

  @override
  State<ExpensesReports> createState() => _ExpensesReportsState();
}

class _ExpensesReportsState extends State<ExpensesReports> {
  int totalAmount = 0;
  DateTimeRange pickedRangeDate = DateTimeRange(
    start: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 30,
    ),
    end: DateTime.now(),
  );
  List<FinancialData> allFinancialData = [];
  bool isLoading = true;
  fetchBusinessDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> business = await DBHelperBusiness.query();
    List<FinancialData> finalData = [];
    for (Map<String, dynamic> dx in business) {
      if (dx['shopId'] == shopId) {
        DateTime date = DateTime.parse(dx['date']);
        if (date.isAfter(pickedRangeDate.start) &&
            date.isBefore(pickedRangeDate.end) &&
            dx['isExpenses'] == 1) {
          finalData.add(fromJsonBusiness(dx));
        }
      }
    }
    finalData.sort((b, a) => a.date.compareTo(b.date));
    allFinancialData = finalData;
    isLoading = false;
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
          AppLocalizations.of(context)!.expensesReports,
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
                    Text("Transaction"),
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
                  children: _allFinancialData(context),
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
                    const Text("Total Amount"),
                    Text("Tsh ${formatter.format(totalAmount)}"),
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

  Widget _singleFinancialData(BuildContext context, FinancialData data) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.getDescriptionName(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data.getDescriptionDetails(),
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  DateFormat('EEE, d/M/y').format(data.date),
                  style: const TextStyle(fontSize: 12, color: patowaveWarning),
                ),
                // DateFormat('EEE, d/M/y').format(pickedDate)
              ],
            ),
          ),
          Container(width: 20),
          data.isIncome()
              ? Text(
                  "Tsh ${formatter.format(data.amount)}",
                  style: const TextStyle(
                    color: patowaveGreen,
                  ),
                )
              : Text(
                  "Tsh ${formatter.format(data.amount)}",
                  style: const TextStyle(
                    color: patowaveErrorRed,
                  ),
                ),
        ],
      ),
    );
  }

  List<Widget> _allFinancialData(BuildContext context) {
    List<Widget> data = [];
    int val = 0;
    for (var element in allFinancialData) {
      if (!element.isDeleted) {
        val += element.amount;
        data.add(_singleFinancialData(context, element));
        data.add(const Divider(height: 0));
      }
    }
    totalAmount = val;
    return data;
  }
}
