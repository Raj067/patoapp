import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:patoapp/accounts/login.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/controllers/profile_controller.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/backend/sync/sync_profile.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/profile/add_new_shop.dart';
import 'package:patoapp/profile/my_business_edit.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:ui' as ui;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopProfileIcon extends StatefulWidget {
  const TopProfileIcon({
    Key? key,
  }) : super(key: key);

  @override
  State<TopProfileIcon> createState() => _TopProfileIconState();
}

class _TopProfileIconState extends State<TopProfileIcon> {
  final GlobalKey globalKey = GlobalKey();
  final CustomerController _customerController = Get.put(CustomerController());
  final ProfileController _profileController = Get.put(ProfileController());

  int profilePercent = 20;

  calculatePercent() {
    if (_profileController.myProfile.value.businessName != '') {
      profilePercent += 10;
    }
    if (_profileController.myProfile.value.businessPhone != '') {
      profilePercent += 10;
    }
    if (_profileController.myProfile.value.businessEmail != '') {
      profilePercent += 10;
    }
    if (_profileController.myProfile.value.businessAddress != '') {
      profilePercent += 10;
    }
    if (_profileController.myProfile.value.businessType != '') {
      profilePercent += 10;
    }
    if (_profileController.myProfile.value.businessCategory != '') {
      profilePercent += 10;
    }
    if (_profileController.myProfile.value.businessSlogan != '') {
      profilePercent += 10;
    }
    if (_profileController.myProfile.value.instagramName != '') {
      profilePercent += 10;
    }
    setState(() {});
  }

  Future<Uint8List> capturePng() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  @override
  void initState() {
    super.initState();
    calculatePercent();
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          Container(height: 10),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.myShops,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(height: 10),
                  _getAllShop(),
                  Row(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const AddNewShop(),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.addNewShop),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // color: Colors.yellow,
                        // height: 200,
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .yourProfileIsAlmostComplete,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(AppLocalizations.of(context)!
                                .pleaseCompleteYourProfile),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 5.0,
                          animation: true,
                          percent: profilePercent / 100,
                          center: Text(
                            "$profilePercent%",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: patowavePrimary,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 10),
                  Row(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    EditMyBusiness(
                                  profileData:
                                      _profileController.myProfile.value,
                                  // refreshData: () {},
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Text(AppLocalizations.of(context)!
                              .editBusinessProfile),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(height: 10),
          Text(
            AppLocalizations.of(context)!.signature,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 10),
          Obx(
            () => _profileController.myProfile.value.businessSignature == ""
                ? Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 0,
                    child: Container(
                      height: 100,
                      // width: 100,
                    ),
                  )
                : Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          _profileController.myProfile.value.businessSignature,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          ),
          Container(height: 10),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(patowaveErrorRed),
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
                  await storage.deleteAll();
                  Get.offAll(const LoginPage());
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getAllShop() {
    Widget data1 = GetBuilder<ProfileController>(builder: (controller) {
      List<Widget> data = [];
      for (var element in controller.allProfiles) {
        data.add(Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          color: patowavePrimary.withAlpha(50),
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              _setShop(element);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  element.businessLogo == ''
                      ? Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )
                      : Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                element.businessLogo,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                  Container(width: 10),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            element.businessName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            element.businessAddress,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ]),
                  ),
                  element.id == _profileController.myProfile.value.id
                      ? const Icon(
                          Icons.done,
                          size: 30,
                          color: patowavePrimary,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ));
        data.add(Container(height: 5));
      }
      return Column(children: data);
    });
    return data1;
  }

  _setShop(ProfileData shop) async {
    await storage.write(key: "activeShop", value: "${shop.id}");

    // update shop
    _profileController.myProfileChangeUpdater(shop);

    // update customer
    await _customerController.fetchCustomersDB();
    // widget.refreshData();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }
}
