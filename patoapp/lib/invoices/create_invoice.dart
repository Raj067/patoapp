import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/business/add_new_customer.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/themes/light_theme.dart';

class CreateNewInvoice extends StatefulWidget {
  const CreateNewInvoice({Key? key}) : super(key: key);

  @override
  State<CreateNewInvoice> createState() => _CreateNewInvoiceState();
}

class _CreateNewInvoiceState extends State<CreateNewInvoice> {
  int invoiceNo = Random().nextInt(10000);
  double totalAmount = 0;
  double discountAmount = 0;
  double receivedAmount = 0;
  String? selectedCustmer;
  String? selectedProductValueSales;
  bool isLoading = false;
  String selectedUnit = "Items";

  List<SingleProduct> allProducts = [];
  List<SingleProduct> addedItemsToSales = [];
  List<SingleCustomer> customData = [];
  final addItemToSalesFormKey = GlobalKey<FormState>();
  final invoiceFormKey = GlobalKey<FormState>();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController quantityControllerSales = TextEditingController();
  final TextEditingController dueDate = TextEditingController();
  fetchCustomer() async {
    String accessToken = await storage.read(key: 'access') ?? "";
    // Financial data
    var data = await http.get(
      Uri.parse("${baseUrl}api/parties-details/"),
      headers: getAuthHeaders(accessToken),
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
    fetchCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Invoice',
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
                      "Invoice No $invoiceNo",
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
          _addSales(),
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
                  if (invoiceFormKey.currentState!.validate()) {
                    // showPleaseWait(
                    //   context: context,
                    //   builder: (context) => const ModalFit(),
                    // );

                  }
                },
                child: const Text(
                  "Save Invoice",
                  style: TextStyle(color: patowaveWhite),
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
          key: invoiceFormKey,
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
                  return null;
                },
                onChanged: (val) {
                  if (val != "") {
                    receivedAmount = double.parse(val);
                    setState(() {});
                  }
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
                  items: customData
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
              TextFormField(
                controller: dueDate,
                //editing controller of this TextField
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: patowavePrimary,
                  ),
                  label: Text(
                    "Due Date*",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 5),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(DateTime.now().year + 5));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      dueDate.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
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
                          color: patowaveBlack,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Due Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: patowavePrimary,
                    ),
                  ),
                  Text(
                    "Tsh: ${totalAmount.toInt() - discountAmount.toInt() - receivedAmount.toInt()}",
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

  _singleSelectedProduct(BuildContext context, SingleProduct product) {
    return Dismissible(
      key: Key("${product.id}"),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _onDeleteData(context, product);
        } else {
          _onDeleteData(context, product);
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

  _onDeleteData(BuildContext context, SingleProduct product) {
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

    // allProducts
  }
}
