import 'dart:convert';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/sync/sync_customers.dart';
import 'package:patoapp/business/add_items/to_sales.dart';
import 'package:patoapp/business/add_new_customer.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:http/http.dart' as http;

class CreateNewInvoice extends StatefulWidget {
  final Function resetData;
  const CreateNewInvoice({Key? key, required this.resetData}) : super(key: key);

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
  final TextEditingController invoiceDescription = TextEditingController();

  fetchCustomersDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> customers = await DBHelperCustomer.query();
    List<SingleCustomer> finalData = [];
    for (Map<String, dynamic> e in customers) {
      if (e['shopId'] == shopId) {
        finalData.add(fromJsonCustomer(e));
      }
    }
    customData = finalData;
    setState(() {});
  }

  refreshData() async {
    SyncCustomers syncCustomer = SyncCustomers();
    await syncCustomer.fetchData();
    fetchCustomersDB();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchCustomersDB();
  }

  fetchData() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> products = await DBHelperProduct.query();
    List<SingleProduct> finalData = [];
    for (Map<String, dynamic> e in products) {
      if (e['shopId'] == shopId) {
        finalData.add(fromJsonProduct(e));
      }
    }
    allProducts = finalData;
    setState(() {});
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
          _addInvoice(),
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
                    _submitSalesCustomerData();
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

  _addInvoice() {
    return Expanded(
      child: Form(
        key: invoiceFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  if (value == null || value == "" || selectedCustmer == '') {
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
                                  AddNewCustomerTransaction(refreshData: () {}),
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
                    builder: (BuildContext context) => AddItemsToSale(
                      allProducts: allProducts,
                      addedItemsToSales: addedItemsToSales,
                      addItems: _addItemsToSale,
                    ),
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
                  "Tsh: ${formatter.format(discountAmount.toInt())}",
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
                  "Tsh: ${formatter.format(totalAmount.toInt() - discountAmount.toInt())}",
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
                Text(
                  "Balance Due",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: totalAmount.toInt() -
                                discountAmount.toInt() -
                                receivedAmount.toInt() >=
                            0
                        ? patowavePrimary
                        : patowaveErrorRed,
                  ),
                ),
                Text(
                  "Tsh: ${formatter.format(totalAmount.toInt() - discountAmount.toInt() - receivedAmount.toInt())}",
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
                controller: invoiceDescription,
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
            ),
          ],
        ),
      ),
    );
  }

  _addItemsToSale(SingleProduct dx) {
    addedItemsToSales.add(dx);
    setState(() {});
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
                  Expanded(
                    child: Text(
                      product.productName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Tsh ${formatter.format(product.quantity * product.sellingPrice)}",
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
        "description": invoiceDescription.text,
      });
    }
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/create-invoice/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'amount_received': receivedAmount.toInt(),
          'total_amount': totalAmount.toInt() - discountAmount.toInt(),
          'discount': discountAmount.toInt(),
          'items': items,
          'invoiceNo': invoiceNo,
          'dueDate': dueDate.text,
          'description': invoiceDescription.text == ''
              ? 'Invoice'
              : invoiceDescription.text,
          'shopId': shopId,
          "customer": int.parse(selectedCustmer ?? '1'),
        }),
      );

      if (response.statusCode == 201) {
        widget.resetData();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // widget.resetData();
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
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
