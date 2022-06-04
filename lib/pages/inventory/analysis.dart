import 'package:flutter/material.dart';

class AnalysisHomePage extends StatelessWidget {
  const AnalysisHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          _singleCardData("2,000", "Instock", "6", "Inventory turnover"),
          _singleCardData("751", "Stock-In", "821", "Stock-out"),
          const Card(
            child: ListTile(
                title: const Text("Top Selling Items"),
                trailing: const Icon(Icons.filter)),
          )
        ],
      ),
    );
  }
}

Widget _SingleTopSellingProduct() => Row();

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
