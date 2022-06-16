import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/customerList.dart';
import 'package:patoapp/parties/previewInvoice.dart';
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => PreviewInvoice(
                customer: customer,
              ),
              fullscreenDialog: true,
            ),
          );
        },
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("INV0001"),
                      Text("01/01/2020"),
                    ],
                  ),
                  Text(
                    "${customer.firstName} ${customer.lastName}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    children: const [
                      Icon(
                        Icons.wallet,
                        color: patoLightGreen,
                      ),
                      Text("Update payment"),
                    ],
                  ),
                  Column(
                    children: const [
                      Icon(
                        Icons.notifications,
                        color: patoLightGreen,
                      ),
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
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          customer.isToReceive ? "Outstanding" : "Overdue",
                          style: TextStyle(
                              color: customer.isToReceive ? patoGreen : patoRed,
                              fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
