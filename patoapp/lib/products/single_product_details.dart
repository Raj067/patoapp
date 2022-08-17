import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/funcs/upload_image.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/products/edit_product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class SingleProductDetails extends StatefulWidget {
  const SingleProductDetails({
    super.key,
    required this.product,
    required this.isProductImage,
    required this.isProductBarcode,
    required this.resetData,
  });
  final SingleProduct product;
  final bool isProductImage;
  final bool isProductBarcode;
  final Function resetData;
  @override
  State<SingleProductDetails> createState() => _SingleProductDetailsState();
}

class _SingleProductDetailsState extends State<SingleProductDetails> {
  final ImagePicker _picker = ImagePicker();

  Uint8List? uploadedImage;
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
                  builder: (BuildContext context) => EditProduct(
                    product: widget.product,
                    isProductBarcode: widget.isProductBarcode,
                    isProductImage: widget.isProductImage,
                    resetData: () {
                      widget.resetData();
                    },
                  ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(70),
                              onTap: () async {
                                XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);

                                uploadedImage = await image!.readAsBytes();

                                // ignore: use_build_context_synchronously
                                await uploadImageFile(
                                  File(image.path),
                                  'api/update-product-thumbnail/${widget.product.id}/',
                                  context,
                                );
                                setState(() {});
                              },
                              child: widget.product.thumbnail != ""
                                  ? uploadedImage != null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image:
                                                  MemoryImage(uploadedImage!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                widget.product.thumbnail,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                  : CircleAvatar(
                                      // foregroundImage: uploadedImage == null
                                      //     ? null
                                      //     : MemoryImage(uploadedImage!),
                                      radius: 50,
                                      backgroundColor:
                                          patowavePrimary.withAlpha(50),
                                      foregroundColor: patowavePrimary,
                                      child: const Icon(Icons.photo, size: 50),
                                    ),
                            ),
                          ),
                          const Positioned(
                            right: 5,
                            bottom: 5,
                            child: Icon(
                              Icons.add_circle,
                              color: patowavePrimary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
          widget.product.isService
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.product.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
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
                              const Text('Service Charge'),
                              Text("Tsh: ${widget.product.sellingPrice}"),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Service Unit'),
                              Text(widget.product.productUnit),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Descriptions'),
                              Expanded(
                                child: Text(
                                  widget.product.supplierName,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.product.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
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
                        // const Divider(),
                        // Padding(
                        //   padding: const EdgeInsets.all(10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       const Text('Total Items sold'),
                        //       Text("${widget.product.totalItemsSold}"),
                        //     ],
                        //   ),
                        // ),
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
                                  Text(
                                      "Phone: ${widget.product.supplierContact}"),
                                ],
                              ),
                              InkWell(
                                radius: 10,
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  final Uri phoneLaunchUri = Uri(
                                    scheme: 'tel',
                                    path: widget.product.supplierContact,
                                  );
                                  launchUrl(phoneLaunchUri);
                                },
                                child: const Icon(Icons.phone,
                                    color: patowaveGreen),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
              onPressed: () async {
                Share.share("""
Product Name: ${widget.product.productName}
Selling Price: Tsh ${widget.product.sellingPrice}
""", subject: '${widget.product.productName} details');
              },
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
                  Radius.circular(30),
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
                        onPressed: () {
                          _deleteProduct();
                        },
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
              Radius.circular(30),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
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
                      _adjustProduct(int.parse(controller.text));
                    });
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

// api/adjust-product/
  _adjustProduct(int quantity) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/adjust-product/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'quantity': quantity,
          'id': widget.product.id,
        }),
      );

      if (response.statusCode == 201) {
        widget.resetData();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }

  _deleteProduct() async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/delete-product/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'id': widget.product.id,
        }),
      );

      if (response.statusCode == 201) {
        widget.resetData();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
