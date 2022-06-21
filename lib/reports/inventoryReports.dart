import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

class InventoryReports extends StatelessWidget {
  const InventoryReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory reports',
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
        child: Text("Inventory reports"),
      ),
    );
  }
}
