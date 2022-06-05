import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/customerList.dart';
import 'package:patoapp/subpages/singleCustomer.dart';

class InvoiceDetails extends StatelessWidget {
  const InvoiceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];
    for (var element in allCustomerDetails()) {
      data.add(_singleInvoiceDetails(context, element));
    }

    return Column(
      children: data,
    );
  }
}

Widget _singleInvoiceDetails(BuildContext context, SingleCustomer customer) =>
    Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("INV0001"),
                    Text("01/01/2020"),
                  ],
                ),
                Text(
                  "${customer.firstName} ${customer.lastName}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(Icons.wallet),
                    Text("Update payment"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.notifications),
                    Text("Remind"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      customer.amount,
                      style: TextStyle(
                        color: customer.isToReceive ? patoGreen : patoRed,
                      ),
                    ),
                    InputChip(
                      label: Text(
                        customer.isToReceive ? "Outstanding" : "Overdue",
                        style: TextStyle(
                            color: customer.isToReceive ? patoGreen : patoRed,
                            fontSize: 10),
                      ),
                      // backgroundColor: ,
                      // backgroundColor: Color.fromARGB(255, 248, 76, 76),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
