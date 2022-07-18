import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/data/top_selling_products.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InventoryAnalysis extends StatefulWidget {
  const InventoryAnalysis({Key? key}) : super(key: key);

  @override
  State<InventoryAnalysis> createState() => _InventoryAnalysisState();
}

class _InventoryAnalysisState extends State<InventoryAnalysis> {
  InventAnalysisData inventoryAnalysisData = InventAnalysisData(
    instock: 0,
    stockout: 0,
    stockin: 0,
    inventoryTurnover: 0,
  );
  List<SingleTopProduct> allTopItems = [];
  bool isAlreadyLoad = false;

  fetchData() async {
    // Data for general analysis
    String accessToken = await storage.read(key: 'access') ?? "";
    var generalData = await http.get(
      Uri.parse("${baseUrl}api/general-inventory-analysis/"),
      headers: getAuthHeaders(accessToken),
    );
    if (generalData.statusCode == 200) {
      inventoryAnalysisData = InventAnalysisData(
        instock: jsonDecode(generalData.body)['instock'],
        stockout: jsonDecode(generalData.body)['stock_out'],
        stockin: jsonDecode(generalData.body)['stockin'],
        inventoryTurnover: jsonDecode(generalData.body)['inventory_turnover'],
      );
    }
    // Main top selling items data
    // Data for general analysis
    var data = await http.get(
      Uri.parse("${baseUrl}api/top-selling-items/"),
      headers: getAuthHeaders(accessToken),
    );
    if (data.statusCode == 200) {
      List<SingleTopProduct> myAllTopItems = [];
      // print(jsonDecode(data.body));
      for (var element in jsonDecode(data.body)) {
        myAllTopItems.add(SingleTopProduct(
          productName: element['product_name'],
          thumbnail: element['thumbnail'] ?? "",
          isOutStock: element['is_out_stock'],
          totalItemsSold: element['total_items_sold'],
          margin: element['margin'],
          unit: element['unit'],
          quantity: element['quantity'],
        ));
      }
      allTopItems = myAllTopItems;
      isAlreadyLoad = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Analysis',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Container(height: 10),
            _singleCardData(
              inventoryAnalysisData.instock,
              "Instock",
              inventoryAnalysisData.inventoryTurnover,
              "Inventory Turnover",
            ),
            _singleCardData(
              inventoryAnalysisData.stockin,
              "Stock-In",
              inventoryAnalysisData.stockout,
              "Stock-out",
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Top Selling Items'),
                    SvgPicture.asset("assets/svg/genericSortingDesc.svg",
                        width: 25, height: 25),
                  ],
                ),
              ),
            ),
            isAlreadyLoad
                ? _allTopSellingProduct(context)
                : const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _allTopSellingProduct(BuildContext context) {
    List<Widget> data = [];
    for (var element in allTopItems) {
      data.add(_singleTopSellingProduct(context, element));
    }

    return Column(
      children: data,
    );
  }

  _singleCardData(int nameData, String figure, int nameData1, String figure1) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$nameData",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(figure),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$nameData1",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(figure1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _singleTopSellingProduct(BuildContext context, SingleTopProduct product) =>
      Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        elevation: 0,
        child: InkWell(
          // onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                product.thumbnail == ""
                    ? Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // child: Image.asset("assets/img.jpg", fit: BoxFit.fill),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          // color: Theme.of(context).scaffoldBackgroundColor,

                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                                "$imageBaseUrl${product.thumbnail}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Image.asset("assets/img.jpg", fit: BoxFit.fill),
                      ),
                Container(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.productName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${product.totalItemsSold} ${product.unit}"),
                          ]),
                      Container(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Qyt: ${product.quantity}",
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Text("${product.margin} margin"),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
