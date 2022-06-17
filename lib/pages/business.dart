import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/components/topBar.dart';
import 'package:patoapp/data/businessFinancialData.dart';
import 'package:patoapp/reports/profitLoss.dart';
import 'package:patoapp/subpages/addTransaction.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  String dropdownValue = 'Last Month';
  bool isWeek = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainTopBar(_businessButtomTopBar(), context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: [
            _firstRowBusinessData(context),
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
            _allFinancialData(context),
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
                    // color: patoWhite,
                    margin: const EdgeInsets.all(12.0),
                    padding: const EdgeInsets.all(2),
                    height: 24,
                    decoration: BoxDecoration(
                      color: patoLightGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      alignment: AlignmentDirectional.topStart,
                      underline: Container(
                        height: 0,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 15,
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
      child: SizedBox(
        height: 140,
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              height: 60,
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                      ),
                      border: Border(
                        top: BorderSide(width: 1, color: patoGreen),
                        left: BorderSide(width: 1, color: patoGreen),
                        right: BorderSide(width: 1, color: patoGreen),
                        bottom: BorderSide(width: 1, color: patoGreen),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Sales",
                            style: TextStyle(color: patoGrey, fontSize: 18),
                          ),
                          Text(
                            "Tsh ${isWeek ? businessGeneral.salesWeek : businessGeneral.salesMonth}",
                            style: const TextStyle(
                                color: patoGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                      ),
                      border: Border(
                        top: BorderSide(width: 1, color: patoRed),
                        left: BorderSide(width: 1, color: patoRed),
                        right: BorderSide(width: 1, color: patoRed),
                        bottom: BorderSide(width: 1, color: patoRed),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Expenses",
                            style: TextStyle(color: patoGrey, fontSize: 18),
                          ),
                          Text(
                            "Tsh ${isWeek ? businessGeneral.expensesWeek : businessGeneral.expensesMonth}",
                            style: const TextStyle(
                              color: patoRed,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profit",
                      style: TextStyle(color: patoGrey),
                    ),
                    Text(
                      "Tshs ${isWeek ? businessGeneral.profitWeek : businessGeneral.profitMonth}",
                      style: const TextStyle(color: patoGreen),
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
                          const Icon(Icons.file_copy, color: patoBlue),
                          Container(width: 10),
                          const Text(
                            "Financial Reports",
                            style: TextStyle(color: patoBlue),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: patoBlue, size: 14),
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

  Widget _singleFinancialData(
      BuildContext context, BusinessFinancial data, String date) {
    return InkWell(
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
                    "Transactions Details:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(height: 4),
                          Text(
                            data.description,
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Text(
                        "Tsh. ${data.price}",
                        style: TextStyle(
                          fontSize: 16,
                          color: data.isIncome ? patoGreen : patoRed,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 30),
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
                            date,
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Text(
                        data.time,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Container(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            data.deleteTransaction();
                          });
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(patoRed)),
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: patoWhite),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: patoWhite),
                        ),
                      ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                data.isIncome
                    ? const Icon(Icons.keyboard_arrow_down, color: patoGreen)
                    : const Icon(Icons.keyboard_arrow_up, color: patoRed),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data.description,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            data.isIncome
                ? Text(
                    "${data.price}",
                    style: const TextStyle(color: patoGreen),
                  )
                : const Text("-"),
            data.isIncome
                ? const Text("-")
                : Text(
                    "${data.price}",
                    style: const TextStyle(color: patoRed),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _singleColumnFinancialData(BuildContext context,
      List<BusinessFinancial> data, var income, var expenses, String date) {
    List<Widget> myData = [
      Container(
        color: patoLightGreen,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date),
              Text(
                income,
                style: const TextStyle(
                    color: patoGreen, fontWeight: FontWeight.bold),
              ),
              Text(
                expenses,
                style: const TextStyle(
                    color: patoRed, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ];
    for (BusinessFinancial element in data) {
      myData.add(_singleFinancialData(context, element, date));
      myData.add(const Divider(height: 0));
    }
    return Card(child: Column(children: myData));
  }

  _allFinancialData(BuildContext context) {
    List<Widget> data = [];
    for (var element in allBusinessFinancialData()) {
      data.add(
        _singleColumnFinancialData(
            context, element[3], element[1], element[2], element[0]),
      );
    }

    return Column(
      children: data,
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
