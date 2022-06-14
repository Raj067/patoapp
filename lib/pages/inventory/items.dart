import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/data/productList.dart';
import 'package:patoapp/pages/products/cartProducts.dart';
import 'package:patoapp/subpages/addProduct.dart';
import 'package:patoapp/subpages/singleProductDetails.dart';

// import '../products/adjustProduct.dart';
// import 'package:http/http.dart' as http;

class ItemsHomePage extends StatefulWidget {
  const ItemsHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemsHomePage> createState() => _ItemsHomePageState();
}

class _ItemsHomePageState extends State<ItemsHomePage> {
  List<SingleProduct> customData = [];
  int allAddedProduct = 0;
  int allAddedProductPrice = 0;

  fetchData() async {
    customData = allProductDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          _itemSearchBar(context),
          _itemAllDataFiltered(),
          allAddedProduct != 0
              ? Card(
                  color: patoPrimaryColor,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ProductsCart(
                            products: customData,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: $allAddedProduct',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Tsh. $allAddedProductPrice",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                width: 10,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(),
        ],
      ),
    );
  }

  Widget _itemSearchBar(BuildContext context) => Row(
        children: [
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
                      builder: (BuildContext context) => const AddProductPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );

  Widget _itemAllDataFiltered() {
    List<Widget> data = [];
    for (var element in customData) {
      data.add(_singleProductTile(context, element));
    }
    return customData == []
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          )
        : Expanded(
            child: ListView(
              children: data,
            ),
          );
  }

  Widget _singleProductTile(BuildContext context, SingleProduct product) {
    return Card(
      child: Dismissible(
        key: Key(product.id),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            _addDataToCartManual(context, product);
          } else {
            productAdjustment(context, product);
          }
          // if (direction == DismissDirection.startToEnd) {
          //   setState(() {
          //     flavors[index] = flavor.copyWith(isFavorite: !flavor.isFavorite);
          //   },);
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
        child: InkWell(
          onTap: () {
            // _addDataToCartAutomatic(context, product);
            setState(() {
              product.addedToCart;
              product.isAddedToCartAutomatic == true
                  ? product.addedToCart > 0
                      ? product.isAddedToCartAutomatic == true
                      : product.isAddedToCartAutomatic = false
                  // ? product.isAddedToCartAutomatic = false
                  : product.isAddedToCartAutomatic = true;
            });
          },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Tsh ${product.productPrice}',
                                style: const TextStyle(
                                    fontSize: 12, color: patoGrey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Qty: ${product.quantity}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: product.isOutStock
                                      ? patoWarning
                                      : product.quantity == 0
                                          ? patoRed
                                          : patoGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      product.isAddedToCartAutomatic
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      product.addNewProductToCart(-1);
                                      _onCartChange(product);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.do_disturb_on_outlined,
                                    color: patoPrimaryColor,
                                  ),
                                ),
                                Container(width: 8),
                                Text(
                                  "${product.addedToCart}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(width: 8),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      product.addNewProductToCart(1);
                                      _onCartChange(product);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: patoPrimaryColor,
                                  ),
                                ),
                              ],
                            )
                          : const CircleAvatar(
                              backgroundColor: patoLightGreen,
                              foregroundColor: patoBlack,
                              child: Icon(Icons.add_shopping_cart_rounded),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addDataToCartManual(
      BuildContext context, SingleProduct product) async {
    TextEditingController controller = TextEditingController(text: "1");

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          backgroundColor: patoBackgroundColor,
          title: const Text('Add to cart'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image.network(product.thumbnail,
                      //     width: 50, height: 50, fit: BoxFit.fill),
                      // Container(
                      //   width: 10,
                      // ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Tsh ${product.productPrice}',
                                      style: const TextStyle(
                                          fontSize: 16, color: patoGrey),
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
                                                : patoGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Qty:"),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        // ignore: unnecessary_const
                        child: TextField(
                          // ignore: unnecessary_const
                          textAlign: TextAlign.start,
                          controller: controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsetsDirectional.all(10),
                            border: InputBorder.none,
                            // hintText: 'Quantity',
                            prefixIcon: Icon(
                              Icons.add,
                              size: 16,
                            ),
                            enabledBorder: InputBorder.none,
                            // helperText: "Quantity",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // int? val = int.tryParse(controller.text);
                  product.addNewProductToCart(20);
                  _onCartChange(product);
                });
                Navigator.pop(context);
              },
              child: const Text(
                "Add",
                style: TextStyle(color: patoWhite),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> productAdjustment(
      BuildContext context, SingleProduct product) async {
    TextEditingController controller = TextEditingController(text: "1");
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          backgroundColor: patoBackgroundColor,
          title: const Text('Adjust Item'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image.network(product.thumbnail,
                      //     width: 50, height: 50, fit: BoxFit.fill),
                      // Container(
                      //   width: 10,
                      // ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Tsh ${product.productPrice}',
                                      style: const TextStyle(
                                          fontSize: 16, color: patoGrey),
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
                                                : patoGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Qty:"),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        // ignore: unnecessary_const
                        child: TextField(
                          // ignore: unnecessary_const
                          textAlign: TextAlign.start,
                          controller: controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsetsDirectional.all(10),
                            border: InputBorder.none,
                            // hintText: 'Quantity',
                            prefixIcon: Icon(
                              Icons.add,
                              size: 16,
                            ),
                            enabledBorder: InputBorder.none,
                            // helperText: "Quantity",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  product.adjustProductQuantity(10);
                });
                Navigator.pop(context);
              },
              child: const Text(
                "Add",
                style: TextStyle(color: patoWhite),
              ),
            )
          ],
        );
      },
    );
  }

  // _onItemSearch(name, query) {
  //   return name!.toLowerCase().contains(query.toLowerCase());
  // }

  // customData = customData.where((i) => _onItemSearch(i.productName, pName) == true).toList();
  _onCartChange(SingleProduct pName) {
    List<SingleProduct> newData = [
      pName,
    ];
    int val = 0;
    int price = 0;
    for (var element in customData) {
      val += element.addedToCart;
      price += element.getTotalPrice();
      if (element != pName) {
        newData.add(element);
      }
    }
    allAddedProductPrice = price;
    customData = newData;
    allAddedProduct = val;
  }
}
