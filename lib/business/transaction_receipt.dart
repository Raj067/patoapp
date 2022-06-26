// ignore: file_names

import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';

class TransactionReceipt extends StatelessWidget {
  const TransactionReceipt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction Receipt',
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
      body: const Center(
        child: Text("Transaction"),
      ),
    );
  }
}
