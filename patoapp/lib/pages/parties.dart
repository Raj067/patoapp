import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/sync/sync_customers.dart';
import 'package:patoapp/components/top_bar.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/more/reports.dart';
import 'package:patoapp/parties/add_customer.dart';
import 'package:patoapp/parties/add_payment.dart';
import 'package:patoapp/parties/single_customer.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PartiesPage extends StatefulWidget {
  const PartiesPage({Key? key}) : super(key: key);

  @override
  State<PartiesPage> createState() => _PartiesPageState();
}

class _PartiesPageState extends State<PartiesPage> {
  double totalDebtMonth = 0;
  double totalDebtWeek = 0;
  double customersDebtMonth = 0;
  double customersDebtWeek = 0;
  String dropdownValue = 'This Month';
  List dropDownList = ['This Month', 'This Week'];
  bool isAlreadyLoad = false;

  // For searching contacts
  List<SingleCustomer> customData = [];
  bool isCustomerFound = true;
  int customersMatchedInSearch = 0;
  TextEditingController searchController = TextEditingController();

  fetchCustomerHeader(SingleCustomer data) {
    for (Map dx in data.financialData) {
      DateTime date = DateTime.parse(dx['date']);

      // for monthly
      if (date.isAfter(
        DateTime(
          DateTime.now().year,
          DateTime.now().month - 1,
          DateTime.now().day,
        ),
      )) {
        customersDebtMonth += dx['paid'];
        totalDebtMonth += dx['received'];
      }
      // for Weekly
      if (date.isAfter(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 7,
        ),
      )) {
        customersDebtWeek += dx['paid'];
        totalDebtWeek += dx['received'];
      }
    }
  }

  fetchCustomersDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> customers = await DBHelperCustomer.query();
    List<SingleCustomer> finalData = [];
    totalDebtMonth = 0;
    totalDebtWeek = 0;
    customersDebtMonth = 0;
    customersDebtWeek = 0;
    for (Map<String, dynamic> e in customers) {
      if (e['shopId'] == shopId) {
        fetchCustomerHeader(fromJsonCustomer(e));
        finalData.add(fromJsonCustomer(e));
      }
    }
    customData = finalData;
    isAlreadyLoad = true;
    setState(() {});
  }

  refreshDataDB() async {
    SyncCustomers syncCustomer = SyncCustomers();
    await syncCustomer.fetchData();
    fetchCustomersDB();
  }

  @override
  void initState() {
    super.initState();
    fetchCustomersDB();
    refreshDataDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainTopBar(_partiesButtomTopBar(), context),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddPaymentDialog(
                refreshData: refreshDataDB,
              ),
              fullscreenDialog: true,
            ),
          );
        },
        label: Text(AppLocalizations.of(context)!.addPayment),
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
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SingleCustomerPage(
                  customer: customer,
                  refreshData: () async {
                    await refreshDataDB();
                  },
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
                  color: customer.isToReceive()
                      ? customer.getAmount() > 0
                          ? patowaveGreen
                          : Theme.of(context).textTheme.bodyLarge!.color
                      : patowaveErrorRed,
                  fontSize: 14,
                ),
              ),
              Text(
                customer.isToReceive()
                    ? customer.getAmount() > 0
                        ? AppLocalizations.of(context)!.toReceive
                        : ""
                    : AppLocalizations.of(context)!.toGive,
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
                      contentPadding: EdgeInsets.fromLTRB(10, 7, 10, 0),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.searchCustomer,
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      // suffixIcon: InkWell(
                      //   borderRadius: const BorderRadius.all(
                      //     Radius.circular(15),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                      //     child: SvgPicture.asset(
                      //       "assets/svg/calendar.svg",
                      //     ),
                      //   ),
                      //   onTap: () {},
                      // ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: InkWell(
                onTap: () {
                  _reArrangeDataAlphabetically();
                },
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: const Icon(Icons.sort_by_alpha, color: patowavePrimary),
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
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
                            AddCustomerDialog(refreshData: refreshDataDB),
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
                          Text(
                            AppLocalizations.of(context)!.toBeReceived,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Tsh ${dropdownValue == AppLocalizations.of(context)!.addPayment ? formatter.format(totalDebtWeek) : formatter.format(totalDebtMonth)}",
                            style: const TextStyle(
                                color: patowaveGreen,
                                fontSize: 16,
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
                          Text(
                            AppLocalizations.of(context)!.toBePaid,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Tsh ${dropdownValue == AppLocalizations.of(context)!.addPayment ? formatter.format(customersDebtWeek) : formatter.format(customersDebtMonth)}",
                            style: const TextStyle(
                                color: patowaveErrorRed,
                                fontSize: 16,
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
                    builder: (BuildContext context) => const MainReportsPage(),
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
                          Text(
                            AppLocalizations.of(context)!.debtReports,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 15, 8),
            child: SizedBox(
              height: 30,
              width: 120,
              child: DropdownButtonFormField2(
                value: dropdownValue,
                selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                dropdownOverButton: true,
                buttonHeight: 30,
                buttonWidth: 50,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).chipTheme.backgroundColor,
                  contentPadding: const EdgeInsets.all(5),
                  enabled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: InputBorder.none,
                ),
                isExpanded: false,
                icon: const Icon(
                  Icons.arrow_drop_down,
                ),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: dropDownList
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
                  setState(() {
                    dropdownValue = value.toString();
                  });
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  // selectedValue = value.toString();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _reArrangeDataAlphabetically() {
    customData.sort(
        (a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
    setState(() {});
  }
}
