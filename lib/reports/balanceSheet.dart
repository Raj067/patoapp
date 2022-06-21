import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

class BalanceSheet extends StatelessWidget {
  const BalanceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Balancesheet',
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
        child: Text("Balancesheet"),
      ),
    );
  }
}
