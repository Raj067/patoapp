import 'dart:convert';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/business/add_new_customer.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:http/http.dart' as http;

class AddTransactionDialog extends StatefulWidget {
  final Function resetData;
  final List<SingleCustomer> finalData;
  const AddTransactionDialog(
      {Key? key, required this.finalData, required this.resetData})
      : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  int _value = 1;
  final salesTransactionFormKey = GlobalKey<FormState>();
  final expensesTransactionFormKey = GlobalKey<FormState>();
  final addItemToSalesFormKey = GlobalKey<FormState>();
  final addItemToPurchasesFormKey = GlobalKey<FormState>();
  List<SingleProduct> allProducts = [];
  List<SingleProduct> addedItemsToSales = [];
  List<SingleProduct> addedItemsToPurchases = [];
  bool isLoading = false;
  String selectedUnit = "Items";

  int receiptNo = Random().nextInt(10000);
  int billNo = Random().nextInt(10000);
  // for cash sales
  double totalAmount = 0;
  double discountAmount = 0;
  String? selectedValue;
  String? selectedProductValueSales;
  String? selectedProductValuePurchases;
  String? selectedCustmer;
  String expensesCategory = 'Purchases';
  final TextEditingController customerController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController quantityControllerSales = TextEditingController();
  final TextEditingController quantityControllerPurchases =
      TextEditingController();
  final TextEditingController expensesController = TextEditingController();
// expenses
  final TextEditingController totalAmountPaid = TextEditingController();
  final TextEditingController expensesDescription = TextEditingController();
  final TextEditingController salesDescription = TextEditingController();
  double totalPurchasesAmount = 0.0;
  // Fetching data
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";
    var data = await http.get(
      Uri.parse("${baseUrl}api/inventory-products/"),
      headers: getAuthHeaders(accessToken),
    );

