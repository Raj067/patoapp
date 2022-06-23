import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/pages/inventory.dart';
import 'package:patoapp/subpages/addPayment.dart';
import 'package:patoapp/subpages/addTransaction.dart';
import 'package:patoapp/subpages/overview.dart';
import 'package:patoapp/themes/lightTheme.dart';

class MainEntryHomePage extends StatefulWidget {
  const MainEntryHomePage({Key? key}) : super(key: key);

  @override
  State<MainEntryHomePage> createState() => _MainEntryHomePageState();
}

class _MainEntryHomePageState extends State<MainEntryHomePage> {
  String? selectedValue;
  final List<String> primaryUnits = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cashflow',
          style: TextStyle(color: Colors.white),
        ),
        // bottom:_bottom(context),
      ),
      body: ListView(
        children: [
          // _location(),
          _weatherHeader(),
          _headerDesign(context),
          Container(height: 10),
          _currencyExchange(),
          _calendarSection(),
          const Center(
            child: Text("Cashflow"),
          ),
        ],
      ),
    );
  }

  _singleCurrency() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            // color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(50),
            image: const DecorationImage(
              image: AssetImage("assets/img.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          // child: Image.asset("assets/img.jpg", fit: BoxFit.fill),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              "GBP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("GBP")
          ],
        )
      ],
    );
  }

  _currencyExchange() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 0,
        // color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 40,
                child: DropdownButtonFormField2(
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Primary Unit',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: primaryUnits
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10), child: _singleCurrency()),
            const Divider(height: 0),
            Padding(
                padding: const EdgeInsets.all(10), child: _singleCurrency()),
            const Divider(height: 0),
            Padding(
                padding: const EdgeInsets.all(10), child: _singleCurrency()),
          ],
        ),
      ),
    );
  }

  _calendarSection() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: patowavePrimary.withAlpha(50),
        elevation: 0,
        // color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 14,
                  ),
                  Text(
                    "January",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              ),
              Container(
                height: 15,
              ),
              Row(
                children: [
                  _singleDay(),
                  _singleDay(),
                  _singleDayActive(),
                  _singleDay(),
                  _singleDay()
                ],
              ),
              Container(
                height: 15,
              ),
              Card(
                elevation: 0,
                // color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Add Schedule", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _singleDay() {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          color: patowavePrimary.withAlpha(50),
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Mon",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10),
                Text(
                  "13",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _singleDayActive() {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Card(
          // color: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          // color: patowavePrimary.withAlpha(50),
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Tue",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 10),
                Text(
                  "14",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // PreferredSizeWidget _bottom(BuildContext context) => PreferredSize(
  _location() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        children: [
          const Icon(Icons.location_city),
          Container(width: 10),
          const Text("Dar es salaam")
        ],
      ),
    );
  }

  _weatherHeader() {
    return Container(
      color: patowavePrimary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            const Text("Today 27C"),
            Container(width: 10),
            const Icon(Icons.web_asset_sharp),
          ]),
          Row(children: [
            const Text("Tomorrow 27C"),
            Container(width: 10),
            const Icon(Icons.web_asset_sharp),
          ]),
        ]),
      ),
    );
  }

  _headerDesign(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width,
      // color: Colors.yellow,
      child: Stack(
        children: [
          _upperRow(),
          _bottomRow(),
        ],
      ),
    );
  }

  _upperRow() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: patowavePrimary,
        height: 45,
        // width: 100,
      ),
    );
  }

  _bottomRow() {
    return Positioned(
      left: 8,
      right: 8,
      bottom: 0,
      top: 0,
      child: Card(
        elevation: 0,
        // color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                height: 75,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  color: patowavePrimary.withAlpha(50),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const AddTransactionDialog(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        SizedBox(height: 10),
                        Text(
                          "Transaction",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 75,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  color: patowavePrimary.withAlpha(50),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const AddPaymentDialog(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        SizedBox(height: 10),
                        Text(
                          "Payments",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                height: 75,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  color: patowavePrimary.withAlpha(50),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const InventoryPage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        SizedBox(height: 10),
                        Text(
                          "Inventory",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                height: 75,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  color: patowavePrimary.withAlpha(50),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const OverviewDialog(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        SizedBox(height: 10),
                        Text(
                          "Overview",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Container(
            //   height: 65,
            //   width: 60,
            //   child: const Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: Colors.lightGreen,
            //   ),
            // ),
            // Container(
            //   height: 65,
            //   width: 60,
            //   child: const Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: Colors.black,
            //   ),
            // ),
            // Container(
            //   height: 65,
            //   width: 60,
            //   child: const Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: Colors.blue,
            //   ),
            // ),
            // Container(
            //   height: 65,
            //   width: 60,
            //   child: const Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: Colors.orange,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
