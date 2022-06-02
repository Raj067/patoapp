import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/customerList.dart';

class SingleCustomerPage extends StatelessWidget {
  const SingleCustomerPage({super.key, required this.customer});
  final SingleCustomer customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SingleCustomer',
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
        child: const Text("SingleCustomer"),
      ),
    );
  }
}
