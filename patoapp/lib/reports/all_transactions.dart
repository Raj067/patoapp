import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/themes/light_theme.dart';

class AllTransactionsReports extends StatelessWidget {
  const AllTransactionsReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Transactions',
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
      body: ListView(
        children: [
          Container(
            color: patowavePrimary.withAlpha(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text("Detail"),
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
                      "Anitha",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Text(
                  "Tsh 27,000",
                  style: TextStyle(
                    fontSize: 16,
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
                      "Jumanne",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Text(
                  "Tsh 27,000",
                  style: TextStyle(
                    fontSize: 16,
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
                      "Purchases",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Text(
                  "Tsh 27,000",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
