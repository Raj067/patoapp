import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/components/topBar.dart';
import 'package:patoapp/pages/inventory.dart';
import 'package:patoapp/subpages/addPayment.dart';
import 'package:patoapp/subpages/addTransaction.dart';
import 'package:patoapp/subpages/overview.dart';
import 'package:patoapp/themes/lightTheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        title: const ProfileIcon(),
        actions: const [NotificationIcon(), SizedBox(width: 20)],
        elevation: 0,
      ),
      body: ListView(
        children: [
          _weatherHeader(),
          _headerDesign(context),
          Container(height: 10),
          _currencyExchange(),
          _calendarSection(),
          _upcomingSchedule(),
          // const Center(
          //   child: Text("Cashflow"),
          // ),
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

  _upcomingSchedule() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 0,
        // color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Upcoming Schedule",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _singleShedule(),
          _singleShedule(),
          _singleShedule(),
        ]),
      ),
    );
  }

  _singleShedule() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2.5, 10, 2.5),
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
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "time 1",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "time 2",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Founders Meeting",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "subtitle 1",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "subtitle 2",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      "View",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  _currencyExchange() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
            borderRadius: BorderRadius.circular(15),
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
            borderRadius: BorderRadius.circular(15),
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
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.locationDot,
            color: patowaveWhite, size: 16),
        Container(width: 10),
        const Text(
          "Dar es salaam",
          style: TextStyle(color: patowaveWhite),
        )
      ],
    );
  }

  _weatherHeader() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Column(
          children: [
            _location(),
            Container(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                const Text(
                  "Today 27C",
                  style: TextStyle(color: patowaveWhite),
                ),
                Container(width: 10),
                const FaIcon(FontAwesomeIcons.cloud,
                    color: patowaveWhite, size: 16),
              ]),
              Row(children: [
                const Text(
                  "Tomorrow 25C",
                  style: TextStyle(color: patowaveWhite),
                ),
                Container(width: 10),
                const FaIcon(FontAwesomeIcons.cloudRain,
                    color: patowaveWhite, size: 16),
              ]),
            ]),
          ],
        ),
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
        color: Theme.of(context).primaryColor,
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
                    borderRadius: BorderRadius.circular(15),
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
                    borderRadius: BorderRadius.circular(15),
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
                    borderRadius: BorderRadius.circular(15),
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
                    borderRadius: BorderRadius.circular(15),
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
