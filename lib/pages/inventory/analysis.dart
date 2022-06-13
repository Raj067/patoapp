import 'package:flutter/material.dart';
import 'package:patoapp/data/topSellingProducts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnalysisHomePage extends StatelessWidget {
  const AnalysisHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: ListView(
        children: [
          _singleCardData("2,000", "Instock", "6", "Inventory turnover"),
          _singleCardData("751", "Stock-In", "821", "Stock-out"),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Top Selling Items'),
                  SvgPicture.asset("svg/genericSortingDesc.svg",
                      width: 25, height: 25),
                ],
              ),
            ),
          ),
          const AllTopSellingItems(),
        ],
      ),
    );
  }
}

class AllTopSellingItems extends StatelessWidget {
  const AllTopSellingItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];
    for (var element in topSellingItemsDetails()) {
      data.add(_singleTopSellingProduct(context, element));
    }

    return Column(
      children: data,
    );
  }
}

Widget _singleTopSellingProduct(
        BuildContext context, SingleTopProduct product) =>
    Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image.network(product.thumbnail,
              //     width: 50, height: 50, fit: BoxFit.fill),
              Image.asset("assets/img.jpg",
                  width: 50, height: 50, fit: BoxFit.fill),
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                            style: const TextStyle(fontStyle: FontStyle.italic),
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

Widget _singleCardData(
        String nameData, String figure, String nameData1, String figure1) =>
    Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
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
