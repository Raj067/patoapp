import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/customerList.dart';

class SingleCustomerPage extends StatelessWidget {
  const SingleCustomerPage({super.key, required this.customer});
  final SingleCustomer customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(
            backgroundColor: patoGreen,
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
            _firstRowData(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "hello",
                      style: TextStyle(
                        fontSize: 16,
                      ),
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
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text("Reminder Automation"),
                trailing: Switch(
                  activeColor: patoPrimaryColor,
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _firstRowData() => Card(
      child: Column(children: const [
        ListTile(
          leading: Icon(Icons.more),
          title: Text("Debt balance"),
          subtitle: Text("To be received"),
          trailing: Icon(Icons.more),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
        ),
        ListTile(
          leading: Icon(Icons.calendar_month),
          title: Text("Debt balance"),
          subtitle: Text("To be received"),
          trailing: Icon(Icons.arrow_forward),
        ),
      ]),
    );
