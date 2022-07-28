import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/funcs/upload_image.dart';
import 'package:signature/signature.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/backend/sync/sync_profile.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:image_picker/image_picker.dart';

class EditMyBusiness extends StatefulWidget {
  final Function refreshData;
  final ProfileData profileData;
  const EditMyBusiness({
    Key? key,
    required this.profileData,
    required this.refreshData,
  }) : super(key: key);

  @override
  State<EditMyBusiness> createState() => _EditMyBusinessState();
}

class _EditMyBusinessState extends State<EditMyBusiness> {
  final List<String> businessCategories = [
    "FMCG Shop",
    "Salon and hairdresser",
    "Hardware store",
    "Home Service",
    "Restaurant/hotel",
    "Liquor store",
    "Chemical and fertilizer",
    "Construction materials and equipment",
    "Repairing/plumbing/Electrician",
    "Book/ Stationery store",
    "Fashion accessory/ Cosmetics",
    "Fruit and vegetables",
    "Dairy products",
    "Furniture",
    "Jewery and germs",
    "Pharmacy/medical",
    "Industrial machinery and equipments",
    "Mobile and accessories",
    "Bakery",
    "Toys and gifts",
    "Coaching and training",
    "Fitness center",
    "Real estate",
    "Tour and travel",
    "NGO and charitable",
    "Oil and gas",
    "Others"
  ];

  final List<String> businessTypes = [
    "Retail",
    "Wholesale",
    "Service",
    "Distributor",
    "Manufacturing",
    "Others",
  ];

  int value = 1;
  String? selectedBusinessCategory;
  String? selectedBusinessType;

  TextEditingController businessName = TextEditingController();
  TextEditingController businessPhone = TextEditingController();
  TextEditingController businessEmail = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  TextEditingController instagramName = TextEditingController();
  TextEditingController businessSlogan = TextEditingController();
  TextEditingController businessType = TextEditingController();
  TextEditingController businessCategory = TextEditingController();

