import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/productList.dart';

Future<void> productAdjustment(
    BuildContext context, SingleProduct product) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: patoBackgroundColor,
          title: const Text('Adjust Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  title: Text(product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tsh ${product.productPrice}',
                          style: const TextStyle(fontSize: 16, color: patoGrey),
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
                                      : patoGrey),
                        ),
                      ]),
                ),
              ),
              Container(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Qty:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: patoPrimaryColor,
                        onPressed: () {},
                        splashRadius: 25,
                        icon: const Icon(Icons.do_disturb_on_outlined),
                      ),
                      Container(
                          width: 50,
                          height: 25,
                          alignment: AlignmentDirectional.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(width: 1, color: patoGrey),
                                left: BorderSide(width: 1, color: patoGrey),
                                right: BorderSide(width: 1, color: patoGrey),
                                bottom: BorderSide(width: 1, color: patoGrey)),
                          ),
                          child: const Text("12")),
                      IconButton(
                        color: patoPrimaryColor,
                        splashRadius: 25,
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_outline_sharp),
                      ),
                    ],
                  )
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
