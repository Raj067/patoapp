import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product',
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
        child: Text("Product Page"),
      ),
      persistentFooterButtons: [
        TextButton(
          child: const Text("Add Product"),
          onPressed: () {},
        ),
      ],
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: ElevatedButton(
      //     child: const Text(
      //       "Add Product",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     onPressed: () {},
      //   ),
      // ),
    );
  }
}
