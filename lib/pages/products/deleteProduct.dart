import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/productList.dart';

Future<void> productDelete(BuildContext context, SingleProduct product) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: patoBackgroundColor,
          // title: const Text('Adjust Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Are you sure you want to delete"),
              const Text(" this item?"),
              Container(height: 10),
              const Text(
                "Warning",
                style: TextStyle(color: patoRed),
              ),
              Container(height: 10),
              const Text("All of this informations will"),
              const Text(" be lost."),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Delete",
                style: TextStyle(color: patoWhite),
              ),
            ),
          ],
        );
      });
}
