import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/api/constants.dart';
import 'package:patoapp/backend/controllers/products_controller.dart';
// import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/backend/sync/sync_all.dart';
// import 'package:patoapp/backend/sync/sync_products.dart';
import 'package:patoapp/products/add_product.dart';
import 'package:patoapp/products/cart_products.dart';
import 'package:patoapp/products/single_product_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patoapp/themes/light_theme.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.productService,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            syncAllImportantData();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patowaveWhite,
          ),
        ),
      ),
      body: const InventoryHomePage(),
    );
  }
}

class InventoryHomePage extends StatefulWidget {
  const InventoryHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<InventoryHomePage> createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  bool isProductFound = true;
  int itemsMatchedInSearch = 0;
  TextEditingController searchController = TextEditingController();

  final ProductController _productController = Get.put(ProductController());

  // For Preferences
  bool isProductImage = box.read('isProductImage') ?? false;
  bool isProductBarcode = box.read('isProductBarcode') ?? false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: GetBuilder<ProductController>(builder: (controller) {
        List<Widget> data = [];
        for (var element in controller.allProducts) {
          data.add(_singleProductTile(context, element));
          data.add(Container(height: 10));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 5),
            _itemSearchBar(context),
            Container(height: 5),
            searchController.text != ''
                ? isProductFound
                    ? Row(
                        children: [
                          Text(
                            " * $itemsMatchedInSearch",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            " Items match your search ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            searchController.text,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          const Text(
                            " * No item match your search ",
                            style: TextStyle(
                                fontSize: 12, color: patowaveErrorRed),
                          ),
                          Text(
                            searchController.text.length < 15
                                ? searchController.text
                                : searchController.text
                                    .replaceRange(15, null, "..."),
                            style: const TextStyle(
                                fontSize: 12,
                                color: patowaveErrorRed,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                : Container(),
            Expanded(
              child: ListView(
                children: data,
              ),
            ),
            controller.allAddedProduct.value != 0
                ? Dismissible(
                    key: const Key('removeData'),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        _onResetAllData();
                      } else {
                        _onResetAllData();
                      }
                      return true;
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      elevation: 0,
                      color: patowavePrimary,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ProductsCart(
                                products: controller.allProducts,
                                resetData: _onResetAllData,
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.totalItems}: ${_productController.addedItemsToCart.value}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tsh. ${formatter.format(controller.allAddedProductPrice.value)}",
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
                    ),
                  )
                : const Center(),
          ],
        );
      }),
    );
  }

  Widget _itemSearchBar(BuildContext context) => Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              height: 45,
              child: TextFormField(
                controller: searchController,
                cursorColor: patowavePrimary,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.searchItem,
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  alignLabelWithHint: true,
                ),
                onChanged: (val) {
                  _onSearchChange(val);
                },
              ),
            ),
          ),
          Container(width: 5),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            height: 45,
            width: 45,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AddProductPage(
                      isProductImage: isProductImage,
                      isProductBarcode: isProductBarcode,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      );

  bool _stringLinearSearch({required String child, required String parent}) =>
      parent.toLowerCase().contains(child.toLowerCase());

  _onSearchChange(String val) {
    List<SingleProduct> newFilteredeData = [];
    List<SingleProduct> newUnFilteredeData = [];
    for (var element in _productController.allProducts) {
      if (_stringLinearSearch(child: val, parent: element.productName)) {
        newFilteredeData.add(element);
      } else {
        newUnFilteredeData.add(element);
      }
    }
    _productController.allProducts.value = [
      ...newFilteredeData,
      ...newUnFilteredeData
    ];
    itemsMatchedInSearch = newFilteredeData.length;
    if (newFilteredeData.isNotEmpty) {
      isProductFound = true;
    } else {
      isProductFound = false;
    }
    setState(() {});
  }

  Widget _singleProductTile(BuildContext context, SingleProduct product) {
    return Dismissible(
      key: Key("${product.id}"),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _addDataToCartManual(context, product);
        } else {
          _onResetSingleData(product);
          // productAdjustment(context, product);
        }
        return false;
      },
      background: Container(
        decoration: BoxDecoration(
          color: patowavePrimary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.add_shopping_cart_rounded,
              color: patowaveWhite,
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: patowaveErrorRed,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.clear,
              color: patowaveWhite,
            ),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
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
                  isProductImage: isProductImage,
                  isProductBarcode: isProductBarcode,
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
                isProductImage
                    ? product.thumbnail == ""
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
                                image: CachedNetworkImageProvider(
                                  product.thumbnail,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            // child: Image.asset("assets/img.jpg", fit: BoxFit.fill),
                          )
                    : Container(height: 50),
                Container(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              overflow: TextOverflow.fade,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Tsh ${formatter.format(product.sellingPrice)}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${AppLocalizations.of(context)!.qty}: ${product.quantity}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: product.quantity <= 0
                                        ? patowaveErrorRed
                                        : product.isStockLevelReached()
                                            ? patowaveWarning
                                            : patowavePrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      product.isAddedToCartAutomatic
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (!product.isZeroWarning()) {
                                        product.addNewProductToCart(-1);
                                        _onCartChange(product);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.do_disturb_on_outlined,
                                    size: 30,
                                    color: product.isZeroWarning()
                                        ? patowaveErrorRed
                                        : patowavePrimary,
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
                                      if (!product.isMaxProductWarning()) {
                                        product.addNewProductToCart(1);
                                        _onCartChange(product);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.add_circle_outline_sharp,
                                    size: 30,
                                    color: product.isMaxProductWarning()
                                        ? patowaveErrorRed
                                        : patowavePrimary,
                                  ),
                                ),
                              ],
                            )
                          : const CircleAvatar(
                              backgroundColor: patowavePrimary,
                              foregroundColor: patowaveWhite,
                              child: Icon(
                                Icons.add_shopping_cart_rounded,
                              ),
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          elevation: 0,
          scrollable: true,
          contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          // backgroundColor: patoBackgroundColor,
          title: Text(AppLocalizations.of(context)!.addToCart),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        'Tsh ${formatter.format(product.sellingPrice)}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${AppLocalizations.of(context)!.qty}: ${product.quantity}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                          color: product.quantity <= 0
                                              ? patowaveErrorRed
                                              : product.isStockLevelReached()
                                                  ? patowaveWarning
                                                  : patowavePrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                  // const Text("Qty:"),
                  Expanded(
                    child: SizedBox(
                      // height: 45,
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsetsDirectional.all(10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          helperText:
                              "*${AppLocalizations.of(context)!.maximumQuantity} ${product.availableQuantity()}",
                          helperStyle: TextStyle(
                              color: product
                                      .compareToCart(int.parse(controller.text))
                                  ? patowaveErrorRed
                                  : patowavePrimary),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                            child:
                                Text("${AppLocalizations.of(context)!.qty}:"),
                          ),
                          suffixIcon: const Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 16,
                          ),
                          // helperText: "Quantity",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(45, 45),
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ),
              Container(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(45, 45),
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      var val = int.parse(controller.text);
                      if (!product.compareToCart(val)) {
                        product.addNewProductToCart(val);
                        product.isAddedToCartAutomatic = true;
                        _onCartChange(product);
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.add,
                    style: const TextStyle(color: patowaveWhite),
                  ),
                ),
              )
            ])
          ],
        );
      },
    );
  }

  _onCartChange(SingleProduct pName) {
    List<SingleProduct> newAddedData = [];
    List<SingleProduct> newUnAddedData = [];
    int val = 0;
    int addedItems = 0;
    int price = 0;
    for (var element in _productController.allProducts) {
      element.addedToCart > 0 ? addedItems += 1 : addedItems;
      val += element.addedToCart;
      price += element.getTotalPrice();
      if (element != pName) {
        // newData.add(element);
        if (element.isAddedToCartAutomatic) {
          newAddedData.add(element);
        } else {
          newUnAddedData.add(element);
        }
      }
    }
    _productController.allAddedProductPrice.value = price;
    _productController.allProducts.value = [
      pName,
      ...newAddedData,
      ...newUnAddedData
    ];
    _productController.allAddedProduct.value = val;
    _productController.addedItemsToCart.value = addedItems;
    setState(() {});
  }

  _onResetAllData() {
    List<SingleProduct> newData = [];
    for (var element in _productController.allProducts) {
      element.addedToCart = 0;
      element.isAddedToCartAutomatic = false;
      newData.add(element);
    }

    _productController.allProducts.value = newData;
    _productController.allAddedProduct.value = 0;
    _productController.allAddedProductPrice.value = 0;
    setState(() {});
  }

  _onResetSingleData(SingleProduct product) {
    product.addedToCart = 0;
    product.isAddedToCartAutomatic = false;
    List<SingleProduct> newData = [];
    int val = 0;
    int addedItems = 0;
    int price = 0;
    for (var element in _productController.allProducts) {
      element.addedToCart > 0 ? addedItems += 1 : addedItems;
      val += element.addedToCart;
      price += element.getTotalPrice();
      newData.add(element);
    }
    _productController.allAddedProductPrice.value = price;
    _productController.allProducts.value = newData;
    _productController.allAddedProduct.value = val;
    _productController.addedItemsToCart.value = addedItems;
    setState(() {});
  }
}
