import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/productList.dart';

Future<void> productAdjustment(
    BuildContext context, SingleProduct product) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          backgroundColor: patoBackgroundColor,
          title: const Text('Adjust Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image.network(product.thumbnail,
                      //     width: 50, height: 50, fit: BoxFit.fill),
                      // Container(
                      //   width: 10,
                      // ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Tsh ${product.productPrice}',
                                        style: const TextStyle(
                                            fontSize: 16, color: patoGrey),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Qty: ${product.quantity}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                          color: product.isOutStock
                                              ? patoWarning
                                              : product.quantity == 0
                                                  ? patoRed
                                                  : patoGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Qty:"),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        // ignore: unnecessary_const
                        child: TextField(
                          // ignore: unnecessary_const
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            // hintText: 'Quantity',
                            prefixIcon: Icon(Icons.add),
                            enabledBorder: InputBorder.none,
                            // helperText: "Quantity",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () {},
                child: const Text("Add", style: TextStyle(color: patoWhite)))
          ],
        );
      });
}
