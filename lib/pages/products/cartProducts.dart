import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/data/productList.dart';
import 'package:patoapp/themes/lightTheme.dart';

class ProductsCart extends StatefulWidget {
  final List<SingleProduct> products;
  const ProductsCart({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  int totalAmount = 0;
  int balanceDue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sale Transaction',
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
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.cancel,
        //       color: patowaveWhite,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          const Divider(height: 0),
          Table(
            border: TableBorder.all(width: 1.0, color: Colors.grey),
            children: [
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Receipt No 1",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListView(
                children: [
                  Container(height: 10),
                  // SizedBox(
                  //   height: 40,
                  //   child: TextFormField(
                  //     decoration: const InputDecoration(
                  //       label: Text(
                  //         "Amount",
                  //         style: TextStyle(
                  //             fontStyle: FontStyle.italic, fontSize: 14),
                  //       ),
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  // ),
                  // Container(height: 10),
                  // SizedBox(
                  //   height: 40,
                  //   child: TextFormField(
                  //     decoration: const InputDecoration(
                  //       label: Text(
                  //         "Party Name",
                  //         style: TextStyle(
                  //             fontStyle: FontStyle.italic, fontSize: 14),
                  //       ),
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  // ),
                  // Container(height: 10),
                  _allSelectedProducts(context),
                  _discount(),
                  Container(height: 10),
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
                        "Tsh: $totalAmount",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       "Balance due",
                  //       style: TextStyle(
                  //           fontStyle: FontStyle.italic,
                  //           fontWeight: FontWeight.bold,
                  //           color: patowavePrimary),
                  //     ),
                  //     Text(
                  //       "Tsh: $balanceDue",
                  //       style: const TextStyle(
                  //           fontStyle: FontStyle.italic,
                  //           fontWeight: FontWeight.bold,
                  //           color: patowavePrimary),
                  //     ),
                  //   ],
                  // ),
                  // Container(height: 10),
                  SizedBox(
                    // height: 180,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        label: Text(
                          "Descriptions",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: const Text(
            "Save Transaction",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
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
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Container(width: 5),
              Container(
                width: 30,
                height: 35,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(52, 255, 70, 57),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
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
                child: Container(
                  height: 35,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
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
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      hintText: "0.00",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
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

  Widget _allSelectedProducts(BuildContext context) {
    List<Widget> data = [];
    int price = 0;
    for (var element in widget.products) {
      if (element.addedToCart > 0) {
        price += element.getTotalPrice();
        data.add(_signleSelectedProduct(context, element));
      }
    }
    setState(() {
      totalAmount = price;
    });
    return Column(children: data);
  }

  _signleSelectedProduct(BuildContext context, SingleProduct product) {
    return Card(
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
                  "Tsh ${product.getTotalPrice()}",
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
                  "${product.addedToCart} cans x Tsh ${product.productPrice} = Tsh ${product.getTotalPrice()}",
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
