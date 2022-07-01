import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/data/top_selling_products.dart';
import 'package:patoapp/themes/light_theme.dart';

class InventoryAnalysis extends StatelessWidget {
  const InventoryAnalysis({Key? key}) : super(key: key);
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
            _singleCardData(inventoryAnalysisData.instock, "Instock",
                inventoryAnalysisData.inventoryTurnover, "Inventory Turnover"),
            _singleCardData(inventoryAnalysisData.stockin, "Stock-In",
                inventoryAnalysisData.stockout, "Stock-out"),
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
            _allTopSellingProduct(context),
          ],
        ),
      ),
    );
  }

  _allTopSellingProduct(BuildContext context) {
    List<Widget> data = [];
    for (var element in topSellingItemsDetails()) {
      data.add(_singleTopSellingProduct(context, element));
    }

    return Column(
      children: data,
    );
  }

  _singleCardData(
      String nameData, String figure, String nameData1, String figure1) {
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
                    nameData,
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
                    nameData1,
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage("assets/img.jpg"),
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
                            Text("${product.totalItemsSold} products"),
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
