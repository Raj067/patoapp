// import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:convert';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
// import 'package:patoapp/backend/sync/sync_all.dart';
import 'package:http/http.dart' as http;
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
  int receiptNo = Random().nextInt(10000);
  final BusinessController _businessController = Get.put(BusinessController());
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

  Widget _singleCustomerDetails(BuildContext context, SingleCustomer customer) {
    List items = [
      AppLocalizations.of(context)!.toBePaid,
      AppLocalizations.of(context)!.toBeReceived,
    ];
    String selectedValue = AppLocalizations.of(context)!.toBeReceived;

    final addCustomerFormKey = GlobalKey<FormState>();
    var debdtBalance = TextEditingController();
    return Card(
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
        onLongPress: () {
          Get.bottomSheet(
            isScrollControlled: true,
            backgroundColor: Theme.of(context).cardColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.debtAdjustment,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        customer.fullName,
                      ),
                      const Text(': '),
                      Text(
                        "Tsh: ${customer.amount}",
                      ),
                    ],
                  ),
                  Container(height: 15),
                  Form(
                    key: addCustomerFormKey,
                    child: TextFormField(
                      controller: debdtBalance,
                      cursorColor: patowavePrimary,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.amountRequired;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                          AppLocalizations.of(context)!.debtBalance,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 15),
                  DropdownButtonFormField2(
                    value: selectedValue,
                    selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                    scrollbarAlwaysShow: true,
                    dropdownMaxHeight: 200,
                    decoration: InputDecoration(
                      // label: Text(
                      //   AppLocalizations.of(context)!.businessType,
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     fontStyle: FontStyle.italic,
                      //   ),
                      // ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: items
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
                      selectedValue = value.toString();
                      setState(() {});
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),
                  Container(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            // MaterialStateProperty<Color?>? backgroundColor,
                            minimumSize: MaterialStateProperty.all(
                              const Size(45, 45),
                            ),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (addCustomerFormKey.currentState!.validate()) {
                              Get.back();
                              bool isToReceive = true;
                              selectedValue ==
                                      AppLocalizations.of(context)!.toBeReceived
                                  ? isToReceive = true
                                  : isToReceive = false;
                              _debtAdjustment(
                                customer: customer,
                                amount: int.tryParse(debdtBalance.text) ?? 0,
                                isToReceive: isToReceive,
                              );
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.saveAdjustment,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 10),
                ],
              ),
            ),
          );
        },
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
  }

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

  _reArrangeDataAlphabetically() {
    _customerController.allCustomers.sort(
        (a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
    setState(() {});
  }

  // _debtAdjustment({
  //   required SingleCustomer customer,
  //   required int amount,
  //   required bool isToReceive,
  // }) {
  //   showPleaseWait(
  //     context: context,
  //     builder: (context) => const ModalFit(),
  //   );
  // }

  _debtAdjustment({
    required int amount,
    required bool isToReceive,
    required SingleCustomer customer,
  }) async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    String accessToken = await storage.read(key: 'access') ?? "";
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/adding-payment-customer/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'amount': amount,
          'description': 'Debt Adjustment',
          'isPaymentIn': isToReceive,
          'id': customer.id,
          "receiptNo": receiptNo,
          'shopId': shopId,
        }),
      );

      if (response.statusCode == 201) {
        Map payment = isToReceive
            ? {
                "name": "Debt Adjustment",
                "description": "Debt Adjustment",
                "received": 0,
                "paid": amount,
                "date": DateTime.now().toIso8601String(),
              }
            : {
                "name": "Debt Adjustment",
                "description": "Debt Adjustment",
                "received": amount,
                "paid": 0,
                "date": DateTime.now().toIso8601String(),
              };
        if (isToReceive) {
          customer.amount += amount;
        } else {
          customer.amount -= amount;
        }
        customer.financialData = [payment, ...customer.financialData];
        _customerController.customerChangeUpdater(customer);
        // Add transaction
        FinancialData fData = FinancialData(
          date: DateTime.now(),
          isCashSale: false,
          isPaymentIn: isToReceive,
          isExpenses: false,
          isPaymentOut: !isToReceive,
          isPurchases: false,
          isInvoice: false,
          name: customer.fullName,
          description: "Debt Adjustment",
          details: [],
          amount: amount,
          receipt: "$receiptNo",
          discount: 0,
          id: "payment-${jsonDecode(response.body)['paymentId']}",
          shopId: shopId,
        );
        _businessController.businessChangeAdd(fData);

        Get.back();
        Get.back();
        Get.back();
      } else {
        Get.back();
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      Get.back();
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
