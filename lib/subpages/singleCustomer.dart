// ignore: file_names
import 'package:flutter/material.dart';
import 'package:patoapp/data/customerList.dart';
import 'package:patoapp/subpages/addPaymentCustomer.dart';
import 'package:patoapp/themes/lightTheme.dart';

class SingleCustomerPage extends StatelessWidget {
  const SingleCustomerPage({super.key, required this.customer});
  final SingleCustomer customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(
            backgroundColor: patowaveGreen400,
            foregroundColor: patowaveWhite,
            child: Text(
                "${customer.firstName.toUpperCase()[0]}${customer.lastName.toUpperCase()[0]}"),
          ),
          Container(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${customer.firstName} ${customer.lastName}",
                style: const TextStyle(
                  color: patowaveWhite,
                  fontSize: 16,
                ),
              ),
              Text(
                customer.phoneNumber,
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
            onPressed: () {},
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
            _firstRowData(customer),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              color: patowavePrimary,
              child: InkWell(
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
                    const Icon(
                      Icons.notifications,
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.keyboard_arrow_up,
                                color: patowaveErrorRed),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "-",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "01/01/2020",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Text("-"),
                        const Text(
                          "12,000",
                          style: TextStyle(color: patowaveErrorRed),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.keyboard_arrow_down,
                                color: patowaveGreen),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Opening Balance",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "02/01/2020",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Text(
                          "8,900",
                          style: TextStyle(color: patowaveGreen),
                        ),
                        const Text("-"),
                      ],
                    ),
                  ),
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
                        customer: customer, isPaymentIn: false),
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
                        customer: customer, isPaymentIn: false),
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
}

Widget _firstRowData(SingleCustomer customer) => Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color:
                        customer.isToReceive ? patowaveGreen : patowaveErrorRed,
                  ),
                  child: Icon(
                    customer.isToReceive
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
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
                            "To ${customer.isToReceive ? "receive" : "give"}",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        customer.amount,
                        style: TextStyle(
                            color: customer.isToReceive
                                ? patowaveGreen
                                : patowaveErrorRed),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(
                  Icons.date_range,
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
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.black38, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
