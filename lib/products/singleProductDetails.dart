import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/data/productList.dart';
import 'package:patoapp/products/editProduct.dart';
import 'package:patoapp/themes/lightTheme.dart';
// import 'package:url_launcher/url_launcher.dart';

class SingleProductDetails extends StatefulWidget {
  const SingleProductDetails({super.key, required this.product});
  final SingleProduct product;

  @override
  State<SingleProductDetails> createState() => _SingleProductDetailsState();
}

class _SingleProductDetailsState extends State<SingleProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patowaveWhite,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const EditProduct(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: patowaveWhite,
            ),
          ),
          IconButton(
            onPressed: () {
              _productDelete(context, widget.product);
            },
            icon: const Icon(
              Icons.delete,
              color: patowaveErrorRed,
            ),
          ),
          Container(width: 10),
        ],
      ),
      body: ListView(
        children: [
          Column(children: [
            SizedBox(
              // height: 200,
              // child: Image.network(
              //   product.thumbnail,
              //   fit: BoxFit.fitWidth,
              // ),
              child: Image.asset("assets/img.jpg", fit: BoxFit.fitWidth),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                // const Text('Transactions'),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Selling Price'),
                Text("${widget.product.sellingPrice}"),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Purchases Price'),
                Text("${widget.product.purchasesPrice}"),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Items sold'),
                Text("${widget.product.totalItemsSold}"),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Supplier Contacts:"),
                    Container(
                      height: 5,
                    ),
                    Text("Name: ${widget.product.supplierName}"),
                    Text("Phone: ${widget.product.supplierContact}"),
                  ],
                ),
                InkWell(
                  radius: 10,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    // _makePhoneCall(widget.product.supplierContact);
                  },
                  child: const Icon(Icons.phone, color: patowaveGreen),
                ),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              onPressed: () {},
              child: const Text(
                "Share",
                // style: TextStyle(fontSize: 14),
              ),
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
                _productAdjustment(context, widget.product);
              },
              child: const Text(
                "Adjust Item",
                style: TextStyle(color: patowaveWhite),
              ),
            ),
          ),
        ]),
      ],
      // persistentFooterButtons: [
      //   OutlinedButton(
      //     onPressed: () {},
      //     child: const Text("Share"),
      //   ),
      //   ElevatedButton(
      //     onPressed: () {
      //       _productAdjustment(context, widget.product);
      //     },
      //     child: const Text(
      //       "Adjust Item",
      //       style: TextStyle(color: patowaveWhite),
      //     ),
      //   ),
      // ],
    );
  }

  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: '0679190720',
  //   );
  //   await launchUrl(launchUri);
  // }

  Future<void> _productDelete(
      BuildContext context, SingleProduct product) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              // backgroundColor: patoBackgroundColor,
              // title: const Text('Adjust Item'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Are you sure you want to delete this item?",
                      textAlign: TextAlign.center),
                  Container(height: 10),
                  const Text(
                    "Warning",
                    style: TextStyle(color: patowaveErrorRed),
                  ),
                  Container(height: 10),
                  const Text("All of this informations will be lost.",
                      textAlign: TextAlign.center),
                ],
              ),
              actions: [
                Row(
                  children: [
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
                        child: const Text("Cancel"),
                      ),
                    ),
                    Container(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(45, 45),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(patowaveErrorRed),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: patowaveWhite),
                        ),
                      ),
                    ),
                  ],
                )
              ]);
        });
  }

  Future<void> _productAdjustment(
      BuildContext context, SingleProduct product) async {
    TextEditingController controller = TextEditingController(text: "1");

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          elevation: 0,
          scrollable: true,
          contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          // backgroundColor: patoBackgroundColor,
          title: const Text('Adjust Item'),
          content: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              contentPadding: EdgeInsetsDirectional.all(10),
              border: OutlineInputBorder(),
              prefixIcon: Padding(
                padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                child: Text("Qty:"),
              ),
              suffixIcon: Icon(
                Icons.add_business,
                size: 18,
              ),
              // helperText: "Quantity",
            ),
          ),
          actions: [
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
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
                  child: const Text("Cancel"),
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
                      product.adjustProductQuantity(int.parse(controller.text));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: patowaveWhite),
                  ),
                ),
              ),
            ])
          ],
        );
      },
    );
  }
}
