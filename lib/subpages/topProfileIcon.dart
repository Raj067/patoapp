import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/profile/myBusinessEdit.dart';
import 'package:patoapp/themes/lightTheme.dart';

class TopProfileIcon extends StatelessWidget {
  const TopProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Business',
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
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const EditMyBusiness(),
                fullscreenDialog: true,
              ),
            );
          },
          child: const Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
