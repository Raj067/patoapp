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
      body: Center(
        child: Card(
          color: patowavePrimary.withAlpha(50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          elevation: 0,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text("Recently there is no notifications"),
          ),
        ),
      ),
    );
  }
}
