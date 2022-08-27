// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
// import 'package:patoapp/backend/sync/sync_all.dart';
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
  final CustomerController _customerController = Get.put(CustomerController());

  bool isCustomerFound = true;
  int customersMatchedInSearch = 0;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: _headerSection(context),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: _searchBox(context),
          ),
          Expanded(child: _customerDetails(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddPaymentDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        label: Text(AppLocalizations.of(context)!.addPayment),
      ),
    );
  }

  _customerDetails(BuildContext context) {

    Widget data1 = GetBuilder<CustomerController>(builder: (controller) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return _singleCustomerDetails(
              context, controller.allCustomers[index]);
        },
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        itemCount: controller.allCustomers.length,
      );
    });
    return data1;
  }

  bool _stringLinearSearch({required String child, required String parent}) =>
      parent.toLowerCase().contains(child.toLowerCase());
  _onSearchChange(String val) {
    List<SingleCustomer> newFilteredeData = [];
    List<SingleCustomer> newUnFilteredeData = [];
    for (var element in _customerController.allCustomers) {
      if (_stringLinearSearch(child: val, parent: element.fullName)) {
        newFilteredeData.add(element);
      } else {
        newUnFilteredeData.add(element);
      }
    }
    _customerController.allCustomers.value = [
      ...newFilteredeData,
      ...newUnFilteredeData
    ];
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
                  refreshData: () {},
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
                      contentPadding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.searchCustomer,
                      prefixIcon: const Icon(Icons.search),
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
                    Get.to(const AddCustomerDialog());
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
            GetBuilder<CustomerController>(builder: (controller) {
              double toBePaid = 0;
              double toBeReceived = 0;
              for (SingleCustomer e in controller.allCustomers) {
                if (!e.isToReceive()) {
                  toBePaid += e.amount * -1;
                } else {
                  toBeReceived += e.amount;
                }
              }

              return Container(
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
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Tsh ${formatter.format(toBeReceived)}",
                              style: const TextStyle(
                                color: patowaveGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Tsh ${formatter.format(toBePaid)}",
                              style: const TextStyle(
                                color: patowaveErrorRed,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]),
              );
            }),
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
                            style: const TextStyle(color: patowaveBlue),
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

  // _partiesButtomTopBar() {
  //   return PreferredSize(
  //       preferredSize: const Size.fromHeight(48.0), child: ProfileIcon());
  // }

  _reArrangeDataAlphabetically() {
    _customerController.allCustomers.sort(
        (a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
    setState(() {});
  }
}
