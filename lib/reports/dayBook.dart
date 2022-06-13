import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class DayBookReports extends StatelessWidget {
  const DayBookReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daybook',
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
        child: Text("Daybook"),
      ),
    );
  }
}
