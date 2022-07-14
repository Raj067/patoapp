import 'package:flutter/material.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/business/transaction_receipt.dart';
import 'package:patoapp/components/top_bar.dart';
import 'package:patoapp/data/business_financial_data.dart';
import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/reports/profit_loss.dart';
import 'package:patoapp/business/add_transaction.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BusinessPage extends StatefulWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  String dropdownValue = 'Last Month';
  bool isWeek = true;
  BusinessGeneral businessGeneral = BusinessGeneral(
    salesMonth: 0,
    salesWeek: 0,
    profitMonth: 0,
    profitWeek: 0,
    expensesMonth: 0,
    expensesWeek: 0,
  );

  List<FinancialData> allFinancialData = [];
  List<FinancialHeaderData> allFinancialHeader = [];
  bool isLoading = true;
  List<SingleCustomer> customData = [];
  fetchCustomer() async {
    // Financial data
    var data = await http.get(
      Uri.parse("${baseUrl}api/parties-details/"),
      headers: authHeaders,
    );
    if (data.statusCode == 200) {
      List<SingleCustomer> finalData = [];
      for (var dx in jsonDecode(data.body)) {
        finalData.add(SingleCustomer(
          address: dx['customer_address'],
          email: dx['customer_email'] ?? "",
          financialData: dx['financial_data'],
          fullName: dx['customer_name'],
          phoneNumber: dx['customer_number'],
          amount: dx['effective_amount'],
          id: dx['id'],
        ));
      }
      customData = finalData;
    }
    setState(() {});
  }

  fetchData() async {
    // Data for general analysis
    var generalData = await http.get(
      Uri.parse("${baseUrl}api/general-business-details/"),
      headers: authHeaders,
    );
    if (generalData.statusCode == 200) {
      businessGeneral = BusinessGeneral(
        salesMonth: jsonDecode(generalData.body)['sales_month'],
        salesWeek: jsonDecode(generalData.body)['sales_week'],
        profitMonth: jsonDecode(generalData.body)['profit_month'],
        profitWeek: jsonDecode(generalData.body)['profit_week'],
        expensesMonth: jsonDecode(generalData.body)['expenses_month'],
        expensesWeek: jsonDecode(generalData.body)['expenses_week'],
      );
    }
    // Fetching Financial Header Data api/financial-header/
    var dataHeader = await http.get(
      Uri.parse(
        "${baseUrl}api/financial-header/",
      ),
      headers: authHeaders,
    );
    if (dataHeader.statusCode == 200) {
      List<FinancialHeaderData> myData = [];
      for (var dx in jsonDecode(dataHeader.body)) {
        myData.add(FinancialHeaderData(
          date: DateTime.parse(dx['date']),
          income: dx['income'], //dx['income']
          expenses: dx['expenses'], //dx['expenses']
        ));
      }
      allFinancialHeader = myData;
      setState(() {});
    }
    // FETCHING FINANCIAL DATA
    var data = await http.get(
      Uri.parse(
        "${baseUrl}api/business-financial-transactions/",
      ),
      headers: authHeaders,
    );
    if (data.statusCode == 200) {
      List<FinancialData> myData = [];
      for (var dx in jsonDecode(data.body)) {
        myData.add(
          FinancialData(
            date: DateTime.parse(dx['date']),
            isCashSale: dx['isCashSale'],
            isPaymentIn: dx['isPaymentIn'],
            isExpenses: dx['isExpenses'],
            isPaymentOut: dx['isPaymentOut'],
            isPurchases: dx['isPurchases'],
            isInvoice: dx['isInvoice'],
            name: dx['name'] ?? "",
            description: dx['description'] ?? "",
            details: dx['details'],
            amount: dx['amount'],
          ),
        );
      }
      allFinancialData = myData;
      setState(() {});
    }
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainTopBar(_businessButtomTopBar(), context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: ListView(
          children: [
            Container(height: 5),
            _firstRowBusinessData(context),
            // SecondRowBusinessData(),()
            isLoading
                ? const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _allFinancialData(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddTransactionDialog(
                finalData: customData,
              ),
              fullscreenDialog: true,
            ),
          );
        },
        // icon: const Icon(Icons.add),
        label: const Text('Add Transaction'),
      ),
    );
  }

  PreferredSizeWidget _businessButtomTopBar() => PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 12, 5),
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    height: 28,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: patowaveGreen400,
                      ),
                      color: Theme.of(context).chipTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      alignment: AlignmentDirectional.topStart,
                      underline: Container(
                        height: 0,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          dropdownValue == 'Last Month'
                              ? isWeek = false
                              : isWeek = true;
                        });
                      },
                      items: <String>['Last Month', 'Last Week']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  _firstRowBusinessData(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 0,
      child: SizedBox(
        height: 140,
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              height: 60,
              child: Row(children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Sales",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Tsh ${isWeek ? formatter.format(businessGeneral.salesWeek) : formatter.format(businessGeneral.salesMonth)}",
                            style: const TextStyle(
                                color: patowaveGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.black.withAlpha(50),
                        ),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Expenses",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Tsh ${isWeek ? formatter.format(businessGeneral.expensesWeek) : formatter.format(businessGeneral.expensesMonth)}",
                            style: const TextStyle(
                              color: patowaveErrorRed,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                  ),
                ),
              ]),
            ),
            const Divider(height: 0),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Profit"),
                    Text(
                      "Tshs ${isWeek ? formatter.format(businessGeneral.profitWeek) : formatter.format(businessGeneral.profitMonth)}",
                      style: const TextStyle(color: patowaveGreen),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 0),
            InkWell(
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
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.file_copy, color: patowaveBlue),
                          Container(width: 10),
                          const Text(
                            "Financial Reports",
                            style: TextStyle(color: patowaveBlue),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: patowaveBlue, size: 14),
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

  Widget _singleFinancialData(BuildContext context, FinancialData data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => TransactionReceipt(data: data),
            fullscreenDialog: true,
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            // Using Wrap makes the bottom sheet height the height of the content.
            // Otherwise, the height will be half the height of the screen.
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                children: [
                  const Text(
                    "Transaction Details:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.getDescriptionName(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(height: 4),
                            Text(
                              data.getDescriptionDetails(),
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(width: 10),
                      Text(
                        "Tsh. ${formatter.format(data.amount)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: data.isIncome()
                              ? patowaveGreen
                              : patowaveErrorRed,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15),
                  // FOR PURCHASES AND CASH SALE ONLY
                  data.isPurchases || data.isCashSale
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Items",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            _listItemsButtomSheet(data.details),
                          ],
                        )
                      : Container(),
                  // END
                  Container(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(height: 4),
                          Text(
                            data.getTimeString(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Text(
                        "Time: ${data.date.hour}:${data.date.minute}",
                      ),
                    ],
                  ),
                  Container(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showPleaseWait(
                              context: context,
                              builder: (context) => const ModalFit(),
                            );
                            _deletingTransaction(data);

                            // setState(() {
                            //   data.deleteTransaction();
                            // });
                            // Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            // MaterialStateProperty<Color?>? backgroundColor,
                            backgroundColor:
                                MaterialStateProperty.all(patowaveErrorRed),
                            minimumSize: MaterialStateProperty.all(
                              const Size(45, 45),
                            ),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          child: const Text("Delete"),
                        ),
                      ),
                      // Container(width: 10),
                      // Expanded(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute<void>(
                      //           builder: (BuildContext context) =>
                      //               EditTransaction(data: data),
                      //           fullscreenDialog: true,
                      //         ),
                      //       );
                      //     },
                      //     style: ButtonStyle(
                      //       minimumSize: MaterialStateProperty.all(
                      //         const Size(45, 45),
                      //       ),
                      //       shape: MaterialStateProperty.all(
                      //         const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(30),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     child: const Text(
                      //       "Edit",
                      //       style: TextStyle(color: patowaveWhite),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
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
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(width: 20),
            data.isIncome()
                ? Text(
                    formatter.format(data.amount),
                    style: const TextStyle(
                      color: patowaveGreen,
                    ),
                  )
                : Text(
                    formatter.format(data.amount),
                    style: const TextStyle(
                      color: patowaveErrorRed,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _listItemsButtomSheet(List data) {
    List<TableRow> fData = [];
    for (var dx in data) {
      fData.add(TableRow(children: [
        Text(
          dx['product'],
          style: const TextStyle(fontSize: 12),
        ),
        Center(
          child: Text(
            "${dx['quantity']} ${dx['product_unit']} x ${dx['price']}",
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${dx['quantity'] * dx['price']}",
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ]));
    }
    return Table(children: fData);
  }

  Widget _singleColumnFinancialData(
    BuildContext context, {
    required List data,
    required int income,
    required int expenses,
    required String date,
  }) {
    List<Widget> myData = [
      Container(
        color: patowavePrimary.withAlpha(50),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date),
              Text(
                "$income",
                style: const TextStyle(
                    color: patowaveGreen, fontWeight: FontWeight.bold),
              ),
              Text(
                "$expenses",
                style: const TextStyle(
                    color: patowaveErrorRed, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ];
    for (FinancialData element in data) {
      if (!element.isDeleted) {
        myData.add(_singleFinancialData(context, element));
        myData.add(const Divider(height: 0));
      }
    }
    return Column(children: myData);
  }

  _allFinancialData(BuildContext context) {
    List<Widget> data = [
      Container(
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(50),
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
              Text("Date"),
              Text("Income "),
              Text("Expenses "),
            ],
          ),
        ),
      ),
    ];
    for (var element in allBusinessFinancialData()) {
      data.add(
        _singleColumnFinancialData(
          context,
          data: element['data'],
          date: element['header'].getTimeString(),
          income: element['header'].income,
          expenses: element['header'].expenses,
        ),
      );
    }

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 0,
      child: Column(
        children: data,
      ),
    );
  }

  List<Map> allBusinessFinancialData() {
    List<Map> finaldata = [];
    for (var element in allFinancialHeader) {
      List data = [];
      for (var dx in allFinancialData) {
        if (element.getTimeString() == dx.getTimeString()) {
          data.add(dx);
        }
      }
      if (data.isNotEmpty) {
        finaldata.add({
          "header": element,
          "data": data,
        });
      }
    }
    return finaldata;
  }

  _deletingTransaction(FinancialData data) async {
    final response = await http.post(
      Uri.parse('${baseUrl}api/deleting-single-transaction/'),
      headers: authHeaders,
      body: jsonEncode(<String, dynamic>{
        'transaction': data.getTransactionType(),
        'id': data.getTransactionID(),
      }),
    );

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      setState(() {
        data.deleteTransaction();
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage(
        context: context,
        builder: (context) => const ModalFitError(),
      );
      // throw Exception('Failed to updated customer.');
    }
  }
}