  final editShopFormKey1 = GlobalKey<FormState>();

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: patowavePrimary,
    exportBackgroundColor: Colors.blue,
  );

  final ImagePicker _picker = ImagePicker();

  Uint8List? uploadedImage;
  @override
  void initState() {
    super.initState();
    businessName.text = widget.profileData.businessName;
    businessPhone.text = widget.profileData.businessPhone;
    businessEmail.text = widget.profileData.businessEmail;
    businessAddress.text = widget.profileData.businessAddress;
    instagramName.text = widget.profileData.instagramName;
    businessSlogan.text = widget.profileData.businessSlogan;
    businessType.text = widget.profileData.businessType;
    businessCategory.text = widget.profileData.businessCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Business',
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
      body: value == 1 ? _firstScreen() : _secondScreen(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            value == 2
                ? TextButton(
                    child: const Text("Back"),
                    onPressed: () {
                      setState(() {
                        value = 1;
                      });
                    },
                  )
                : const SizedBox(width: 65, height: 1),
            Row(mainAxisSize: MainAxisSize.min, children: [
              value == 1
                  ? const Icon(
                      Icons.circle,
                      size: 12,
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      size: 12,
                    ),
              value == 1
                  ? const Icon(
                      Icons.circle_outlined,
                      size: 12,
                    )
                  : const Icon(
                      Icons.circle,
                      size: 12,
                    ),
            ]),
            TextButton(
              child: Text(value == 1 ? "Next" : "Finish"),
              onPressed: () {
                setState(() {
                  if (value == 1) {
                    if (editShopFormKey1.currentState!.validate()) {
                      value == 1 ? value = 2 : Navigator.pop(context);
                    }
                  } else {
                    _submitData(context);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  _firstScreen() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Form(
        key: editShopFormKey1,
        child: ListView(
          children: [
            Container(height: 10),
            Center(
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

                          await uploadImageFile(
                              File(image.path), 'api/update-shop-logo/');
                          setState(() {});
                        },
                        child: CircleAvatar(
                          foregroundImage: uploadedImage == null
                              ? null
                              : MemoryImage(uploadedImage!),
                          radius: 50,
                          backgroundColor: patowavePrimary.withAlpha(50),
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
            Container(height: 10),
            const Center(
              child: Text(
                "Tap to add your business logo",
                style: TextStyle(color: patowavePrimary),
              ),
            ),
            Container(height: 15),
            TextFormField(
              controller: businessName,
              cursorColor: patowavePrimary,
              validator: (value) {
                if (value == null || value == "") {
                  return 'Business Name is required';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text(
                  "Business Name*",
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
            TextFormField(
              controller: businessPhone,
              cursorColor: patowavePrimary,
              validator: (value) {
                if (value == null || value == "") {
                  return 'Phone Number is required';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                label: Text(
                  "Business Phone Number*",
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
            TextFormField(
              cursorColor: patowavePrimary,
              controller: businessEmail,
              decoration: const InputDecoration(
                label: Text(
                  "Business Email",
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
            TextFormField(
              cursorColor: patowavePrimary,
              controller: businessAddress,
              validator: (value) {
                if (value == null || value == "") {
                  return 'Business Address is required';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text(
                  "Business Address*",
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
            TextFormField(
              cursorColor: patowavePrimary,
              controller: instagramName,
              decoration: const InputDecoration(
                label: Text(
                  "Instagram Name",
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
            const Text(
              "Signature",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(height: 10),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Signature(
                  controller: _controller,
                  // width: 300,
                  height: 200,
                  backgroundColor: Theme.of(context).cardColor,
                ),
              ),
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // OutlinedButton(
                //   style: ButtonStyle(
                //     shape: MaterialStateProperty.all(
                //       const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(30),
                //         ),
                //       ),
                //     ),
                //   ),
                //   onPressed: () {},
                //   child: const Text("Change"),
                // ),
                Expanded(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      Uint8List? myImage = await _controller.toPngBytes();
                      await uploadImageBytes(
                          myImage, 'api/update-shop-signature/');
                      // _controller.toPngBytes();
                    },
                    child: const Text("Save"),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(color: patowaveErrorRed),
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
                      _controller.clear();
                    },
                    child: const Text("Clear"),
                  ),
                ),
              ],
            ),
            Container(height: 10),
          ],
        ),
      ),
    );
  }

  _secondScreen() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          DropdownButtonFormField2(
            value: businessTypes.contains(businessType.text)
                ? businessType.text
                : null,
            selectedItemHighlightColor: patowavePrimary.withAlpha(50),
            scrollbarAlwaysShow: true,
            dropdownMaxHeight: 200,
            decoration: InputDecoration(
              label: const Text(
                'Business Type',
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
            items: businessTypes
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
              businessType.text = value.toString();
              setState(() {});
            },
            onSaved: (value) {
              selectedBusinessType = value.toString();
            },
          ),
          Container(height: 15),
          DropdownButtonFormField2(
            value: businessCategories.contains(businessCategory.text)
                ? businessCategory.text
                : null,
            selectedItemHighlightColor: patowavePrimary.withAlpha(50),
            scrollbarAlwaysShow: true,
            dropdownMaxHeight: 200,
            decoration: InputDecoration(
              label: const Text(
                'Business Category',
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
            items: businessCategories
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
              businessCategory.text = value.toString();
              setState(() {});
            },
            onSaved: (value) {
              selectedBusinessCategory = value.toString();
            },
          ),
          Container(height: 15),
          TextFormField(
            cursorColor: patowavePrimary,
            controller: businessSlogan,
            decoration: const InputDecoration(
              label: Text(
                "Business Slogan",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _submitData(BuildContext context) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    final response = await http.post(
      Uri.parse('${baseUrl}api/shop-profile-edit/'),
      headers: getAuthHeaders(accessToken),
      body: jsonEncode(<String, dynamic>{
        "id": widget.profileData.id,
        'businessName': businessName.text,
        'businessEmail': businessEmail.text,
        'businessAddress': businessAddress.text,
        'instagramName': instagramName.text,
        'businessPhone': businessPhone.text,
        'businessSlogan': businessSlogan.text,
        'businessType': businessType.text,
        'businessCategory': businessCategory.text,
      }),
    );

    if (response.statusCode == 201) {
      SyncProfile syncProfile = SyncProfile();
      await syncProfile.fetchData();
      widget.refreshData();
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
  }
}
