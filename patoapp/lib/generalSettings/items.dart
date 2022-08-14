import 'package:flutter/material.dart';
import 'package:patoapp/api/constants.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemsSettings extends StatefulWidget {
  const ItemsSettings({Key? key}) : super(key: key);

  @override
  State<ItemsSettings> createState() => _ItemsSettingsState();
}

class _ItemsSettingsState extends State<ItemsSettings> {
  bool isProductImage = box.read('isProductImage') ?? false;
  bool isProductBarcode = box.read('isProductBarcode') ?? false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.itemsSettings,
          style: const TextStyle(color: Colors.white),
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
                Text(AppLocalizations.of(context)!.productImage),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: isProductImage,
                  onChanged: (val) {
                    box.write('isProductImage', val);
                    isProductImage = box.read('isProductImage') ?? false;
                    setState(() {});
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
                 Text(AppLocalizations.of(context)!.productBarcode),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: isProductBarcode,
                  onChanged: (val) {
                    box.write('isProductBarcode', val);
                    isProductBarcode = box.read('isProductBarcode') ?? false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text("Remind payment due"),
          //       Switch(
          //         activeTrackColor: patowaveGreen400,
          //         activeColor: patowavePrimary,
          //         value: true,
          //         onChanged: (val) {},
          //       ),
          //     ],
          //   ),
          // ),
          // const Divider(height: 0),
        ],
      ),
    );
  }
}
