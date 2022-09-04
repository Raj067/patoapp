import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/profile_controller.dart';
import 'package:patoapp/backend/funcs/upload_image.dart';
import 'package:signature/signature.dart';
import 'package:patoapp/backend/models/profile_details.dart';
// import 'package:patoapp/backend/sync/sync_profile.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMyBusiness extends StatefulWidget {
  // final Function refreshData;
  final ProfileData profileData;
  const EditMyBusiness({
    Key? key,
    required this.profileData,
    // required this.refreshData,
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
  final ProfileController _profileController = Get.put(ProfileController());

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: patowavePrimary,
    exportBackgroundColor: patowaveWhite,
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
        title: Text(
          AppLocalizations.of(context)!.myBusiness,
          style: const TextStyle(color: Colors.white),
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
                    child: Text(AppLocalizations.of(context)!.back),
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
              child: Text(value == 1
                  ? AppLocalizations.of(context)!.next
                  : AppLocalizations.of(context)!.finish),
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
    return Form(
      key: editShopFormKey1,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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

                        // ignore: use_build_context_synchronously
                        await uploadImageFile(
                          File(image.path),
                          'api/update-shop-logo/',
                          context,
                        );
                        setState(() {});
                      },
                      child: widget.profileData.businessLogo == ""
                          ? CircleAvatar(
                              foregroundImage: uploadedImage == null
                                  ? null
                                  : MemoryImage(uploadedImage!),
                              radius: 50,
                              backgroundColor: patowavePrimary.withAlpha(50),
                              foregroundColor: patowavePrimary,
                              child: const Icon(Icons.photo, size: 50),
                            )
                          : uploadedImage == null
                              ? Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        widget.profileData.businessLogo,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  // child: Image.asset("assets/img.jpg", fit: BoxFit.fill),
                                )
                              : CircleAvatar(
                                  foregroundImage: MemoryImage(uploadedImage!),
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
          Container(height: 10),
          Center(
            child: Text(
              AppLocalizations.of(context)!.tapToAddBusinessLogo,
              style: const TextStyle(color: patowavePrimary),
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
            decoration: InputDecoration(
              label: Text(
                "${AppLocalizations.of(context)!.businessName}*",
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              border: const OutlineInputBorder(
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
            decoration: InputDecoration(
              label: Text(
                "${AppLocalizations.of(context)!.businessPhoneNumber}*",
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              border: const OutlineInputBorder(
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
            decoration: InputDecoration(
              label: Text(
                AppLocalizations.of(context)!.businessEmail,
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              border: const OutlineInputBorder(
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
            decoration: InputDecoration(
              label: Text(
                "${AppLocalizations.of(context)!.businessAddress}*",
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              border: const OutlineInputBorder(
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
            decoration: InputDecoration(
              label: Text(
                AppLocalizations.of(context)!.instagramName,
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
          Container(height: 15),
          Text(
            AppLocalizations.of(context)!.signature,
            style: const TextStyle(
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
                    final dir = await getApplicationDocumentsDirectory();
                    final file = File('${dir.path}/signature.png');
                    await file.writeAsBytes(myImage!);
                    // ignore: use_build_context_synchronously
                    String link = await uploadImageFile(
                      File(file.path),
                      'api/update-shop-signature/',
                      context,
                    );
                    // print(link);
                    widget.profileData.businessSignature = link;
                    _profileController
                        .myProfileChangeUpdaterProfile(widget.profileData);
                    // update shop
                    _profileController
                        .myProfileChangeUpdater(widget.profileData);

                    // _controller.clear();
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Saved Successfully"),
                      ),
                    );
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
    );
  }

  _secondScreen() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      children: [
        DropdownButtonFormField2(
          value: businessTypes.contains(businessType.text)
              ? businessType.text
              : null,
          selectedItemHighlightColor: patowavePrimary.withAlpha(50),
          scrollbarAlwaysShow: true,
          dropdownMaxHeight: 200,
          decoration: InputDecoration(
            label: Text(
              AppLocalizations.of(context)!.businessType,
              style: const TextStyle(
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
            label: Text(
              AppLocalizations.of(context)!.businessCategory,
              style: const TextStyle(
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
          decoration: InputDecoration(
            label: Text(
              AppLocalizations.of(context)!.businessSlogan,
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _submitData(BuildContext context) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
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
        widget.profileData.businessName = businessName.text;
        widget.profileData.businessEmail = businessEmail.text;
        widget.profileData.businessAddress = businessAddress.text;
        widget.profileData.instagramName = instagramName.text;
        widget.profileData.businessPhone = businessPhone.text;
        widget.profileData.businessSlogan = businessSlogan.text;
        widget.profileData.businessType = businessType.text;
        widget.profileData.businessCategory = businessCategory.text;
        _profileController.myProfileChangeUpdaterProfile(widget.profileData);
        // update shop
        _profileController.myProfileChangeUpdater(widget.profileData);

        // Get.back();
        Get.back();
        Get.back();
      } else {
        Get.back();
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      Get.back();
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
