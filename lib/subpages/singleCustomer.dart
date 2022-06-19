// ignore: file_names
import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/customerList.dart';
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
            foregroundColor: patoWhite,
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
                  color: patoWhite,
                  fontSize: 16,
                ),
              ),
              Text(
                customer.phoneNumber,
                style: const TextStyle(
                  color: patoWhite,
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
            color: patoWhite,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: patoWhite,
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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Send payment reminder",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.print), onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.whatsapp), onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.chat), onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: Colors.black38,
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
                            activeColor: patoPrimaryColor,
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
              child: Column(
                children: [
                  Container(
                    color: patoLightGreen,
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
                                color: patoGreen),
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
                          style: TextStyle(color: patoGreen),
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
          OutlinedButton(
            onPressed: () {},
            child: const Text(
              "Payment Out",
              // style: TextStyle(color: patoWhite),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Payment In",
              style: TextStyle(color: patoWhite),
            ),
          ),
        ]),
      ],
    );
  }
}

Widget _firstRowData(SingleCustomer customer) => Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  color: customer.isToReceive ? patoGreen : patowaveErrorRed,
                  child: Icon(
                    customer.isToReceive
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: patoWhite,
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
                                ? patoGreen
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
                const Icon(Icons.date_range, color: Colors.black38),
                Container(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Weka Tarehe ya malipo"),
                          Text(
                            "Tarehe ya kamilisho",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.black38),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
