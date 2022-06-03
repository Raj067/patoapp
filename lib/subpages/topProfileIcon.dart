import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class TopProfileIcon extends StatelessWidget {
  const TopProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Page',
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
        child: const Text("Profile Page"),
      ),
    );
  }
}
