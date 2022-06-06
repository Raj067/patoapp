import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/components/topBar.dart';
import 'package:patoapp/data/businessFinancialData.dart';
import 'package:patoapp/reports/financialReport.dart';
import 'package:patoapp/subpages/addTransaction.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainBusinessTopBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: [
            const FirstRowBusinessData(),
            // SecondRowBusinessData(),
            Card(
              child: Container(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Date"),
                      Text("Income (Tsh)"),
                      Text("Expenses (Tsh)"),
                    ],
                  ),
                ),
              ),
            ),
            const AllFinancialData(),
          ],
        ),
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
        label: const Text('Add Transaction'),
      ),
    );
  }
}

class FirstRowBusinessData extends StatelessWidget {
  const FirstRowBusinessData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 160,
        child: Column(children: [
          Container(
            alignment: AlignmentDirectional.centerStart,
            height: 60,
            child: Row(children: [
              Expanded(
                  child: Container(
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  border: Border(
                      top: BorderSide(width: 1, color: patoGreen),
                      left: BorderSide(width: 1, color: patoGreen),
                      right: BorderSide(width: 1, color: patoGreen),
                      bottom: BorderSide(width: 1, color: patoGreen)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Sales",
                          style: TextStyle(color: patoGrey, fontSize: 18)),
                      Text("Tsh 12,000",
                          style: TextStyle(color: patoGreen, fontSize: 16))
                    ]),
              )),
              Expanded(
                  child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10)),
                  border: Border(
                      top: BorderSide(width: 1, color: patoRed),
                      left: BorderSide(width: 1, color: patoRed),
                      right: BorderSide(width: 1, color: patoRed),
                      bottom: BorderSide(width: 1, color: patoRed)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Expenses",
                          style: TextStyle(color: patoGrey, fontSize: 18)),
                      Text("Tsh 12,000",
                          style: TextStyle(color: patoRed, fontSize: 16))
                    ]),
              )),
            ]),
          ),
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Profit",
                    style: TextStyle(color: patoGrey),
                  ),
                  Text(
                    "Tshs 13,900",
                    style: TextStyle(color: patoGreen),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => FinancialReportDialog(),
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
                      children: const [
                        Icon(Icons.file_copy, color: patoBlue),
                        Text("Financial Reports",
                            style: TextStyle(color: patoBlue)),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, color: patoBlue),
                  ],
                ),
              ),
            ),
          ),

          // const SizedBox(
          //   height: 40,
          //   child: ListTile(
          //     title: Text("Profit", style: TextStyle(color: patoGrey)),
          //     trailing: Text("Tshs 13,900", style: TextStyle(color: patoGreen)),
          //   ),
          // ),
          // const Divider(
          //   indent: 10,
          //   endIndent: 10,
          // ),

          // SizedBox(
          //   height: 40,
          //   child: ListTile(
          //     // style: ,
          //     leading: const Icon(Icons.file_copy, color: patoBlue),
          //     title: const Text("Financial Reports",
          //         style: TextStyle(color: patoBlue)),
          //     trailing: const Icon(Icons.arrow_forward_ios, color: patoBlue),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute<void>(
          //           builder: (BuildContext context) => FinancialReportDialog(),
          //           fullscreenDialog: true,
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ]),
      ),
    );
  }
}

class SecondRowBusinessData extends StatelessWidget {
  const SecondRowBusinessData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 4,
          child: Card(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        DateActionButton(),
        FilterIconButton(),
      ],
    );
  }
}

class DateActionButton extends StatelessWidget {
  const DateActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IconButton(
        icon: const Icon(Icons.date_range),
        onPressed: () {},
      ),
    );
  }
}

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IconButton(
        icon: const Icon(Icons.filter),
        onPressed: () {},
      ),
    );
  }
}

Widget _financialData(BuildContext context, BusinessFinancial data) => Card(
      child: Column(
        children: [
          Container(
            color: patoLightGreen,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.date),
                  Text(
                    data.income,
                    style: const TextStyle(
                        color: patoGreen, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.expenses,
                    style: const TextStyle(
                        color: patoRed, fontWeight: FontWeight.bold),
                  ),
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
                  children: const [
                    Icon(Icons.keyboard_arrow_up, color: patoRed),
                    Text("Purchases"),
                  ],
                ),
                const Text("-"),
                Text(
                  data.purchases,
                  style: const TextStyle(color: patoRed),
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
                  children: const [
                    Icon(Icons.keyboard_arrow_down, color: patoGreen),
                    Text("Sales"),
                  ],
                ),
                Text(
                  data.sales,
                  style: const TextStyle(color: patoGreen),
                ),
                const Text("-"),
              ],
            ),
          ),
        ],
      ),
    );

class AllFinancialData extends StatelessWidget {
  const AllFinancialData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];
    for (var element in allBusinessFinancialData()) {
      data.add(_financialData(context, element));
    }

    return Column(
      children: data,
    );
  }
}
