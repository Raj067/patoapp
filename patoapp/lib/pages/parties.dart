import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/components/top_bar.dart';
import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/data/product_list.dart';
import 'package:patoapp/reports/debt_reports.dart';
import 'package:patoapp/parties/add_customer.dart';
import 'package:patoapp/parties/add_payment.dart';
import 'package:patoapp/parties/single_customer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PartiesPage extends StatefulWidget {
  const PartiesPage({Key? key}) : super(key: key);

  @override
  State<PartiesPage> createState() => _PartiesPageState();
}

class _PartiesPageState extends State<PartiesPage> {
  CustomersGeneral customersGeneral = CustomersGeneral(
    totalDebtMonth: 0,
    totalDebtWeek: 0,
    customersDebtMonth: 0,
    customersDebtWeek: 0,
  );
  String dropdownValue = 'Last Month';
  bool isWeek = true;
  bool isAlreadyLoad = false;

  // For searching contacts
  List<SingleCustomer> customData = [];
  bool isCustomerFound = true;
  int customersMatchedInSearch = 0;
  TextEditingController searchController = TextEditingController();
  fetchData(String path) async {
    // Data for general analysis
    var generalData = await http.get(
      Uri.parse(
        "${baseUrl}api/general-parties-details/",
      ),
      headers: authHeaders,
    );
    if (generalData.statusCode == 200) {
      customersGeneral = CustomersGeneral(
        totalDebtMonth: jsonDecode(generalData.body)['total_debt_month'],
        totalDebtWeek: jsonDecode(generalData.body)['total_debt_week'],
        customersDebtMonth:
            jsonDecode(generalData.body)['total_customer_debt_month'],
        customersDebtWeek:
            jsonDecode(generalData.body)['total_customer_debt_week'],
      );
      setState(() {});
    }

    // Financial data
    var data = await http.get(
      Uri.parse(baseUrl + path),
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
      isAlreadyLoad = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData("api/parties-details/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainTopBar(_partiesButtomTopBar(), context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: ListView(
          children: [
            Container(height: 5),
            _headerSection(context),
            _searchBox(context),
            isAlreadyLoad
                ? _customerDetails(context)
                : const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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
        label: const Text('Add Payment'),
      ),
    );
  }

  _customerDetails(BuildContext context) {
    List<Widget> data = [];
    for (var element in customData) {
      data.add(_singleCustomerDetails(context, element));
    }

    return Column(
      children: data,
    );
  }

  bool _stringLinearSearch({required String child, required String parent}) =>
      parent.toLowerCase().contains(child.toLowerCase());
  _onSearchChange(String val) {
    List<SingleCustomer> newFilteredeData = [];
    List<SingleCustomer> newUnFilteredeData = [];
    for (var element in customData) {
      if (_stringLinearSearch(child: val, parent: element.fullName)) {
        newFilteredeData.add(element);
      } else {
        newUnFilteredeData.add(element);
      }
    }
    customData = [...newFilteredeData, ...newUnFilteredeData];
    customersMatchedInSearch = newFilteredeData.length;
    if (newFilteredeData.isNotEmpty) {
      isCustomerFound = true;
    } else {
      isCustomerFound = false;
    }
    setState(() {});
  }

  Widget _singleCustomerDetails(
          BuildContext context, SingleCustomer customer) =>
      Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        elevation: 0,
        child: ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: patowaveGreen400,
            foregroundColor: patowaveWhite,
            child: Text(customer.fullName.toUpperCase()[0]),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SingleCustomerPage(
                  customer: customer,
                ),
                fullscreenDialog: true,
              ),
            );
          },
          title: Text(customer.fullName),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 10,
              // ),
              Text(
                "Tsh: ${formatter.format(customer.getAmount())}",
                style: TextStyle(
                  color:
                      customer.isToReceive() ? patowaveGreen : patowaveErrorRed,
                  fontSize: 12,
                ),
              ),
              Text(
                customer.isToReceive() ? "Receive" : "Give",
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      );

  _searchBox(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                height: 50,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  elevation: 0,
                  child: TextField(
                    controller: searchController,
                    cursorColor: patowavePrimary,
                    onChanged: (val) {
                      _onSearchChange(val);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
                      border: InputBorder.none,
                      hintText: 'Search Contact',
                      prefixIcon: const Icon(Icons.search),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: InkWell(
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: MyStatefulWidget(restorationId: "hello"),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 45,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                elevation: 0,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: const Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const AddCustomerDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        searchController.text != ''
            ? isCustomerFound
                ? Row(
                    children: [
                      Text(
                        " * $customersMatchedInSearch",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        " customers match your search ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        searchController.text,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const Text(
                        " * No customers match your search ",
                        style: TextStyle(fontSize: 12, color: patowaveErrorRed),
                      ),
                      Text(
                        searchController.text.length < 15
                            ? searchController.text
                            : searchController.text
                                .replaceRange(15, null, "..."),
                        style: const TextStyle(
                            fontSize: 12,
                            color: patowaveErrorRed,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
            : Container(),
      ],
    );
  }

  _headerSection(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 0,
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              height: 60,
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            width: 1, color: Colors.black.withAlpha(50)),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "My total debt",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Tsh ${isWeek ? formatter.format(customersGeneral.totalDebtWeek) : formatter.format(customersGeneral.totalDebtMonth)}",
                            style: const TextStyle(
                                color: patowaveGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Total customer debt",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Tsh ${isWeek ? formatter.format(customersGeneral.customersDebtWeek) : formatter.format(customersGeneral.customersDebtMonth)}",
                            style: const TextStyle(
                                color: patowaveErrorRed,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
              ]),
            ),
            const Divider(
              height: 0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const DebtReports(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.file_copy, color: patowaveBlue),
                          Container(width: 10),
                          const Text(
                            "Debt Reports",
                            style: TextStyle(color: patowaveBlue),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: patowaveBlue, size: 14),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _partiesButtomTopBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 12, 5),
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: patowaveGreen400,
                    ),
                    color: Theme.of(context).chipTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    alignment: AlignmentDirectional.topStart,
                    underline: Container(
                      height: 0,
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down_rounded,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        dropdownValue == 'Last Month'
                            ? isWeek = false
                            : isWeek = true;
                      });
                    },
                    items: <String>['Last Month', 'Last Week']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  DateTime _date = DateTime(2020, 11, 17);

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SvgPicture.asset(
        "assets/svg/calendar.svg",
      ),
      onTap: () {
        _selectDate();
      },
    );
  }
}
