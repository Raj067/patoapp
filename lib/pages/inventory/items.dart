import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/subpages/addProduct.dart';
import 'package:patoapp/subpages/singleProductDetails.dart';
// import 'package:http/http.dart' as http;

class ItemsHomePage extends StatefulWidget {
  const ItemsHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemsHomePage> createState() => _ItemsHomePageState();
}

class _ItemsHomePageState extends State<ItemsHomePage> {
  TextEditingController _item_input_controller =
      TextEditingController(text: "Initial value here");
  @override
  Widget build(BuildContext context) {
    return ItemAllDataFiltered();
  }
}

// Widget _homeIconBtn(BuildContext context) => Material(
//       color: patoWhite,
//       child: Ink(
//         decoration: const ShapeDecoration(
//           color: patoPrimaryColor,
//           shape: CircleBorder(),
//         ),
//         child: IconButton(
//           icon: const Icon(Icons.add_shopping_cart_rounded),
//           color: patoWhite,
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: const Text('Awesome Snackbar!'),
//                 action: SnackBarAction(
//                   label: 'Action',
//                   onPressed: () {
//                     // Code to execute.
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );

Widget _homeListTileData(String title, String subtitle, BuildContext context) =>
    Container(
      // height: 300,
      child: Card(
        child: ListTile(
          dense: false,
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SingleProductDetails(),
                fullscreenDialog: true,
              ),
            );
          },
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Total Items: 100'),
                duration: const Duration(minutes: 1),
                backgroundColor: patoPrimaryColor,
                action: SnackBarAction(
                  textColor: patoWhite,
                  label: 'Tshs 2,500',
                  onPressed: () {
                    // Code to execute.
                  },
                ),
              ),
            );
          },
          leading: Image.network(
            "https://cdn.pixabay.com/photo/2016/03/18/01/09/cupcake-1264214_960_720.png",
            fit: BoxFit.fitWidth,
          ),
          title: const Text('Cocacora zero',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
          subtitle:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            Text('Tsh 2,500', style: TextStyle(fontSize: 16, color: patoGrey)),
            SizedBox(
              width: 10,
            ),
            Text('Qty: 1000',
                style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: patoGrey)),
          ]),
          trailing: const CircleAvatar(
            backgroundColor: patoLightGreen,
            foregroundColor: patoBlack,
            child: Icon(Icons.add_shopping_cart_rounded),
          ),
          isThreeLine: true,
        ),
      ),
    );

Widget _itemSearchBar() => const ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Card(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search item',
            prefixIcon: Icon(Icons.search),
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
      trailing: ActionButtonsSearch(),
    );

class ItemAllDataFiltered extends StatelessWidget {
  const ItemAllDataFiltered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          _itemSearchBar(),
          _homeListTileData("title", "subtitle", context),
          _homeListTileData("title", "subtitle", context),
          _homeListTileData("title", "subtitle", context),
        ],
      ),
    );
  }
}

class ActionButtonsSearch extends StatelessWidget {
  const ActionButtonsSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddProductPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
    );
  }
}
