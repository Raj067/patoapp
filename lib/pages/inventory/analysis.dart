import 'package:flutter/material.dart';

class AnalysisHomePage extends StatelessWidget {
  const AnalysisHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _analysisData(),
        ],
      ),
    );
  }
}

Widget _singleCardData() => Container(
      height: 100,
      // width: 100,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text("Hello")],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text("World 1")],
            ),
          ],
        ),
      ),
    );

// Widget _analysisData() => Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _singleCardData(),
//         _singleCardData(),
//       ],
//     );
Widget _analysisData() => Row(
      children: [
        Expanded(
          child: Container(
              height: 100,
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.home_filled),
                  Text("Hello"),
                ],
              ))),
        ),
        Expanded(
          child: Container(height: 100, child: Card()),
        ),
      ],
    );
