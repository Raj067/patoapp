import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DayBookReports extends StatefulWidget {
  const DayBookReports({Key? key}) : super(key: key);

  @override
  State<DayBookReports> createState() => _DayBookReportsState();
}

class _DayBookReportsState extends State<DayBookReports> {
  DateTime selectedDate = DateTime.now();

  List<FinancialData> allFinancialData = [];
  bool isLoading = true;
  fetchBusinessDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> business = await DBHelperBusiness.query();
    List<FinancialData> finalData = [];
    for (Map<String, dynamic> dx in business) {
      if (dx['shopId'] == shopId && dx['isInvoice'] == 0) {
        DateTime date = DateTime.parse(dx['date']);
        DateTime d1 = DateTime(
          date.year,
          date.month,
          date.day,
        );
        DateTime d2 = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        );

        if (d1 == d2) {
          finalData.add(fromJsonBusiness(dx));
        }
      }
    }
    finalData.sort((b, a) => a.date.compareTo(b.date));
    allFinancialData = finalData;
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
          AppLocalizations.of(context)!.dayBook,
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: ListView(
                  children: _allFinancialData(context),
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
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(DateTime.now().year - 3),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(DateTime.now().year + 1),
                initialDatePickerMode: DatePickerMode.day,
                helpText: "Select Due Date");

            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
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
                      DateFormat('EEE, d/M/y').format(selectedDate),
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
                      fontSize: 14, fontWeight: FontWeight.bold),
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
    for (var element in allFinancialData) {
      if (!element.isDeleted) {
        data.add(_singleFinancialData(context, element));
        data.add(const Divider(height: 0));
      }
    }
    return data;
  }
}
