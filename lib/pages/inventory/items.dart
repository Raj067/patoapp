import 'dart:ui';

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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          _itemSearchBar(context),
          const Expanded(child: ItemAllDataFiltered()),
        ],
      ),
    );
  }
}

Widget _homeListTileData(BuildContext context, SingleProduct product) {
  return Card(
    child: Dismissible(
      key: Key(product.id),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _addDataToCartManual(context, product);
        } else {
          _productAdjustment(context, product);
        }
        // if (direction == DismissDirection.startToEnd) {
        //   setState(() {
        //     flavors[index] = flavor.copyWith(isFavorite: !flavor.isFavorite);
        //   });
        //   return false;
        // }
        return false;
      },
      background: Container(
        color: patoPrimaryColor,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.add_shopping_cart_rounded,
              color: patoWhite,
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: patoRed,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.edit,
              color: patoWhite,
            ),
          ),
        ),
      ),
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
          _addDataToCartAutomatic(context, product);
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
}

Future<void> _addDataToCartAutomatic(
    BuildContext context, SingleProduct product) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: patoBackgroundColor,
          title: const Text('Add to cart'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  leading: Image.network(
                    product.thumbnail,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                ),
              ),
              Container(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Qty:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: patoPrimaryColor,
                        onPressed: () {},
                        splashRadius: 25,
                        icon: const Icon(Icons.do_disturb_on_outlined),
                      ),
                      Container(
                          width: 50,
                          height: 25,
                          alignment: AlignmentDirectional.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(width: 1, color: patoGrey),
                                left: BorderSide(width: 1, color: patoGrey),
                                right: BorderSide(width: 1, color: patoGrey),
                                bottom: BorderSide(width: 1, color: patoGrey)),
                          ),
                          child: const Text("12")),
                      IconButton(
                        color: patoPrimaryColor,
                        splashRadius: 25,
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_outline_sharp),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () {},
                child: const Text("Add", style: TextStyle(color: patoWhite)))
          ],
        );
      });
}

Future<void> _addDataToCartManual(
    BuildContext context, SingleProduct product) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: patoBackgroundColor,
          title: const Text('Add to cart'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  leading: Image.network(
                    product.thumbnail,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                ),
              ),
              Container(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Qty:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: patoPrimaryColor,
                        onPressed: () {},
                        splashRadius: 25,
                        icon: const Icon(Icons.do_disturb_on_outlined),
                      ),
                      Container(
                          width: 50,
                          height: 25,
                          alignment: AlignmentDirectional.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(width: 1, color: patoGrey),
                                left: BorderSide(width: 1, color: patoGrey),
                                right: BorderSide(width: 1, color: patoGrey),
                                bottom: BorderSide(width: 1, color: patoGrey)),
                          ),
                          child: const Text("12")),
                      IconButton(
                        color: patoPrimaryColor,
                        splashRadius: 25,
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_outline_sharp),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () {},
                child: const Text("Add", style: TextStyle(color: patoWhite)))
          ],
        );
      });
}

Future<void> _productAdjustment(
    BuildContext context, SingleProduct product) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: patoBackgroundColor,
          title: const Text('Adjust Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  leading: Image.network(
                    product.thumbnail,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                ),
              ),
              Container(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Qty:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: patoPrimaryColor,
                        onPressed: () {},
                        splashRadius: 25,
                        icon: const Icon(Icons.do_disturb_on_outlined),
                      ),
                      Container(
                          width: 50,
                          height: 25,
                          alignment: AlignmentDirectional.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(width: 1, color: patoGrey),
                                left: BorderSide(width: 1, color: patoGrey),
                                right: BorderSide(width: 1, color: patoGrey),
                                bottom: BorderSide(width: 1, color: patoGrey)),
                          ),
                          child: const Text("12")),
                      IconButton(
                        color: patoPrimaryColor,
                        splashRadius: 25,
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_outline_sharp),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () {},
                child: const Text("Add", style: TextStyle(color: patoWhite)))
          ],
        );
      });
}

Widget _itemSearchBar(BuildContext context) => Row(children: [
      const Expanded(
        child: SizedBox(
          height: 50,
          child: Card(
            // ignore: unnecessary_const
            child: TextField(
              selectionHeightStyle: BoxHeightStyle.strut,
              // ignore: unnecessary_const
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search item',
                prefixIcon: Icon(Icons.search),
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 50,
        child: Card(
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
        ),
      ),
    ]);

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

// class ActionButtonsSearch extends StatelessWidget {
//   const ActionButtonsSearch({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: IconButton(
//         icon: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) => AddProductPage(),
//               fullscreenDialog: true,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
