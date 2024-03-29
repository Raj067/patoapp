import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/reports/accounting/profit_and_loss.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';

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
      DateTime.now().day - 30,
    ),
    end: DateTime.now(),
  );
  ProfitAndLoss profitAndLoss = ProfitAndLoss(
    pickedRangeDate: DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    ),
  );
  List<FinancialData> selectedFinancialData = [];
  bool isProgressGoing = false;
  ProfileData profile =
      ProfileData(businessName: '', businessAddress: '', id: 0);

  final BusinessController _businessController = Get.put(BusinessController());
  fetchBusinessDB() {
    List<FinancialData> finalData = [];
    for (var dx in _businessController.allFinancialData) {
      if (!dx.isInvoice) {
        finalData.add(dx);
      }
    }
    finalData.sort((b, a) => a.date.compareTo(b.date));
    profitAndLoss = ProfitAndLoss(pickedRangeDate: pickedRangeDate);
    selectedFinancialData = finalData;
    setState(() {});
  }

  fetchProfileDB() async {
    List<Map<String, dynamic>> myProfile = await DBHelperProfile.query();
    List<ProfileData> finalData = [];
    finalData.addAll(myProfile.map((dx) => fromJsonProfile(dx)).toList());
    String? activeShop = await storage.read(key: 'activeShop');

    if (finalData.isNotEmpty) {
      if (activeShop == null) {
        profile = finalData[0];
      } else {
        int id = int.parse(activeShop);
        profile = finalData.firstWhere((element) => element.id == id);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchBusinessDB();
    fetchProfileDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cashflow,
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
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await Printing.layoutPdf(
        //           onLayout: (p.PdfPageFormat format) async =>
        //               await generateCashFlow(
        //                 data: selectedFinancialData,
        //                 profile: profile,
        //                 pickedRangeDate: pickedRangeDate,
        //               ));
        //     },
        //     icon: const Icon(
        //       Icons.print,
        //       color: patowaveWhite,
        //     ),
        //   ),
        //   IconButton(
        //     onPressed: () async {
        //       isProgressGoing = true;
        //       setState(() {});
        //       final file = await generateCashFlowPdf(
        //         data: selectedFinancialData,
        //         profile: profile,
        //         pickedRangeDate: pickedRangeDate,
        //       );
        //       isProgressGoing = false;
        //       setState(() {});
        //       await ImageDownloader.open(file.path);
        //     },
        //     icon: const Icon(
        //       Icons.download,
        //       color: patowaveWhite,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          isProgressGoing ? const LinearProgressIndicator() : Container(),
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
      profitAndLoss.allMoneyIn(),
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
              "Tsh ${formatter.format(profitAndLoss.totalMoneyIn())}",
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
      profitAndLoss.allMoneyOut(),
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
              "Tsh ${formatter.format(profitAndLoss.totalMoneyOut())}",
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
