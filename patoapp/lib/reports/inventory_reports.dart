import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/themes/light_theme.dart';

class InventoryReports extends StatefulWidget {
  const InventoryReports({Key? key}) : super(key: key);

  @override
  State<InventoryReports> createState() => _InventoryReportsState();
}

class _InventoryReportsState extends State<InventoryReports> {
  DateTimeRange pickedRangeDate = DateTimeRange(
    start: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 30,
    ),
    end: DateTime.now(),
  );
  List<Map> myData = [];
  double stockIn = 0;
  double stockOut = 0;
  fetchBusinessDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> business = await DBHelperBusiness.query();
    stockIn = 0;
    stockOut = 0;
    myData = [];
    for (Map<String, dynamic> dx in business) {
      if (dx['shopId'] == shopId && dx['isInvoice'] == 0) {
        DateTime date = DateTime.parse(dx['date']);
        if (date.isAfter(pickedRangeDate.start) &&
            date.isBefore(pickedRangeDate.end)) {
          findingAllData(fromJsonBusiness(dx));
        }
      }
    }
    setState(() {});
  }

  findingAllData(FinancialData data) {
    for (var dx in data.details) {
      if (dx['product'] != null) {
        data.isPurchases
            ? stockIn += dx['quantity']
            : stockOut += dx['quantity'];
        if (myData.map((e) => e['name']).toList().contains(dx['product'])) {
          data.isPurchases
              ? myData.firstWhere((element) =>
                  element['name'] == dx['product'])['stockIn'] += dx['quantity']
              : myData.firstWhere((element) =>
                      element['name'] == dx['product'])['stockOut'] +=
                  dx['quantity'];
        } else {
          myData.add({
            'name': dx['product'],
            'stockIn': data.isPurchases ? dx['quantity'] : 0,
            'stockOut': data.isCashSale || data.isInvoice ? dx['quantity'] : 0,
          });
        }
      }
    }
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
          'Inventory report',
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
                    Text("Name"),
                    Text("Stock-In"),
                    Text("Stock-Out"),
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
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Stock-In",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text("${stockIn.toInt()} items"),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Total Stock-Out",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text("${stockOut.toInt()} items"),
                      ],
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

  Widget _singleFinancialData(BuildContext context, Map data) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(data['name']),
          ),
          Expanded(
            child: Text(
              "${data['stockIn']}",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              child: Text(
            "${data['stockOut']}",
            textAlign: TextAlign.right,
          )),
        ],
      ),
    );
  }

  List<Widget> _allFinancialData(BuildContext context) {
    List<Widget> data = [];
    for (var element in myData) {
      data.add(_singleFinancialData(context, element));
      data.add(const Divider(height: 0));
    }
    return data;
  }
}
