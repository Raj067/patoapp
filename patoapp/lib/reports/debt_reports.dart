import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DebtReports extends StatelessWidget {
  const DebtReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Debt reports',
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
        child: Text("Debt reports"),
      ),
    );
  }
}
