import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
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
        child: Text("Privacy and Policy"),
      ),
    );
  }
}
