import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';
// import 'package:patoapp/backend/db/db_business.dart';
// import 'package:patoapp/backend/sync/sync_business.dart';
import 'package:patoapp/business/transaction_receipt.dart';
// import 'package:patoapp/components/top_bar.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/reports/profit_loss.dart';
import 'package:patoapp/business/add_transaction.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  String dropdownValue = 'This Month';
  List dropDownList = ['This Month', 'This Week'];
  DateTimeRange pickedRangeDate = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );
  final BusinessController _businessController = Get.put(BusinessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 48,
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 15, 8),
                  child: SizedBox(
                    height: 30,
                    width: 120,
                    child: DropdownButtonFormField2(
                      value: dropdownValue,
                      selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                      dropdownOverButton: true,
                      buttonHeight: 30,
                      buttonWidth: 50,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).chipTheme.backgroundColor,
                        contentPadding: const EdgeInsets.all(5),
                        enabled: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: InputBorder.none,
                      ),
                      isExpanded: false,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: dropDownList
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value.toString();
                        });
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        // selectedValue = value.toString();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _allFinancialData(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddTransactionDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        // icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addTransaction),
      ),
    );
  }

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
        child: GetBuilder<BusinessController>(builder: (controller) {
          double salesWeek = 0;
          double expensesWeek = 0;
          double profitWeek = 0;
          double salesMonth = 0;
          double expensesMonth = 0;
          double profitMonth = 0;
          for (FinancialData data in controller.allFinancialData) {
            DateTime date = data.date;
            // for monthly
            if (date.isAfter(
              DateTime(
                DateTime.now().year,
                DateTime.now().month - 1,
                DateTime.now().day,
              ),
            )) {
              if (data.isIncome()) {
                // only cashsales and invoice
                if (data.isCashSale) {
                  salesMonth += data.amount;
                } else if (data.isInvoice) {
                  salesMonth += data.details[0]['total_amount'];
                }
              }
              if (!data.isIncome()) {
                // only expenses and purchases
                if (data.isExpenses || data.isPurchases) {
                  expensesMonth += data.amount;
                }
              }
              profitMonth = salesMonth - expensesMonth;
            }
            // for Weekly
            if (date.isAfter(
              DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day - 7,
              ),
            )) {
              if (data.isIncome()) {
                if (data.isCashSale) {
                  salesWeek += data.amount;
                } else if (data.isInvoice) {
                  salesWeek += data.details[0]['total_amount'];
                }
              }
              if (!data.isIncome()) {
                if (data.isExpenses || data.isPurchases) {
                  expensesWeek += data.amount;
                }
              }
              profitWeek = salesWeek - expensesWeek;
            }
          }
          return Column(
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
                            Text(
                              AppLocalizations.of(context)!.sales,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Tsh ${dropdownValue == 'This Week' ? formatter.format(salesWeek) : formatter.format(salesMonth)}",
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
                            Text(
                              AppLocalizations.of(context)!.expenses,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Tsh ${dropdownValue == 'This Week' ? formatter.format(expensesWeek) : formatter.format(expensesMonth)}",
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
                      Text(AppLocalizations.of(context)!.profit),
                      Text(
                        "Tsh ${dropdownValue == 'This Week' ? formatter.format(profitWeek) : formatter.format(profitMonth)}",
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
                            Text(
                              AppLocalizations.of(context)!.financialReports,
                              style: const TextStyle(color: patowaveBlue),
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
          );
        }),
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          context: context,
          builder: (context) {
            // Using Wrap makes the bottom sheet height the height of the content.
            // Otherwise, the height will be half the height of the screen.
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                children: [
                  Text(
                    AppLocalizations.of(context)!.transactionDetails,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
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
                            Text(
                              AppLocalizations.of(context)!.items,
                              style: const TextStyle(
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
                          Text(
                            AppLocalizations.of(context)!.date,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(height: 4),
                          Text(
                            data.getTimeString(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.time}: ${DateFormat('hh:mm a').format(data.date)}",
                      ),
                    ],
                  ),
                  Container(height: 30),
                  data.isInvoice
                      ? Container()
                      : Row(
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
                                  backgroundColor: MaterialStateProperty.all(
                                      patowaveErrorRed),
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
                                child:
                                    Text(AppLocalizations.of(context)!.delete),
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
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    DateFormat('EEE, d/M/y').format(data.date),
                    style:
                        const TextStyle(fontSize: 12, color: patowaveWarning),
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

  _allFinancialData(BuildContext context) {
    Widget myWidget = GetBuilder<BusinessController>(builder: (controller) {
      List<Widget> myData = [
        _firstRowBusinessData(context),
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          elevation: 0,
          margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: _searchBox(context),
        ),
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          elevation: 0,
          margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          color: patowavePrimary.withAlpha(100),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.details),
                Text(AppLocalizations.of(context)!.amount),
              ],
            ),
          ),
        ),
      ];
      controller.allFinancialData.sort((b, a) => a.date.compareTo(b.date));
      for (var element in controller.allFinancialData) {
        if (element.date.isAfter(pickedRangeDate.start) &&
            element.date
                .isBefore(pickedRangeDate.end.add(const Duration(days: 1)))) {
          if (!element.isInvoice) {
            myData.add(
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
                elevation: 0,
                margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: _singleFinancialData(context, element),
              ),
            );
            myData.add(const Divider(
              height: 0,
              thickness: 1,
              indent: 4,
              endIndent: 4,
            ));
            // data.add(_singleFinancialData(context, element));
            // data.add(const Divider(height: 0));
          }
        }
      }

      return ListView.builder(
        itemBuilder: (context, index) {
          return myData[index];
        },
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        itemCount: myData.length,
      );
    });
    return myWidget;
  }

  _searchBox(BuildContext context) {
    return SizedBox(
      height: 47,
      child: InkWell(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        onTap: () async {
          DateTimeRange? pickedDate = await showDateRangePicker(
            context: context,
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime(DateTime.now().year + 5),
            currentDate: DateTime.now(),
            confirmText: "SELECT",
            saveText: "SELECT",
            helpText: "Select Transaction Date Range",
            initialDateRange: pickedRangeDate,
          );
          if (pickedDate != null) {
            setState(() {
              pickedRangeDate = pickedDate;
              // fetchBusinessDB();
            });
          } else {}
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.search),
                  Container(width: 10),
                  Row(
                    children: [
                      Text(
                        DateFormat('EEE, d/M/y').format(pickedRangeDate.start),
                        style: const TextStyle(
                          fontSize: 12,
                          color: patowaveWarning,
                        ),
                      ),
                      const Text(
                        " to ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        DateFormat('EEE, d/M/y').format(pickedRangeDate.end),
                        style: const TextStyle(
                          fontSize: 12,
                          color: patowaveWarning,
                        ),
                      ),
                    ],
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
    );
  }

  _deletingTransaction(FinancialData data) async {
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/deleting-single-transaction/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'transaction': data.getTransactionType(),
          'itemsId': data.getTransactionID(),
          'id': data.id,
        }),
      );

      if (response.statusCode == 201) {
        _businessController.businessChangeDelete(data);

        Get.back();
        Get.back();
      } else {
        Get.back();
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
