import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/productList.dart';
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
  final TextEditingController _item_input_controller =
      TextEditingController(text: "Initial value here");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _itemSearchBar(),
          const Expanded(child: ItemAllDataFiltered()),
        ],
      ),
    );
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

Widget _homeListTileData(BuildContext context, SingleProduct product) =>
    Container(
      // height: 300,
      child: Card(
        child: ListTile(
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SingleProductDetails(
                  product: product,
                ),
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
            product.thumbnail,
            fit: BoxFit.fitWidth,
          ),
          title: Text(product.productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
          subtitle: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              'Tsh ${product.productPrice}',
              style: const TextStyle(fontSize: 16, color: patoGrey),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Qty: ${product.quantity}',
              style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: product.isOutStock
                      ? patoWarning
                      : product.quantity == 0
                          ? patoRed
                          : patoGrey),
            ),
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
    List<Widget> data = [];
    for (var element in allProductDetails()) {
      data.add(_homeListTileData(context, element));
    }

    return ListView(
      children: data,
    );
  }
}

class ActionButtonsSearch extends StatelessWidget {
  const ActionButtonsSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IconButton(
        icon: const Icon(Icons.add),
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
