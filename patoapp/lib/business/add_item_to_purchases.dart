import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';

class AddItemsToPurchases extends StatefulWidget {
  const AddItemsToPurchases({Key? key}) : super(key: key);

  @override
  State<AddItemsToPurchases> createState() => _AddItemsToPurchasesState();
}

class _AddItemsToPurchasesState extends State<AddItemsToPurchases> {
  final List<String> primaryUnits = [
    'BAGS (Bags)',
    'BOTTLES (Btl)',
    'BOX (Box)',
    'BUNDLES (Bdl)',
    'CANS (Can)',
    'CARTONS (Ctn)',
    'DOZENS (Dzn)',
    'GRAMMES (gm)',
    'KILOGRAMS (Kg)',
    'LITRE (Ltr)',
    'METERS (Mtr)',
    'MILILITRE (Ml)',
    'NUMBERS (Nos)',
    'PACKS (Pac)',
    'PAIRS (Prs)',
    'PIECES (Pcs)',
  ];

  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];

  String? selectedValue;
  String selectedPrimaryUnit = 'BOX (Box)';
  final TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item to Purchases',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Container(height: 10),
            SizedBox(
              height: 45,
              child: DropdownButtonFormField2(
                  value: selectedValue,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    label: const Text(
                      'Select Item',
                      style: TextStyle(fontSize: 14),
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
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
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
            ),
            Container(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text(
                          "Quantity",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: DropdownButtonFormField2(
                      value: selectedPrimaryUnit,
                      selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                      scrollbarAlwaysShow: true,
                      dropdownMaxHeight: 200,
                      decoration: InputDecoration(
                        label: const Text(
                          'Unit',
                          style: TextStyle(fontSize: 14),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                      items: primaryUnits
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
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
                  Navigator.pop(context);
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
