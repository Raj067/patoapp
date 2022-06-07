import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class GeneralSettingsDialog extends StatelessWidget {
  const GeneralSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'General Settings',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: [
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.app_settings_alt,
                        color: Colors.black38,
                      ),
                      Container(
                        width: 10,
                      ),
                      const Text('Application'),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: Colors.black38,
                      ),
                      Container(
                        width: 10,
                      ),
                      const Text('Transactions'),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.supervised_user_circle_sharp,
                        color: Colors.black38,
                      ),
                      Container(
                        width: 10,
                      ),
                      const Text('User Management'),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.print,
                        color: Colors.black38,
                      ),
                      Container(
                        width: 10,
                      ),
                      const Text('Print'),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.grid_view_outlined,
                        color: Colors.black38,
                      ),
                      Container(
                        width: 10,
                      ),
                      const Text('Taxes'),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.settings_input_component_sharp,
                        color: Colors.black38,
                      ),
                      Container(
                        width: 10,
                      ),
                      const Text('Items'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
