import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsSettings extends StatefulWidget {
  const ItemsSettings({Key? key}) : super(key: key);

  @override
  State<ItemsSettings> createState() => _ItemsSettingsState();
}

class _ItemsSettingsState extends State<ItemsSettings> {
  bool isProductImage = false;
  bool isProductBarcode = false;
  fetchPreference() async {
    var prefs = await SharedPreferences.getInstance();
    isProductImage = prefs.getBool('isProductImage') ?? false;
    isProductBarcode = prefs.getBool('isProductBarcode') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Items Settings',
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
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Product Image"),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: isProductImage,
                  onChanged: (val) async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isProductImage', val);
                    fetchPreference();
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Product Barcode"),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: isProductBarcode,
                  onChanged: (val) async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isProductBarcode', val);
                    fetchPreference();
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Remind payment due"),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: true,
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
