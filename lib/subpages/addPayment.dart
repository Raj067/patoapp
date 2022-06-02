import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class AddPaymentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Payment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
      body: const Center(
        child: Text("Payment Page"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: const Text(
            "Add Payment",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