    List<SingleProduct> finalData = [];
    if (data.statusCode == 200) {
      for (var dx in jsonDecode(data.body)) {
        finalData.add(SingleProduct(
          isService: dx['is_service'] ?? false,
          productUnit: dx["primary_unit"] ?? "Items",
          id: dx['id'],
          productName: dx["product_name"],
          quantity: dx['quantity'],
          purchasesPrice: dx['purchases_price'],
          sellingPrice: dx['selling_price_primary'],
          stockLevel: dx['stock_level'],
          supplierName: dx['supplier_name'] ?? '',
          supplierContact: dx['supplier_number'] ?? '',
          thumbnail: dx['product_image'] ?? '',
        ));
      }
    }
    // isLoading = true;
    allProducts = finalData;
    // customData = allProductDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    customerController.dispose();
    quantityControllerPurchases.dispose();
    quantityControllerSales.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Transaction',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: _value == 1
                      ? patowaveGreen.withAlpha(100)
                      : Colors.grey.withAlpha(0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _value = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          activeColor: patowaveGreen,
                          value: 1,
                          groupValue: _value,
                          onChanged: (val) {
                            setState(() {
                              _value = 1;
                            });
                          },
                        ),
                        Container(
                          width: 5,
                        ),
                        const Text("Cash Sales"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: _value == 2
                      ? patowaveErrorRed.withAlpha(100)
                      : Colors.grey.withAlpha(0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _value = 2;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          activeColor: patowaveErrorRed,
                          value: 2,
                          groupValue: _value,
                          onChanged: (val) {
                            setState(() {
                              _value = 2;
                            });
                          },
                        ),
                        Container(
                          width: 5,
                        ),
                        const Text("Expenses"),
                        Container(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Table(
            border: TableBorder.all(
              width: 1.0,
              color: Colors.grey.withAlpha(100),
            ),
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      _value == 1 ? "Receipt No $receiptNo" : "Bill No $billNo",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Date: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                ),
              ]),
            ],
          ),
          const Divider(height: 0),
          _value == 1 ? _addSales() : _addExpenses(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
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
                  if (_value == 1) {
                    // for payment in

                    // Validate returns true if the form is valid, or false otherwise.
                    if (salesTransactionFormKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      _submitSalesCustomerData();
                    }
                  } else {
                    // for payment out

                    // Validate returns true if the form is valid, or false otherwise.
                    if (expensesTransactionFormKey.currentState!.validate()) {
                      addedItemsToPurchases.isNotEmpty
                          ? _submitPurchasesData()
                          : _submitExpensesData();
                    }
                  }
                },
                child: const Text(
                  "Add Transaction",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addSales() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: salesTransactionFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  if (value !=
                      "${totalAmount.toInt() - discountAmount.toInt()}") {
                    return "Amount received should be Tsh: ${totalAmount.toInt() - discountAmount.toInt()}";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Amount Received*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              DropdownButtonFormField2(
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'This field is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text(
                      'Select Customer*',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
                  items: widget.finalData
                      .map((item) => DropdownMenuItem<String>(
                            value: "${item.id}",
                            child: Text(
                              item.fullName,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    setState(() {
                      selectedCustmer = value.toString();
                    });
                  },
                  onSaved: (value) {
                    selectedCustmer = value.toString();
                  },
                  searchController: customerController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: patowavePrimary,
                            controller: customerController,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for customer...',
                              hintStyle: TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    AddNewCustomerTransaction(
                                        refreshData: () {}),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: const Text("add"),
                        )
                      ],
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      customerController.clear();
                    }
                  }),
              Container(height: 15),
              addedItemsToSales.isNotEmpty
                  ? _allAddedItemsToSales(context)
                  : Container(),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          _addItemsToSale(context),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: patowavePrimary.withAlpha(100),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Add Items to sales",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _discount(),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Tsh: ${discountAmount.toInt()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Tsh: ${totalAmount.toInt() - discountAmount.toInt()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(height: 15),
              SizedBox(
                // height: 180,
                child: TextFormField(
                  controller: salesDescription,
                  cursorColor: patowavePrimary,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    label: Text(
                      "Descriptions",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addExpenses() {
    List<String> expenses = [
      "Purchase",
      "Carriage Inward",
      "Royalties charge",
      "Sales Commission",
      "Unloading Charge",
      "Rent",
      "Food",
      "Breakfast",
      "Printing",
      "Repair and Maintenance",
      "Equipment",
      "Fuel",
      "Utilities",
      "Training",
      "Insurance",
      "Advertisement",
      "Payroll",
      "Commission",
      "Electricity",
      "Taxes",
      "License fee",
      "Packaging material",
      "Furniture and fitting",
      "Loans and advances",
      "Service fee",
      "Software subscription",
      "Transport",
      "Others",
    ];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: expensesTransactionFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                controller: totalAmountPaid,
                onChanged: (val) {
                  setState(() {
                    totalAmountPaid.text;
                  });
                },
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Amount Paid*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              const Text(
                "Other Informations:",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              Container(height: 10),
              addedItemsToPurchases.isNotEmpty
                  ? _allAddedItemsToPurchases(context)
                  : Container(),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          _addItemsToPurchases(context),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: patowavePrimary.withAlpha(100),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Add Items to Purchases",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              addedItemsToPurchases.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        color: patowaveBlack.withAlpha(30),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Text(
                          "Purchases",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : DropdownButtonFormField2(
                      selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                      scrollbarAlwaysShow: true,
                      dropdownMaxHeight: 200,
                      decoration: InputDecoration(
                        label: const Text(
                          'Expenses Category',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                      items: expenses
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
                          expensesCategory = value.toString();
                        });
                      },
                      onSaved: (value) {
                        expensesCategory = value.toString();
                      },
                      searchController: expensesController,
                      searchInnerWidget: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          cursorColor: patowavePrimary,
                          controller: expensesController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for expenses...',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.value.toString().contains(searchValue));
                      },
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          expensesController.clear();
                        }
                      },
                    ),
              Container(height: 15),
              DropdownButtonFormField2(
                selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                scrollbarAlwaysShow: true,
                dropdownMaxHeight: 200,

                decoration: InputDecoration(
                  label: const Text(
                    'Add Contact',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
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
                items: widget.finalData
                    .map((item) => DropdownMenuItem<String>(
                          value: "${item.id}",
                          child: Text(
                            item.fullName,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  //Do something when changing the item if you want.
                  setState(() {
                    selectedCustmer = value.toString();
                  });
                },
                onSaved: (value) {
                  selectedCustmer = value.toString();
                },
                searchController: customerController,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    cursorColor: patowavePrimary,
                    controller: customerController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for contact...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return (item.value.toString().contains(searchValue));
                },
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    customerController.clear();
                  }
                },
              ),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tsh: ${totalAmountPaid.text}",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              addedItemsToPurchases.isNotEmpty
                  ? Column(
                      children: [
                        Container(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Balance due",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: patowaveErrorRed),
                            ),
                            Text(
                              "Tsh: ${int.parse(totalAmountPaid.text == '' ? '0' : totalAmountPaid.text) - totalPurchasesAmount}",
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: patowaveErrorRed),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              Container(height: 15),
              TextFormField(
                controller: expensesDescription,
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text(
                    "Descriptions",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _discount() {
    return Column(
      children: [
        Container(height: 15),
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 5, 15, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discount",
              ),
              Container(width: 5),
              Container(
                width: 30,
                height: 35,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(52, 255, 70, 57),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.percent,
                    color: patowaveErrorRed,
                    size: 16,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    cursorColor: patowavePrimary,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val) {
                      // discountAmount
                      if (val != "") {
                        discountAmount = int.parse(val) / 100 * totalAmount;
                        setState(() {});
                      } else {
                        discountAmount = 0;
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: patowavePrimary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 10),
              Container(
                width: 30,
                height: 35,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Tsh:",
                    style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    cursorColor: patowavePrimary,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val) {
                      if (val != "") {
                        discountAmount = double.parse(val);
                        setState(() {});
                      } else {
                        discountAmount = 0;
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "0.00",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: patowavePrimary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0),
        Container(height: 15),
      ],
    );
  }

  _addItemsToSale(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item to sale',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: addItemToSalesFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              DropdownButtonFormField2(
                  value: selectedProductValueSales,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'Please select item';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
                  items: allProducts
                      .map((item) => DropdownMenuItem<String>(
                            value: "${item.id}",
                            child: Text(
                              item.productName,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    setState(() {
                      selectedProductValueSales = value.toString();
                    });
                  },
                  onSaved: (value) {
                    selectedProductValueSales = value.toString();
                  },
                  searchController: textEditingController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      cursorColor: patowavePrimary,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingController.clear();
                    }
                  }),
              Container(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: quantityControllerSales,
                      cursorColor: patowavePrimary,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Quantity is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(
                          "Quantity*",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: patowaveBlack.withAlpha(30),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Text(
                          selectedUnit,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
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
                  if (addItemToSalesFormKey.currentState!.validate()) {
                    for (SingleProduct dx in allProducts) {
                      if ("${dx.id}" == selectedProductValueSales &&
                          !addedItemsToSales.map((e) => e.id).contains(dx.id)) {
                        addedItemsToSales.add(
                          SingleProduct(
                            isService: false,
                            quantity: int.parse(quantityControllerSales.text),
                            productUnit: dx.productUnit,
                            productName: dx.productName,
                            id: dx.id,
                            sellingPrice: dx.sellingPrice,
                            purchasesPrice: dx.purchasesPrice,
                          ),
                        );
                      }
                      setState(() {});
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add Item",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addItemsToPurchases(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item to Purchases',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: addItemToPurchasesFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              DropdownButtonFormField2(
                  value: selectedProductValuePurchases,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'Please select item';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
                  items: allProducts
                      .map((item) => DropdownMenuItem<String>(
                            value: "${item.id}",
                            child: Text(
                              item.productName,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    setState(() {
                      selectedProductValuePurchases = value.toString();
                    });
                  },
                  onSaved: (value) {
                    selectedProductValuePurchases = value.toString();
                  },
                  searchController: textEditingController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      cursorColor: patowavePrimary,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingController.clear();
                    }
                  }),
              Container(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: patowavePrimary,
                      controller: quantityControllerPurchases,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Quantity is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        label: Text(
                          "Quantity",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: patowaveBlack.withAlpha(30),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Text(
                          selectedUnit,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
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
                  if (addItemToPurchasesFormKey.currentState!.validate()) {
                    for (SingleProduct dx in allProducts) {
                      if ("${dx.id}" == selectedProductValuePurchases &&
                          !addedItemsToPurchases
                              .map((e) => e.id)
                              .contains(dx.id)) {
                        addedItemsToPurchases.add(
                          SingleProduct(
                            isService: false,
                            quantity:
                                int.parse(quantityControllerPurchases.text),
                            productUnit: dx.productUnit,
                            productName: dx.productName,
                            id: dx.id,
                            sellingPrice: dx.sellingPrice,
                            purchasesPrice: dx.purchasesPrice,
                          ),
                        );
                      }
                      setState(() {});
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add Item",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _allAddedItemsToSales(BuildContext context) {
    List<Widget> data = [];
    double val = 0;
    for (SingleProduct dx in addedItemsToSales) {
      val += dx.quantity * dx.sellingPrice;
      data.add(_singleSelectedProduct(context, dx));
      data.add(Container(height: 10));
    }
    setState(() {
      totalAmount = val;
    });
    return Column(children: data);
  }

  _allAddedItemsToPurchases(BuildContext context) {
    List<Widget> data = [];
    double val = 0;
    for (SingleProduct dx in addedItemsToPurchases) {
      val += dx.quantity * dx.sellingPrice;
      data.add(_singleSelectedProduct(context, dx, isSales: false));
      data.add(Container(height: 10));
    }
    setState(() {
      totalPurchasesAmount = val;
    });
    return Column(children: data);
  }

  _singleSelectedProduct(BuildContext context, SingleProduct product,
      {bool isSales = true}) {
    return Dismissible(
      key: Key("${product.id}"),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _onDeleteData(context, product, isSales: isSales);
        } else {
          _onDeleteData(context, product, isSales: isSales);
        }
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tsh ${product.quantity * product.sellingPrice}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Subtotal:",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    "${product.quantity} ${product.productUnit} x Tsh ${product.sellingPrice} = Tsh ${product.quantity * product.sellingPrice}",
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onDeleteData(BuildContext context, SingleProduct product,
      {bool isSales = true}) {
    if (isSales) {
      List<SingleProduct> newData = [];
      double val = 0;
      for (SingleProduct dx in addedItemsToSales) {
        if (dx.id != product.id) {
          val += dx.quantity * dx.sellingPrice;
          newData.add(dx);
        }
      }
      setState(() {
        addedItemsToSales = newData;
        totalAmount = val;
      });
    } else {
      List<SingleProduct> newData = [];
      for (SingleProduct dx in addedItemsToPurchases) {
        if (dx.id != product.id) {
          newData.add(dx);
        }
      }
      setState(() {
        addedItemsToPurchases = newData;
      });
    }
    // allProducts
  }

  _submitPurchasesData() async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    List<Map> items = [];
    for (var element in addedItemsToPurchases) {
      items.add({
        "id": element.id,
        "price": element.sellingPrice,
        "quantity": element.quantity,
      });
    }
    String accessToken = await storage.read(key: 'access') ?? "";
    final response = await http.post(
      Uri.parse('${baseUrl}api/purchases-transaction/'),
      headers: getAuthHeaders(accessToken),
      body: jsonEncode(<String, dynamic>{
        'amount_paid':
            totalAmountPaid.text == '' ? 0 : int.parse(totalAmountPaid.text),
        'total_amount': totalPurchasesAmount,
        'items': items,
        'billNo': billNo,
        'description': expensesDescription.text == ""
            ? "Purchases"
            : expensesDescription.text,
        "customer":
            selectedCustmer != null ? int.parse(selectedCustmer ?? '1') : null,
      }),
    );

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      widget.resetData();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // Navigator
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage(
        context: context,
        builder: (context) => const ModalFitError(),
      );
      // throw Exception('Failed to updated customer.');
    }
  }

  _submitExpensesData() async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    final response = await http.post(
      Uri.parse('${baseUrl}api/expenses-transaction/'),
      headers: getAuthHeaders(accessToken),
      body: jsonEncode(<String, dynamic>{
        'amount_paid':
            totalAmountPaid.text == '' ? 0 : int.parse(totalAmountPaid.text),
        'category': expensesCategory,
        'description': expensesDescription.text == ""
            ? "Expenses"
            : expensesDescription.text,
        'billNo': billNo,
        "customer":
            selectedCustmer != null ? int.parse(selectedCustmer ?? '1') : null,
      }),
    );

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      widget.resetData();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // Navigator
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage(
        context: context,
        builder: (context) => const ModalFitError(),
      );
      // throw Exception('Failed to updated customer.');
    }
  }

  // api/cash-sales-customer-transaction/
  _submitSalesCustomerData() async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    List<Map> items = [];
    for (var element in addedItemsToSales) {
      items.add({
        "id": element.id,
        "price": element.sellingPrice,
        "quantity": element.quantity,
        "description": salesDescription.text,
      });
    }
    String accessToken = await storage.read(key: 'access') ?? "";
    final response = await http.post(
      Uri.parse('${baseUrl}api/cash-sales-customer-transaction/'),
      headers: getAuthHeaders(accessToken),
      body: jsonEncode(<String, dynamic>{
        'amount': totalAmount - discountAmount,
        'discount': discountAmount,
        'items': items,
        'receiptNo': receiptNo,
        "customer":
            selectedCustmer != null ? int.parse(selectedCustmer ?? '1') : null,
      }),
    );

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      widget.resetData();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // Navigator
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage(
        context: context,
        builder: (context) => const ModalFitError(),
      );
      // throw Exception('Failed to updated customer.');
    }
  }
}
