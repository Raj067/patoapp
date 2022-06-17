import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/components/topBar.dart';
import 'package:patoapp/data/customerList.dart';
import 'package:patoapp/reports/debtReports.dart';
import 'package:patoapp/subpages/addCustomer.dart';
import 'package:patoapp/subpages/addPayment.dart';
import 'package:patoapp/subpages/singleCustomer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PartiesPage extends StatelessWidget {
  const PartiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainPartiesTopBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: const [
            FirstRowPartiesData(),
            SecondRowPartiesData(),
            CustomerDetails(),
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
}

class FirstRowPartiesData extends StatelessWidget {
  const FirstRowPartiesData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        children: const [
                          Text(
                            "Tsh 12,000",
                            style: TextStyle(
                                color: patoGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "My total debt",
                            style: TextStyle(color: patoGrey, fontSize: 14),
                          ),
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
                        children: const [
                          Text(
                            "Tsh 12,000",
                            style: TextStyle(
                                color: patoRed,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total customer debt",
                            style: TextStyle(color: patoGrey, fontSize: 14),
                          ),
                        ]),
                  ),
                ),
              ]),
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
                          const Icon(Icons.file_copy, color: patoBlue),
                          Container(width: 10),
                          const Text(
                            "Debt Reports",
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
}

class SecondRowPartiesData extends StatelessWidget {
  const SecondRowPartiesData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 4,
          child: SizedBox(
            height: 50,
            child: Card(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        AddPartiesButton(),
        DateActionButton(),
        // FilterIconButton(),
      ],
    );
  }
}

class AddPartiesButton extends StatelessWidget {
  const AddPartiesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const AddCustomerDialog(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
    );
  }
}

class DateActionButton extends StatelessWidget {
  const DateActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        child: IconButton(
          icon: SvgPicture.asset("assets/svg/calendar.svg",
              width: 25, height: 25),
          onPressed: () {},
        ),
      ),
    );
  }
}

// class FilterIconButton extends StatelessWidget {
//   const FilterIconButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: IconButton(
//         icon: const Icon(Icons.filter),
//         onPressed: () {},
//       ),
//     );
//   }
// }

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];
    for (var element in allCustomerDetails()) {
      data.add(_singleCustomerDetails(context, element));
    }

    return Column(
      children: data,
    );
  }
}

Widget _singleCustomerDetails(BuildContext context, SingleCustomer customer) =>
    Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: patoGreen,
          foregroundColor: patoWhite,
          child: Text(
              "${customer.firstName.toUpperCase()[0]}${customer.lastName.toUpperCase()[0]}"),
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
        title: Text("${customer.firstName} ${customer.lastName}"),
        trailing: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              customer.amount,
              style:
                  TextStyle(color: customer.isToReceive ? patoGreen : patoRed),
            ),
            Text(
              customer.isToReceive ? "Receive" : "Give",
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
