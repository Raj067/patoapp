import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  bool _isSupplierActivated = false;
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item',
          style: TextStyle(color: Colors.white),
        ),
        // centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patoWhite,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _value = 1;
                    });
                  },
                  child: Row(
                    children: [
                      Radio(
                        activeColor: patoPrimaryColor,
                        value: 1,
                        groupValue: _value,
                        onChanged: (val) {
                          setState(() {
                            _value = 1;
                          });
                        },
                      ),
                      Container(
                        width: 5,
                      ),
                      const Text("Product"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _value = 2;
                    });
                  },
                  child: Row(
                    children: [
                      Radio(
                        activeColor: patoPrimaryColor,
                        value: 2,
                        groupValue: _value,
                        onChanged: (val) {
                          setState(() {
                            _value = 2;
                          });
                        },
                      ),
                      Container(
                        width: 5,
                      ),
                      const Text("Service"),
                      Container(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const Divider(height: 0),
          _value == 1 ? _addProduct() : _addService(),
        ],
      ),
    );
  }

  _addProduct() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            // _formField1(),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Item Name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Item Code"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Purchases Price"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            const Text("Pricing & Other Details"),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Sales Price (can)"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Sales Price (box)"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.question_mark_outlined),
                        label: Text("Quantity"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.question_mark_outlined),
                        label: Text("Stock Level"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Supplier Contact"),
              Switch(
                  activeColor: patoPrimaryColor,
                  value: _isSupplierActivated,
                  onChanged: (val) {
                    setState(() {
                      _isSupplierActivated = val;
                    });
                  })
            ]),

            _isSupplierActivated
                ? Column(
                    children: [
                      Container(height: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Name"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Phone Number"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(height: 10)
                    ],
                  )
                : Container(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Add Product",
                  style: TextStyle(color: patoWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addService() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            // _formField1(),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Service Name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Service Charge"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Service Unit"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Add Service",
                  style: TextStyle(color: patoWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
