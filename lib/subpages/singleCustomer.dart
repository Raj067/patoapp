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
        title: Row(children: [
          CircleAvatar(
            backgroundColor: patoGreen,
            foregroundColor: patoWhite,
            child: Text(
                "${customer.firstName.toUpperCase()[0]}${customer.lastName.toUpperCase()[0]}"),
          ),
          Container(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${customer.firstName} ${customer.lastName}",
                style: const TextStyle(
                  color: patoWhite,
                  fontSize: 16,
                ),
              ),
              Text(
                customer.phoneNumber,
                style: const TextStyle(
                  color: patoWhite,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ]),
        // centerTitle: true,
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
              Icons.edit,
              color: patoWhite,
            ),
          ),
          Container(width: 10),
        ],
      ),
      body: const Center(
        child: const Text("SingleCustomer"),
      ),
    );
  }
}
