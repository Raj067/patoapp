import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/themes/light_theme.dart';

class InventorySummary extends StatefulWidget {
  const InventorySummary({Key? key}) : super(key: key);

  @override
  State<InventorySummary> createState() => _InventorySummaryState();
}

class _InventorySummaryState extends State<InventorySummary> {
  double totalAmount = 0;
  List<SingleProduct> customData = [];

  fetchProductsDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> products = await DBHelperProduct.query();
    List<SingleProduct> finalData = [];
    for (Map<String, dynamic> e in products) {
      if (e['shopId'] == shopId) {
        finalData.add(fromJsonProduct(e));
      }
    }
    customData = finalData;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchProductsDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Summary',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                color: patowavePrimary.withAlpha(100),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Name"),
                    Text("Quantity "),
                    Text("Value"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                // shape: const RoundedRectangleBorder(
                //   borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(15),
                //     bottomRight: Radius.circular(15),
                //   ),
                // ),
                child: ListView(
                  children: _allInventoryData(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Container(
              decoration: BoxDecoration(
                color: patowavePrimary.withAlpha(100),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Value"),
                    Text("Tsh ${formatter.format(totalAmount)}"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleInventoryData(SingleProduct data) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(data.productName)),
          Expanded(
            child: Text(
              "${data.quantity}",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              "Tsh ${formatter.format((data.quantity * data.purchasesPrice).toInt())}",
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _allInventoryData() {
    List<Widget> data = [];
    double val = 0;
    for (var element in customData) {
      val += element.quantity * element.purchasesPrice;
      data.add(_singleInventoryData(element));
      data.add(const Divider(height: 0));
    }
    totalAmount = val;
    return data;
  }
}
