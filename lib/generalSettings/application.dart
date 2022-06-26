import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';

class ApplicationSettings extends StatelessWidget {
  const ApplicationSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Application Settings',
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
        child: Text("Application Settings"),
      ),
    );
  }
}
