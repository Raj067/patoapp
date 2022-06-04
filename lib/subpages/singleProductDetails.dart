import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/productList.dart';
import 'package:patoapp/pages/products/deleteProduct.dart';

import '../pages/products/adjustProduct.dart';

class SingleProductDetails extends StatelessWidget {
  SingleProductDetails({super.key, required this.product});
  final SingleProduct product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patoWhite,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: patoWhite,
            ),
          ),
          IconButton(
            onPressed: () {
              productDelete(context, product);
            },
            icon: const Icon(
              Icons.delete,
              color: patoRed,
            ),
          ),
          Container(width: 10),
        ],
      ),
      body: ListView(children: [
        Column(children: [
          SizedBox(
            // height: 200,
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.fitWidth,
            ),
          )
        ]),
        ListTile(
          title: Text(product.productName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Divider(),
        ListTile(
          title: const Text("Selling Price"),
          trailing: Text(product.sellingPrice),
        ),
        const Divider(),
        ListTile(
          title: const Text("Purchases Price"),
          trailing: Text(product.purchasesPrice),
        ),
        const Divider(),
        ListTile(
          title: const Text("Total Items sold"),
          trailing: Text("${product.totalItemsSold}"),
        ),
        const Divider(),
        ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Supplier Contacts:"),
              Text("Name: ${product.supplierName}"),
              Text("Phone: ${product.supplierContact}"),
            ],
          ),
          trailing: const Icon(Icons.phone),
        ),
      ]),
      persistentFooterButtons: [
        OutlinedButton(
          onPressed: () {},
          child: const Text("Share"),
        ),
        ElevatedButton(
          onPressed: () {
            productAdjustment(context, product);
          },
          child: const Text(
            "Adjust Item",
            style: TextStyle(color: patoWhite),
          ),
        ),
      ],
    );
  }
}
