import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/controllers/invoice_controller.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/invoices/create_invoice.dart';
import 'package:patoapp/invoices/preview_invoice.dart';
import 'package:patoapp/notification/duedate.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceData {
  int id;
  int amount;
  InvoiceData({required this.id, required this.amount});
}

class MainInvoicePage extends StatelessWidget {
  const MainInvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.put(CustomerController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.invoices,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patowaveWhite,
          ),
        ),
      ),
      body: GetBuilder<InvoiceController>(builder: (controller) {
        // InvoiceData
        var ref = customerController.allCustomers
            .map((element) =>
                InvoiceData(id: element.id, amount: element.amount))
            .toList()
            .obs;
        controller.totalUnpaidInvoice.value = 0;
        controller.totalOutstanding.value = 0;
        controller.totalOverdue.value = 0;
        List<Widget> myData = [
          Container(height: 10),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Obx(
                    () => Text(
                        "${AppLocalizations.of(context)!.totalUnpaidInvoice} Tsh ${formatter.format(controller.totalUnpaidInvoice.value)}"),
                  ),
                ),
                // LinearPercentIndicator(
                //   percent: outstanding / (outstanding + overdue),
                //   backgroundColor: patowaveErrorRed,
                //   progressColor: patowaveWarning,
                //   lineHeight: 10,
                //   barRadius: const Radius.circular(5),
                //   curve: Curves.easeInCirc,
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(100),
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                        colors: [
                          patowaveWarning,
                          patowaveErrorRed,
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Table(
                    border: TableBorder(
                      top: BorderSide(
                        color: Colors.grey.withAlpha(100),
                        width: 0.5,
                      ),
                      verticalInside: BorderSide(
                        color: Colors.grey.withAlpha(100),
                        width: 0.5,
                      ),
                    ),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.outstanding,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: patowaveWarning,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "Tsh: ${formatter.format(controller.totalOutstanding.value)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.overdue,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: patowaveErrorRed,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "Tsh: ${formatter.format(controller.totalOverdue.value)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // _invoices(),
        ];
        for (var dx in controller.allInvoice) {
          DateTime dueDate = DateTime.parse(dx.dueDate);
          bool isOutStanding = dueDate.isBefore(DateTime.now()) ? false : true;

          SingleCustomer myDataCustomer = customerController.allCustomers
              .firstWhere((element) => element.id == dx.customerId);

          // required amount
          int requiredAmount = dx.totalAmount - dx.amountReceived;

          int available = ref
              .firstWhere((element) => element.id == myDataCustomer.id)
              .amount;

          if (available > requiredAmount) {
            requiredAmount = requiredAmount;
            ref
                .firstWhere((element) => element.id == myDataCustomer.id)
                .amount -= requiredAmount;
          } else {
            available >= 0 ? requiredAmount = available : requiredAmount = 0;
            ref
                .firstWhere((element) => element.id == myDataCustomer.id)
                .amount = 0;
          }

          if (isOutStanding) {
            // outstanding += 1;
            controller.totalOutstanding += requiredAmount;
            // set allert
            NotificationAll(
              context: context,
              id: dx.id,
              sheduleDate: DateTime.parse(dx.dueDate),
              description:
                  "Your customer ${myDataCustomer.fullName} invoice is overdue, your action is needed.",
            ).sheduleAll();
          } else {
            // overdue += 1;
            controller.totalOverdue += requiredAmount;
          }
          controller.totalUnpaidInvoice += requiredAmount;
          myData.add(Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('d-MMM-yyy')
                                .format(DateTime.parse(dx.dueDate)),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.invoices} #${dx.invoiceNo}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            myDataCustomer.fullName,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: requiredAmount == 0
                            ? patowaveGreen.withAlpha(50)
                            : isOutStanding
                                ? patowaveWarning.withAlpha(50)
                                : patowaveErrorRed.withAlpha(50),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          requiredAmount == 0
                              ? 'Completed'
                              : isOutStanding
                                  ? AppLocalizations.of(context)!.outstanding
                                  : AppLocalizations.of(context)!.overdue,
                          style: TextStyle(
                            color: requiredAmount == 0
                                ? patowaveGreen
                                : isOutStanding
                                    ? patowaveWarning
                                    : patowaveErrorRed,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // PreviewInvoice
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => PreviewInvoice(
                                invoice: dx,
                                paidAmount: dx.totalAmount - requiredAmount,
                                requiredAmount: requiredAmount,
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.viewDetails,
                            style: TextStyle(
                              fontSize: 12,
                              color: requiredAmount == 0
                                  ? patowaveGreen
                                  : isOutStanding
                                      ? patowaveWarning
                                      : patowaveErrorRed,
                            )),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Tsh ",
                              style: TextStyle(
                                fontSize: 12,
                                color: requiredAmount == 0
                                    ? patowaveGreen
                                    : isOutStanding
                                        ? patowaveWarning
                                        : patowaveErrorRed,
                              ),
                            ),
                            Text(
                              formatter.format(requiredAmount),
                              style: TextStyle(
                                fontSize: 17,
                                color: requiredAmount == 0
                                    ? patowaveGreen
                                    : isOutStanding
                                        ? patowaveWarning
                                        : patowaveErrorRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return myData[index];
          },
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          itemCount: myData.length,
        );
      }),

      // SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      //     child: Column(
      //       children: [
      //         Container(height: 10),
      //         _invoiceHeader(),
      //         _invoices(),
      //       ],
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
                  minimumSize: MaterialStateProperty.all(
                    const Size(45, 45),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  // CreateNewInvoice

                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CreateNewInvoice(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.createNewInvoice,
                  style: const TextStyle(color: patowaveWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
