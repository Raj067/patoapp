import 'package:flutter/material.dart';
import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/parties/add_payment_customer.dart';
import 'package:patoapp/parties/preview_invoice.dart';
import 'package:patoapp/themes/light_theme.dart';
// import 'package:patoapp/subpages/singleCustomer.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 0,
      child: Dismissible(
        key: Key("${customer.id}"),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            // _addDataToCartManual(context, product);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddPaymentCustomerDialog(
                    customer: customer, isPaymentIn: false),
                fullscreenDialog: true,
              ),
            );
          }
          return false;
        },
        background: Container(
          decoration: BoxDecoration(
            color: patowavePrimary.withAlpha(100),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(
                Icons.notification_add,
                color: patowaveWhite,
              ),
            ),
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: patowaveGreen.withAlpha(150),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.wallet,
                color: patowaveWhite,
              ),
            ),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    PreviewInvoice(customer: customer),
                fullscreenDialog: true,
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("12-12-2020"),
                    const Text(
                      "Invoice #78",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 4,
                    ),
                    Text(
                      customer.fullName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                      color: customer.isToReceive
                          ? patowaveGreen
                          : patowaveErrorRed.withAlpha(150),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        customer.isToReceive ? "Outstanding" : "Overdue",
                        style: const TextStyle(color: patowaveWhite),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Text(
                      customer.amount,
                      style: TextStyle(
                        fontSize: 16,
                        color: customer.isToReceive
                            ? patowaveGreen
                            : patowaveErrorRed,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
