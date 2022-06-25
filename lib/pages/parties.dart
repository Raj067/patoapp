import 'package:flutter/material.dart';
import 'package:patoapp/components/topBar.dart';
import 'package:patoapp/data/customerList.dart';
import 'package:patoapp/reports/debtReports.dart';
import 'package:patoapp/parties/addCustomer.dart';
import 'package:patoapp/parties/addPayment.dart';
import 'package:patoapp/parties/singleCustomer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/themes/lightTheme.dart';

class PartiesPage extends StatelessWidget {
  const PartiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainPartiesTopBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: ListView(
          children: [
            Container(height: 5),
            _headerSection(context),
            _searchBox(context),
            _customerDetails(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddPaymentDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        label: const Text('Add Payment'),
      ),
    );
  }

  _customerDetails(BuildContext context) {
    List<Widget> data = [];
    for (var element in allCustomerDetails()) {
      data.add(_singleCustomerDetails(context, element));
    }

    return Column(
      children: data,
    );
  }

  Widget _singleCustomerDetails(
          BuildContext context, SingleCustomer customer) =>
      Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: patowaveGreen400,
            foregroundColor: patowaveWhite,
            child: Text(customer.fullName.toUpperCase()[0]),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SingleCustomerPage(
                  customer: customer,
                ),
                fullscreenDialog: true,
              ),
            );
          },
          title: Text(customer.fullName),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 10,
              // ),
              Text(
                customer.amount,
                style: TextStyle(
                    color: customer.isToReceive
                        ? patowaveGreen
                        : patowaveErrorRed),
              ),
              Text(
                customer.isToReceive ? "Receive" : "Give",
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      );

  _searchBox(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            height: 50,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: InputBorder.none,
                  suffixIcon: InkWell(
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: MyStatefulWidget(restorationId: "hello"),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const AddCustomerDialog(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _headerSection(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 0,
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              height: 60,
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            width: 1, color: Colors.black.withAlpha(50)),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            "My total debt",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Tsh 12,000",
                            style: TextStyle(
                                color: patowaveGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            "Total customer debt",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Tsh 12,000",
                            style: TextStyle(
                                color: patowaveErrorRed,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
              ]),
            ),
            const Divider(
              height: 0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const DebtReports(),
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
                          const Text(
                            "Debt Reports",
                            style: TextStyle(color: patowaveBlue),
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
        ),
      ),
    );
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
