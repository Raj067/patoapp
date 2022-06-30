import 'package:flutter/material.dart';
import 'package:patoapp/profile/my_business_edit.dart';
import 'package:patoapp/themes/light_theme.dart';

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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset("assets/images/card.png"),
          ),
          // CircularPercentIndicator(
          //   radius: 120.0,
          //   lineWidth: 13.0,
          //   animation: true,
          //   percent: 0.7,
          //   center: Text(
          //     "70.0%",
          //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          //   ),
          //   footer: Text(
          //     "Sales this week",
          //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          //   ),
          //   circularStrokeCap: CircularStrokeCap.round,
          //   progressColor: Colors.purple,
          // ),
                                                                                                                                                         
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(45, 45),
                ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const EditMyBusiness(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: const Text("Edit Profile"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(patowaveErrorRed),
                  minimumSize: MaterialStateProperty.all(
                    const Size(45, 45),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
