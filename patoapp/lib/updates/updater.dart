import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/themes/light_theme.dart';
import 'package:store_redirect/store_redirect.dart';

class Updater extends StatelessWidget {
  const Updater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: patowaveWhite,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // Image.asset('name'),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: patowavePrimary,
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                              image: AssetImage('assets/icon/icon.png')),
                        ),
                      ),
                      Container(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'PatoWave needs an update',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Update to Continue',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 10),
                  const Text('To use this app, download the latest version'),
                  Container(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            StoreRedirect.redirect(
                              androidAppId: "com.patowave.patoapp",
                            );
                          },
                          child: const Text('UPDATE'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset("assets/images/google.jpg", height: 30),
            // const Text('Google Play'),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}

Future<bool> checkVersion() async {
  int localServerVersion = 11;
  int minRequiredVersion = 11;
  String accessToken = await storage.read(key: 'access') ?? "";
  try {
    var data = await http.get(
      Uri.parse(
        "${baseUrl}api/version-check/",
      ),
      headers: getAuthHeaders(accessToken),
    );
    if (data.statusCode == 200) {
      minRequiredVersion = jsonDecode(data.body)['version'];
    }
  } catch (e) {
    //
  }

  if (minRequiredVersion <= localServerVersion) {
    return true;
  } else {
    return false;
  }
}
