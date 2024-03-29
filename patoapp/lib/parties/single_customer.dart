// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/profile_controller.dart';
// import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/backend/models/customer_list.dart';
// import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/business/transaction_receipt.dart';
import 'package:patoapp/parties/edit_customer.dart';
import 'package:patoapp/parties/add_payment_customer.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleCustomerPage extends StatefulWidget {
  final String? restorationId;
  final SingleCustomer customer;
  final Function refreshData;
  const SingleCustomerPage({
    super.key,
    required this.customer,
    this.restorationId,
    required this.refreshData,
  });

  @override
  State<SingleCustomerPage> createState() => _SingleCustomerPageState();
}

class _SingleCustomerPageState extends State<SingleCustomerPage> {
  TextEditingController dateInput = TextEditingController();
  final ProfileController _profileController = Get.put(ProfileController());

  int receiptNo = Random().nextInt(10000);
  @override
  void dispose() {
    dateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(
            backgroundColor: patowaveGreen400,
            foregroundColor: patowaveWhite,
            child: Text(widget.customer.fullName.toUpperCase()[0]),
          ),
          Container(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.customer.fullName.length > 10
                    ? widget.customer.fullName.replaceRange(10, null, '...')
                    : widget.customer.fullName,
                style: const TextStyle(
                  color: patowaveWhite,
                  fontSize: 16,
                ),
              ),
              Text(
                widget.customer.phoneNumber,
                style: const TextStyle(
                  color: patowaveWhite,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ]),
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => EditCustomer(
                    customer: widget.customer,
                    refreshData: widget.refreshData,
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: patowaveWhite,
            ),
          ),
          Container(width: 10),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          Container(height: 10),
          _firstRowData(widget.customer),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            color: patowavePrimary.withAlpha(100),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(0),
                    child: Wrap(
                      children: [
                        InkWell(
                          onTap: () {
                            _sendSMS();
                          },
                          child: const ListTile(
                            leading: Icon(
                              Icons.sms,
                              color: patowavePrimary,
                            ),
                            title: Text('SMS'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _sendWhatsApp();
                          },
                          child: const ListTile(
                            leading: Icon(
                              Icons.whatsapp,
                              color: patowavePrimary,
                            ),
                            title: Text('WhatsApp'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _sendEmail();
                          },
                          child: const ListTile(
                            leading: Icon(
                              Icons.email,
                              color: patowavePrimary,
                            ),
                            title: Text('Email'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sendPaymentReminder,
                      style: const TextStyle(),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: patowaveBlack,
                    ),
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/ringing2.svg",
                    width: 28,
                    height: 28,
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.reminderAoutomation),
                        Switch(
                          activeColor: patowavePrimary,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: patowavePrimary.withAlpha(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.note),
                        Container(),
                        Text(AppLocalizations.of(context)!.amount),
                      ],
                    ),
                  ),
                ),
                _allFinancialData(context),
              ],
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                // MaterialStateProperty<Color?>? backgroundColor,
                backgroundColor: MaterialStateProperty.all(patowaveErrorRed),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AddPaymentCustomerDialog(
                      customer: widget.customer,
                      isPaymentIn: false,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.paymentOut,
              ),
            ),
          ),
          Container(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AddPaymentCustomerDialog(
                      customer: widget.customer,
                      isPaymentIn: true,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.paymentIn,
              ),
            ),
          ),
        ]),
      ],
    );
  }

  _sendSMS() {
    String businessName = _profileController.myProfile.value.businessName;
    String businessPhone = _profileController.myProfile.value.businessPhone;
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: widget.customer.phoneNumber,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent("""
Mambo vipi ${widget.customer.fullName}, unakumbushwa kuja kulipa deni lako $businessName ($businessPhone) Tsh: ${widget.customer.getAmount()}  kama yalivyo makubaliano, 
Asante kwa kufanya biashara nasi.

$businessName
Powered by Patowave
https://patowave.com
"""),
      },
    );
    launchUrl(smsLaunchUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  _sendEmail() {
    String businessName = _profileController.myProfile.value.businessName;
    String businessPhone = _profileController.myProfile.value.businessPhone;
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.customer.email,
      query: encodeQueryParameters(<String, String>{
        'subject': """
Mambo vipi ${widget.customer.fullName}, unakumbushwa kuja kulipa deni lako $businessName ($businessPhone) Tsh: ${widget.customer.getAmount()}  kama yalivyo makubaliano, 
Asante kwa kufanya biashara nasi.

$businessName
Powered by Patowave
https://patowave.com""",
      }),
    );

    launchUrl(emailLaunchUri);
  }

  _sendWhatsApp() async {
    String businessName = _profileController.myProfile.value.businessName;
    String businessPhone = _profileController.myProfile.value.businessPhone;
    var whatsapp = widget.customer.phoneNumber;
    String message = """
Mambo vipi ${widget.customer.fullName}, unakumbushwa kuja kulipa deni lako $businessName ($businessPhone) Tsh: ${widget.customer.getAmount()}  kama yalivyo makubaliano, 
Asante kwa kufanya biashara nasi.

$businessName
Powered by Patowave
https://patowave.com""";
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=$message");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  _allFinancialData(BuildContext context) {
    List<Widget> data = [];
    for (var dx in widget.customer.financialData) {
      data.add(
        _singleFinancialData2(
          context,
          FinancialData(
            date: DateTime.parse(dx['date']),
            isCashSale: false,
            isPaymentIn: dx['received'] == 0 ? false : true,
            isExpenses: false,
            isPaymentOut: dx['received'] == 0 ? true : false,
            isPurchases: false,
            isInvoice: false,
            name: widget.customer.fullName,
            description: dx['description'],
            details: [],
            amount: dx['received'] != 0 ? dx['received'] : dx['paid'],
            receipt: 'Receipt $receiptNo',
            discount: 0,
            id: '0',
            shopId: 0,
          ),
        ),
      );
      data.add(const Divider(height: 0, indent: 10, endIndent: 10));
    }
    return Column(
      children: data,
    );
  }

  // _allFinancialData2() {
  //   List<TableRow> data = [];
  //   for (var dx in widget.customer.financialData) {
  //     data.add(_singleFinancialData(
  //       date: dx['date'],
  //       description: dx['description'],
  //       received: dx['received'],
  //       paid: dx['paid'],
  //     ));
  //     // data.add(
  //     //   const Divider(height: 0, indent: 10, endIndent: 10),
  //     // );
  //   }
  //   return Table(
  //     children: data,
  //     border: TableBorder(
  //       horizontalInside: BorderSide(
  //         width: 1,
  //         color: Theme.of(context).dividerColor,
  //       ),
  //     ),
  //     // Map<int, TableColumnWidth>? columnWidths,
  //     columnWidths: const {
  //       0: FractionColumnWidth(0.50),
  //       1: FractionColumnWidth(0.25),
  //       2: FractionColumnWidth(0.25),
  //     },
  //   );
  // }

  Widget _singleFinancialData2(BuildContext context, FinancialData data) {
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
                            // Text(
                            //   data.getDescriptionName(),
                            //   style:
                            //       const TextStyle(fontWeight: FontWeight.bold),
                            // ),
                            // Container(height: 4),
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           showPleaseWait(
                  //             context: context,
                  //             builder: (context) => const ModalFit(),
                  //           );
                  //           _deletingTransaction(data);

                  //           // setState(() {
                  //           //   data.deleteTransaction();
                  //           // });
                  //           // Navigator.pop(context);
                  //         },
                  //         style: ButtonStyle(
                  //           // MaterialStateProperty<Color?>? backgroundColor,
                  //           backgroundColor:
                  //               MaterialStateProperty.all(patowaveErrorRed),
                  //           minimumSize: MaterialStateProperty.all(
                  //             const Size(45, 45),
                  //           ),
                  //           shape: MaterialStateProperty.all(
                  //             const RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.all(
                  //                 Radius.circular(30),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         child: Text(AppLocalizations.of(context)!.delete),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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

  // TableRow _singleFinancialData({
  //   required String description,
  //   required String date,
  //   required int received,
  //   required int paid,
  // }) {
  //   return TableRow(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
  //         child: Row(
  //           children: [
  //             received == 0
  //                 ? const Icon(
  //                     Icons.keyboard_arrow_down,
  //                     color: patowaveErrorRed,
  //                   )
  //                 : const Icon(
  //                     Icons.keyboard_arrow_up,
  //                     color: patowaveGreen,
  //                   ),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     description,
  //                     style: const TextStyle(fontSize: 12),
  //                   ),
  //                   Text(
  //                     DateFormat('d MMMM, yyy').format((DateTime.parse(date))),
  //                     style: const TextStyle(
  //                       fontSize: 12,
  //                       color: patowaveWarning,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //         child: Text(
  //           received == 0 ? '-' : formatter.format(received),
  //           textAlign: TextAlign.center,
  //           style: const TextStyle(color: patowaveGreen),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
  //         child: Text(
  //           paid == 0 ? '-' : formatter.format(paid),
  //           textAlign: TextAlign.right,
  //           style: const TextStyle(color: patowaveErrorRed),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // _deletingTransaction(FinancialData data) async {
  //   String accessToken = await storage.read(key: 'access') ?? "";
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${baseUrl}api/deleting-single-transaction/'),
  //       headers: getAuthHeaders(accessToken),
  //       body: jsonEncode(<String, dynamic>{
  //         'transaction': data.getTransactionType(),
  //         'id': data.getTransactionID(),
  //       }),
  //     );

  //     if (response.statusCode == 201) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.pop(context);
  //       // ignore: use_build_context_synchronously
  //       Navigator.pop(context);
  //       setState(() {
  //         data.deleteTransaction();
  //       });
  //     } else {
  //       // ignore: use_build_context_synchronously
  //       Navigator.pop(context);
  //       showErrorMessage(
  //         context: context,
  //         builder: (context) => const ModalFitError(),
  //       );
  //       // throw Exception('Failed to updated customer.');
  //     }
  //   } catch (e) {
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //     showTimeOutMessage(
  //       context: context,
  //       builder: (context) => const ModalFitTimeOut(),
  //     );
  //   }
  // }

  _firstRowData(SingleCustomer customer) => Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: customer.isToReceive()
                          ? patowaveGreen
                          : patowaveErrorRed,
                    ),
                    child: Icon(
                      customer.isToReceive()
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: patowaveWhite,
                    ),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.debtBalance),
                            Text(
                              customer.isToReceive()
                                  ? AppLocalizations.of(context)!.toReceive
                                  : AppLocalizations.of(context)!.toGive,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          "Tsh: ${formatter.format(customer.getAmount())}",
                          style: TextStyle(
                              color: customer.isToReceive()
                                  ? patowaveGreen
                                  : patowaveErrorRed),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 5),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(DateTime.now().year + 5),
                    initialDatePickerMode: DatePickerMode.day,
                    helpText: "Select Due Date");

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('EEE, M/d/y').format(pickedDate);
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/calendar.svg",
                      width: 28,
                      height: 28,
                    ),
                    Container(width: 10),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  AppLocalizations.of(context)!.setPaymentDate),
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.dueDate,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Container(width: 10),
                                  Text(
                                    dateInput.text != '' ? dateInput.text : '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: patowaveWarning,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
