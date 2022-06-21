import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

class ExpensesReports extends StatelessWidget {
  const ExpensesReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses',
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
        child: Text("Expenses"),
      ),
    );
  }
}
