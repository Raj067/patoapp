import 'package:flutter/material.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;
}

class UserManagement extends StatelessWidget {
  UserManagement({Key? key}) : super(key: key);
// Instantiate your class using Get.put() to make it available for all "child" routes there.
  final Controller c = Get.put(Controller());
  final CustomerController customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.userManagement,
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
      body: Column(
        children: [
          // CustomerController
          Obx(() => Text("Clicks: ${customerController.allCustomers.length}")),
          Obx(() => Text("Clicks: ${c.count.value}")),
          Text("Clicks: ${c.count.value}"),
          ElevatedButton(
              onPressed: () {
                // customerController.fetchCustomersDB( );
              },
              child: Text('Add customer')),
          const Center(
            child: Text(
              'Coming Soon',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment),
    );
  }
}
