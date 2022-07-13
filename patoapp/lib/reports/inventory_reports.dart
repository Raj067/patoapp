import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/themes/light_theme.dart';

class InventoryReports extends StatelessWidget {
  const InventoryReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory report',
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
                        child: Text("Stock-in"),
                      ),
                      SvgPicture.asset(
                        "assets/svg/line1.svg",
                        width: 25,
                        height: 25,
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text("Stock-out"),
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
                            child: Center(child: Text("89")),
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
                            child: Center(child: Text("89")),
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
                            child: Center(child: Text("89")),
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Stock-in",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "100 items",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Container(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Stock-out",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "89 items",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
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
