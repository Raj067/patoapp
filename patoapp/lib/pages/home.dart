import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/components/top_bar.dart';
import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/pages/inventory.dart';
import 'package:patoapp/parties/add_payment.dart';
import 'package:patoapp/business/add_transaction.dart';
import 'package:patoapp/more/overview.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:date_picker_timeline/date_picker_timeline.dart';

class MainEntryHomePage extends StatefulWidget {
  const MainEntryHomePage({Key? key}) : super(key: key);

  @override
  State<MainEntryHomePage> createState() => _MainEntryHomePageState();
}

class _MainEntryHomePageState extends State<MainEntryHomePage> {
  String baseCurrency = "USD";
  final List<String> currencyList = [
    'USD',
    'TZS',
    'EURO',
    'GBP',
  ];
  double usd = 1.0;
  double tzs = 2300.0;
  double euro = 0.920;
  double gbp = 34.90;
  List<SingleCustomer> customData = [];
  fetchData() async {
    // Financial data
    var data = await http.get(
      Uri.parse("${baseUrl}api/parties-details/"),
      headers: authHeaders,
    );
    if (data.statusCode == 200) {
      List<SingleCustomer> finalData = [];
      for (var dx in jsonDecode(data.body)) {
        finalData.add(SingleCustomer(
          address: dx['customer_address'],
          email: dx['customer_email'] ?? "",
          financialData: dx['financial_data'],
          fullName: dx['customer_name'],
          phoneNumber: dx['customer_number'],
          amount: dx['effective_amount'],
          id: dx['id'],
        ));
      }
      customData = finalData;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  _getRate({required double currency}) {
    double fcurrency = 0;
    baseCurrency == 'USD'
        ? fcurrency = currency / usd
        : baseCurrency == 'EURO'
            ? fcurrency = currency / euro
            : baseCurrency == 'GBP'
                ? fcurrency = currency / gbp
                : fcurrency = currency / tzs;
    var reqVal = "";
    "$fcurrency".length < 8
        ? reqVal = "$fcurrency"
        : reqVal = "$fcurrency".replaceRange(8, null, "");
    return reqVal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const ProfileIcon(),
        actions: const [NotificationIcon(), SizedBox(width: 20)],
        elevation: 0,
      ),
      body: Column(
        children: [
          _weatherHeader(),
          _headerDesign(context),
          Expanded(
            child: ListView(
              children: [
                // Container(height: 10),
                _currencyExchange(),
                _calendarSection(),
                _upcomingSchedule(),
                // const Center(
                //   child: Text("Cashflow"),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _singleCurrency(
      {required String currency,
      required String fcurrency,
      required String img}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            // color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.fill,
            ),
          ),
          // child: Image.asset("assets/img.jpg", fit: BoxFit.fill),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              currency,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(fcurrency)
          ],
        )
      ],
    );
  }

  _tzs() {
    return _singleCurrency(
      currency: "TZS",
      fcurrency: "Tsh ${_getRate(currency: tzs)}",
      img: "assets/flags/tzs.png",
    );
  }

  _usd() {
    return _singleCurrency(
      currency: "USD",
      fcurrency: "\$ ${_getRate(currency: usd)}",
      img: "assets/flags/dollar.png",
    );
  }

  _gbp() {
    return _singleCurrency(
      currency: "GBP",
      fcurrency: "£ ${_getRate(currency: gbp)}",
      img: "assets/flags/gbp.png",
    );
  }

  _euro() {
    return _singleCurrency(
      currency: "EURO",
      fcurrency: "€ ${_getRate(currency: euro)}",
      img: "assets/flags/euro.png",
    );
  }

