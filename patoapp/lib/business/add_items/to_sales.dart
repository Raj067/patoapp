import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/themes/light_theme.dart';

class AddItemsToSale extends StatefulWidget {
  final List<SingleProduct> allProducts;
  final List<SingleProduct> addedItemsToSales;
  final Function addItems;
  const AddItemsToSale({
    Key? key,
    required this.allProducts,
    required this.addedItemsToSales,
    required this.addItems,
  }) : super(key: key);

  @override
  State<AddItemsToSale> createState() => _AddItemsToSaleState();
}

class _AddItemsToSaleState extends State<AddItemsToSale> {
  final addItemToSalesFormKey = GlobalKey<FormState>();
  String? selectedValue;
  String? selectedProductValueSales;
  final TextEditingController quantityControllerSales = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  SingleProduct? selectedProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item to sale',
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
      body: Form(
        key: addItemToSalesFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 15),
            DropdownButtonFormField2(
                // value: selectedProductValueSales,
                selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                scrollbarAlwaysShow: true,
                dropdownMaxHeight: 200,
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Please select item';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                ),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: widget.allProducts
                    .map((item) => DropdownMenuItem<String>(
                          value: "${item.id}",
                          child: Text(
                            item.productName,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  //Do something when changing the item if you want.
                  setState(() {
                    selectedProductValueSales = value.toString();
                    selectedProduct = widget.allProducts.firstWhere(
                        (element) => element.id == int.parse(value.toString()));
                  });
                },
                onSaved: (value) {
                  selectedProductValueSales = value.toString();
                },
                searchController: textEditingController,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    cursorColor: patowavePrimary,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an item...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return (item.value.toString().contains(searchValue));
                },
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                }),
            Container(height: 15),
            TextFormField(
              controller: quantityControllerSales,
              cursorColor: patowavePrimary,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Quantity is required';
                }
                if (int.parse(value) > selectedProduct!.quantity) {
                  return 'Quantity available is ${selectedProduct!.quantity}';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text(
                  "Quantity*",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Container(height: 15),
            Container(
              decoration: BoxDecoration(
                color: patowaveBlack.withAlpha(30),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Text(
                  selectedProduct == null
                      ? 'Items'
                      : selectedProduct!.productUnit,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
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
                  if (addItemToSalesFormKey.currentState!.validate()) {
                    for (SingleProduct dx in widget.allProducts) {
                      if ("${dx.id}" == selectedProductValueSales &&
                          !widget.addedItemsToSales
                              .map((e) => e.id)
                              .contains(dx.id)) {
                        widget.addItems(
                          SingleProduct(
                            shopId: 0,
                            isService: false,
                            quantity: int.parse(quantityControllerSales.text),
                            productUnit: dx.productUnit,
                            productName: dx.productName,
                            id: dx.id,
                            sellingPrice: dx.sellingPrice,
                            purchasesPrice: dx.purchasesPrice,
                          ),
                        );
                      }
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add Item",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
