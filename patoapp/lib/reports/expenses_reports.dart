import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/themes/light_theme.dart';

class ExpensesReports extends StatelessWidget {
  const ExpensesReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses Report',
          style: TextStyle(color: Colors.white),
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  color: patowavePrimary.withAlpha(100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text("Transaction"),
                      ),
                      SvgPicture.asset(
                        "assets/svg/line1.svg",
                        width: 25,
                        height: 25,
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text("Amount"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "06 Jul 2022",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "Expenses 1",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const Text(
                        "Tsh 27,000",
                        style: TextStyle(
                          fontSize: 16,
                          color: patowaveErrorRed,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "07 Jul 2022",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "Expenses 2",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const Text(
                        "Tsh 27,000",
                        style: TextStyle(
                          fontSize: 16,
                          color: patowaveErrorRed,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "08 Jul 2022",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "Expenses 3",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const Text(
                        "Tsh 27,000",
                        style: TextStyle(
                          fontSize: 16,
                          color: patowaveErrorRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: patowavePrimary.withAlpha(100),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Expenses"),
                  Container(width: 10),
                  const Text(
                    "Tsh 67,900",
                    style: TextStyle(
                      fontSize: 16,
                      color: patowaveErrorRed,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
