import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/themes/light_theme.dart';

class InventorySummary extends StatelessWidget {
  const InventorySummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Summary',
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
                        child: Text("Name"),
                      ),
                      SvgPicture.asset(
                        "assets/svg/line1.svg",
                        width: 25,
                        height: 25,
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text("Quantity"),
                      ),
                      SvgPicture.asset(
                        "assets/svg/line1.svg",
                        width: 25,
                        height: 25,
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text("Value"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Table(
                    children: const [
                      TableRow(
                        decoration: BoxDecoration(),
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text("Product 1"),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Center(child: Text("8")),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Center(child: Text("Tsh 23,000")),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(),
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text("Product 2"),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Center(child: Text("8")),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Center(child: Text("Tsh 93,000")),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(),
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text("Product 3"),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Center(child: Text("8")),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Center(child: Text("Tsh 203,000")),
                          ),
                        ],
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
                  const Text(
                    "Total Value",
                    style: TextStyle(fontSize: 14),
                  ),
                  Container(width: 10),
                  const Text(
                    "Tsh 23,000",
                    style: TextStyle(fontSize: 16),
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
