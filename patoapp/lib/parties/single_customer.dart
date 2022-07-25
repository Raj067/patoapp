// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/parties/edit_customer.dart';
import 'package:patoapp/parties/add_payment_customer.dart';
import 'package:patoapp/themes/light_theme.dart';

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
                    refreshData: () {
                      widget.refreshData();
                      Navigator.pop(context);
                    },
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
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
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Wrap(
                        children: [
                          Container(),
                        ],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Send Payment Reminder',
                        style: TextStyle(),
                      ),
                      Icon(
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
                          const Text('Reminder Automation'),
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
                          const Text("Note"),
                          Container(),
                          const Text("Received"),
                          const Text("Paid"),
                        ],
                      ),
                    ),
                  ),
                  _allFinancialData(),
                ],
              ),
            )
          ],
        ),
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
                      refreshData: () {
                        widget.refreshData();
                        Navigator.pop(context);
                      },
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: const Text(
                "Payment Out",
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
                      refreshData: () {
                        widget.refreshData();
                        Navigator.pop(context);
                      },
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: const Text(
                "Payment In",
              ),
            ),
          ),
        ]),
      ],
    );
  }

  _allFinancialData() {
    List<TableRow> data = [];
    for (var dx in widget.customer.financialData) {
      data.add(_singleFinancialData(
        date: dx['date'],
        description: dx['description'],
        received: dx['received'],
        paid: dx['paid'],
      ));
      // data.add(
      //   const Divider(height: 0, indent: 10, endIndent: 10),
      // );
    }
    return Table(
      children: data,
      border: TableBorder(
        horizontalInside: BorderSide(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
      ),
      // Map<int, TableColumnWidth>? columnWidths,
      columnWidths: const {
        0: FractionColumnWidth(0.50),
        1: FractionColumnWidth(0.25),
        2: FractionColumnWidth(0.25),
      },
    );
  }

  TableRow _singleFinancialData({
    required String description,
    required String date,
    required int received,
    required int paid,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
          child: Row(
            children: [
              received == 0
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      color: patowaveErrorRed,
                    )
                  : const Icon(
                      Icons.keyboard_arrow_up,
                      color: patowaveGreen,
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: patowaveWarning,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            received == 0 ? '-' : formatter.format(received),
            textAlign: TextAlign.center,
            style: const TextStyle(color: patowaveGreen),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
          child: Text(
            paid == 0 ? '-' : formatter.format(paid),
            textAlign: TextAlign.right,
            style: const TextStyle(color: patowaveErrorRed),
          ),
        ),
      ],
    );
  }

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
                            const Text("Debt Balance"),
                            Text(
                              "To ${customer.isToReceive() ? "receive" : "give"}",
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
                              const Text("Set payment date"),
                              Row(
                                children: [
                                  const Text(
                                    "Due date",
                                    style: TextStyle(
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
