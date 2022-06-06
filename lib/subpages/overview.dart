import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class OverviewDialog extends StatelessWidget {
  const OverviewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Overview',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patoWhite,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            _expenses(),
            _invoices(),
            _payable(),
            _receivable(),
            _profitLoss(),
            _balanceSheet(),
          ],
        ),
      ),
    );
  }
}

Widget _expenses() => Card(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Expenses",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Paid Invoices"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Unpaid Invoices"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Overdue Invoices"),
                Text("TZS 80,000"),
              ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Balance"),
                Text("TZS 120,000"),
              ])
        ],
      ),
    ));

Widget _invoices() => Card(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Invoices",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Paid Invoices"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Unpaid Invoices"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Overdue Invoices"),
                Text("TZS 80,000"),
              ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Balance"),
                Text("TZS 120,000"),
              ])
        ],
      ),
    ));

Widget _payable() => Card(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payables",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("To Customers"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("To Suppliers"),
                Text("TZS 120,000"),
              ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Balance"),
                Text("TZS 120,000"),
              ])
        ],
      ),
    ));

Widget _receivable() => Card(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Receivable",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("From Customers"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("From Suppliers"),
                Text("TZS 120,000"),
              ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Balance"),
                Text("TZS 120,000"),
              ])
        ],
      ),
    ));

Widget _profitLoss() => Card(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profit & Loss",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Sales"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("COGS"),
                Text("TZS 120,000"),
              ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Gross Profit"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Expenses"),
                Text("TZS 120,000"),
              ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Netprofit"),
                Text("TZS 120,000"),
              ])
        ],
      ),
    ));

Widget _balanceSheet() => Card(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Balance Sheet",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(height: 5),
          const Text(
            "Balance Sheet as at 07-06-2022",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Container(height: 10),
          const Text(
            "Assets",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Current Asset"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Receivable"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Fixed Assets"),
                Text("TZS 120,000"),
              ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total Assets",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "TZS 120,000",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
          Container(height: 10),
          const Text(
            "Liabilities",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Loan"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Payable"),
                Text("TZS 120,000"),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Profit & Loss"),
                Text("TZS 120,000"),
              ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total Liabilities",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "TZS 120,000",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ])
        ],
      ),
    ));
