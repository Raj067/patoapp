import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/productList.dart';

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
      ),
      body: Column(children: [
        Container(
          height: 200,
          child: Image.network(
            product.thumbnail,
            fit: BoxFit.fitWidth,
          ),
        )
      ]),
    );
  }
}
