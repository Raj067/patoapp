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
          'Sale Transaction',
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cancel,
              color: patoWhite,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView(children: [
                _allSelectedProducts(context),
                _discount(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  _discount() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Discount",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Container(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextField(
                    // cursorHeight: 1,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsetsDirectional.all(0),
                      border: InputBorder.none,
                      fillColor: patoBackgroundColor,
                      filled: true,
                      hintText: '0',
                      prefixIcon: Container(
                        color: const Color.fromARGB(255, 255, 200, 200),
                        child: const Icon(
                          Icons.percent,
                          color: patoRed,
                        ),
                      ),
                      // enabledBorder: InputBorder.none,
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextField(
                    // cursorHeight: 1,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsetsDirectional.all(0),
                      border: InputBorder.none,
                      fillColor: patoBackgroundColor,
                      filled: true,
                      hintText: '0',
                      prefixIcon: Container(
                        color: Colors.grey,
                        child: const Text("Tsh",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      // enabledBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            )
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