  _upcomingSchedule() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 0,
        color: patowavePrimary.withAlpha(50),
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
                  children: [
                    Text(
                      "time 1",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withAlpha(100),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/svg/line1.svg",
                      width: 25,
                      height: 25,
                      color: Colors.black.withAlpha(100),
                    ),
                    Text(
                      "time 2",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withAlpha(100),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Founders Meeting",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "subtitle 1",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Created at 29-06-2022",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withAlpha(100),
                      ),
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
                  value: baseCurrency,
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  // hint: const Text(
                  //   'Primary Unit',
                  //   style: TextStyle(fontSize: 14),
                  // ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: currencyList
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
                    setState(() {
                      baseCurrency = value.toString();
                    });
                  },
                  // onSaved: (value) {
                  //   setState(() {
                  //     baseCurrency = value.toString();
                  //   });
                  // },
                ),
              ),
            ),
            baseCurrency != "TZS"
                ? Column(
                    children: [
                      const Divider(height: 0),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _tzs(),
                      ),
                    ],
                  )
                : Container(),
            baseCurrency != "EURO"
                ? Column(
                    children: [
                      const Divider(height: 0),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _euro(),
                      ),
                    ],
                  )
                : Container(),
            baseCurrency != "GBP"
                ? Column(
                    children: [
                      const Divider(height: 0),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _gbp(),
                      ),
                    ],
                  )
                : Container(),
            baseCurrency != "USD"
                ? Column(
                    children: [
                      const Divider(height: 0),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _usd(),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _calendarSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        color: Theme.of(context).primaryColor,
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
                  FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: 18,
                    color: patowaveWhite,
                  ),
                  Text(
                    "January",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: patowaveWhite,
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.angleRight,
                    size: 18,
                    color: patowaveWhite,
                  ),
                ],
              ),
              Container(
                height: 15,
              ),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    // _selectedValue = date;
                  });
                },
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
                // color: Colors.white, AddNotification
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
                      Text(
                        "Add Schedule",
                        style: TextStyle(fontSize: 16),
                      ),
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
            side: BorderSide(color: patowaveWhite, width: 0.7),
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
                  style: TextStyle(fontSize: 12, color: patowaveWhite),
                ),
                SizedBox(height: 10),
                Text(
                  "13",
                  style: TextStyle(fontSize: 14, color: patowaveWhite),
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
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
        child: Column(
          children: [
            _location(),
            Container(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    const Text(
                      "Today 27°C",
                      style: TextStyle(color: patowaveWhite),
                    ),
                    Container(width: 10),
                    const FaIcon(
                      FontAwesomeIcons.cloud,
                      color: patowaveWhite,
                      size: 16,
                    ),
                  ],
                ),
                Container(width: 20),
                Row(
                  children: [
                    const Text(
                      "Tomorrow 25°C",
                      style: TextStyle(color: patowaveWhite),
                    ),
                    Container(width: 10),
                    const FaIcon(
                      FontAwesomeIcons.cloudRain,
                      color: patowaveWhite,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _headerDesign(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
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
                height: 80,
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
                              AddTransactionDialog(
                            finalData: customData,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // FaIcon(FontAwesomeIcons.house),
                        CircleAvatar(
                          backgroundColor: patowavePrimary,
                          foregroundColor: patowaveWhite,
                          child: FaIcon(FontAwesomeIcons.newspaper),
                        ),
                        SizedBox(height: 5),
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
                height: 80,
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
                          builder: (BuildContext context) => AddPaymentDialog(
                            finalData: customData,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // FaIcon(FontAwesomeIcons.idBadge),
                        CircleAvatar(
                          backgroundColor: patowavePrimary,
                          foregroundColor: patowaveWhite,
                          child: FaIcon(
                            FontAwesomeIcons.moneyBills,
                          ),
                        ),
                        SizedBox(height: 5),
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
                height: 80,
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
                        // FaIcon(FontAwesomeIcons.boxArchive),
                        CircleAvatar(
                          backgroundColor: patowavePrimary,
                          foregroundColor: patowaveWhite,
                          child: FaIcon(FontAwesomeIcons.boxArchive),
                        ),
                        SizedBox(height: 5),
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
                height: 80,
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
                        // FaIcon(FontAwesomeIcons.chartSimple),
                        CircleAvatar(
                          backgroundColor: patowavePrimary,
                          foregroundColor: patowaveWhite,
                          child: FaIcon(FontAwesomeIcons.chartSimple),
                        ),
                        SizedBox(height: 5),
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
