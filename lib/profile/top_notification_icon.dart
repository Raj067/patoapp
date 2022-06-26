import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';

class TopNotificationIcon extends StatelessWidget {
  const TopNotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
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
        child: Text("Notifications Page"),
      ),
    );
  }
}
