import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/productList.dart';

class ProductsCart extends StatelessWidget {
  final List<SingleProduct> products;
  const ProductsCart({Key? key, required this.products}) : super(key: key);

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
            color: patoWhite,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView(children: [
                _allSelectedProducts(context),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _allSelectedProducts(BuildContext context) {
    List<Widget> data = [];
    for (var element in products) {
      if (element.addedToCart > 0) {
        data.add(_signleSelectedProduct(context, element));
      }
    }
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
                  "Item Subtotal:",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "${product.addedToCart} canns x Tsh ${product.productPrice} = Tsh ${product.getTotalPrice()}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
