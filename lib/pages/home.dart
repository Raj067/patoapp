import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

class MainEntryHomePage extends StatelessWidget {
  const MainEntryHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cashflow',
          style: TextStyle(color: Colors.white),
        ),
        // bottom:_bottom(context),
      ),
      body: Column(
        children: [
          // _location(),
          _weatherHeader(),
          _headerDesign(context),
          const Center(
            child: Text("Cashflow"),
          ),
        ],
      ),
    );
  }

  // PreferredSizeWidget _bottom(BuildContext context) => PreferredSize(
  //       preferredSize: Size.fromHeight(48.0),
  //       child: Column(children: [
  //         _location(),
  //         _weatherHeader(),
  //         _headerDesign(context),
  //       ]),
  //     );

  _location() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        children: [
          const Icon(Icons.location_city),
          Container(width: 10),
          const Text("Dar es salaam")
        ],
      ),
    );
  }

  _weatherHeader() {
    return Container(
      color: patowavePrimary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Text("Today 27C"),
            Container(width: 10),
            Icon(Icons.web_asset_sharp),
          ]),
          Row(children: [
            Text("Tomorrow 27C"),
            Container(width: 10),
            Icon(Icons.web_asset_sharp),
          ]),
        ]),
      ),
    );
  }

  _headerDesign(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width,
      // color: Colors.yellow,
      child: Stack(
        children: [
          _upperRow(),
          _bottomRow(),
        ],
      ),
    );
  }

  _upperRow() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: patowavePrimary,
        height: 45,
        // width: 100,
      ),
    );
  }

  _bottomRow() {
    return Positioned(
      left: 8,
      right: 8,
      bottom: 0,
      top: 0,
      child: Card(
        elevation: 0,
        // color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                height: 75,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  color: patowavePrimary.withAlpha(50),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        SizedBox(height: 10),
                        Text(
                          "Transaction",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 75,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  color: patowavePrimary.withAlpha(50),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        SizedBox(height: 10),
                        Text(
                          "Payments",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                height: 75,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  color: patowavePrimary.withAlpha(50),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        SizedBox(height: 10),
                        Text(
                          "Inventory",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                height: 75,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  color: patowavePrimary.withAlpha(50),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        SizedBox(height: 10),
                        Text(
                          "Overview",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Container(
            //   height: 65,
            //   width: 60,
            //   child: const Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: Colors.lightGreen,
            //   ),
            // ),
            // Container(
            //   height: 65,
            //   width: 60,
            //   child: const Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: Colors.black,
            //   ),
            // ),
            // Container(
            //   height: 65,
            //   width: 60,
            //   child: const Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: Colors.blue,
            //   ),
            // ),
            // Container(
            //   height: 65,
            //   width: 60,
            //   child: const Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: Colors.orange,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
