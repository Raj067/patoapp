import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class InventorySummary extends StatelessWidget {
  const InventorySummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Summary',
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
        child: Text("Inventory Summary"),
      ),
    );
  }
}
