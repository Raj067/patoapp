// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/parties/edit_customer.dart';
import 'package:patoapp/parties/add_payment_customer.dart';
import 'package:patoapp/themes/light_theme.dart';

class SingleCustomerPage extends StatefulWidget {
  final String? restorationId;
  final SingleCustomer customer;
  const SingleCustomerPage(
      {super.key, required this.customer, this.restorationId});

  @override
  State<SingleCustomerPage> createState() => _SingleCustomerPageState();
}

class _SingleCustomerPageState extends State<SingleCustomerPage> {
  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

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
                widget.customer.fullName,
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
                  builder: (BuildContext context) =>
                      EditCustomer(customer: widget.customer),
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
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: [
            _firstRowData(widget.customer),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              color: patowavePrimary,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Send Payment Reminder',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 14),
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
                        children: const [
                          Text("Note"),
                          Text("Received"),
                          Text("Paid"),
                        ],
                      ),
                    ),
                  ),
                  _allFinancialData(),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           const Icon(Icons.keyboard_arrow_up,
                  //               color: patowaveErrorRed),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: const [
                  //               Text(
                  //                 "-",
                  //                 style: TextStyle(fontSize: 12),
                  //               ),
                  //               Text(
                  //                 "01/01/2020",
                  //                 style: TextStyle(fontSize: 12),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       const Text("-"),
                  //       const Text(
                  //         "12,000",
                  //         style: TextStyle(color: patowaveErrorRed),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const Divider(),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           const Icon(Icons.keyboard_arrow_down,
                  //               color: patowaveGreen),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: const [
                  //               Text(
                  //                 "Opening Balance",
                  //                 style: TextStyle(fontSize: 12),
                  //               ),
                  //               Text(
                  //                 "02/01/2020",
                  //                 style: TextStyle(fontSize: 12),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       const Text(
                  //         "8,900",
                  //         style: TextStyle(color: patowaveGreen),
                  //       ),
                  //       const Text("-"),
                  //     ],
                  //   ),
                  // ),
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
                        customer: widget.customer, isPaymentIn: false),
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
                        customer: widget.customer, isPaymentIn: true),
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
    List<Widget> data = [];
    for (var dx in widget.customer.financialData) {
      data.add(_singleFinancialData(
        date: dx['date'],
        description: dx['description'],
        received: dx['received'],
        paid: dx['paid'],
      ));
      data.add(
        const Divider(height: 0, indent: 10, endIndent: 10),
      );
    }
    return Column(children: data);
  }

  _singleFinancialData({
    required String description,
    required String date,
    required int received,
    required int paid,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Text("${received == 0 ? '-' : received}"),
          Text(
            "${paid == 0 ? '-' : paid}",
            style: const TextStyle(color: patowaveErrorRed),
          ),
        ],
      ),
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
                          "${customer.getAmount()}",
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
              onTap: () {
                _selectDueDate();
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
                            children: const [
                              Text("Set payment date"),
                              Text(
                                "Due date",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black38,
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

  void _selectDueDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2025, 1, 1),
      helpText: 'Select due date',
    );
    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  DateTime _date = DateTime(2020, 11, 17);

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SvgPicture.asset(
        "assets/svg/calendar.svg",
      ),
      onTap: () {
        _selectDate();
      },
    );
  }
}
