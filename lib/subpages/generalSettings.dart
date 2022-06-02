import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class GeneralSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'General Settings',
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
        child: Text("General Settings"),
      ),
    );
  }
}
