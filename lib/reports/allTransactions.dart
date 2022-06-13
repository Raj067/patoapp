import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class AllTransactionsReports extends StatelessWidget {
  const AllTransactionsReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Transactions',
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
      body: const Center(
        child: Text("All Transactions"),
      ),
    );
  }
}
