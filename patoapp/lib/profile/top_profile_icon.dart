import 'package:flutter/material.dart';
import 'package:patoapp/accounts/login.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/backend/sync/sync_profile.dart';
import 'package:patoapp/profile/add_new_shop.dart';
import 'package:patoapp/profile/my_business_edit.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class TopProfileIcon extends StatefulWidget {
  final Function refreshData;
  final ProfileData profileData;
  const TopProfileIcon({
    Key? key,
    required this.profileData,
    required this.refreshData,
  }) : super(key: key);

  @override
  State<TopProfileIcon> createState() => _TopProfileIconState();
}

class _TopProfileIconState extends State<TopProfileIcon> {
  List<ProfileData> myProfileData = [];
  int profilePercent = 20;
  fetchProfileDB() async {
    List<Map<String, dynamic>> profile = await DBHelperProfile.query();
    List<ProfileData> finalData = [];
    finalData.addAll(profile
        .map((dx) => ProfileData(
              instagramName: dx['instagramName'],
              businessSignature: dx['businessSignature'],
              businessSlogan: dx['businessSlogan'],
              businessLogo: dx['businessLogo'],
              businessCategory: dx['businessCategory'],
              businessType: dx['businessType'],
              businessEmail: dx['businessEmail'],
              businessPhone: "${dx['businessPhone']}",
              businessAddress: dx['businessAddress'],
              businessName: dx['businessName'],
              id: dx['id'],
            ))
        .toList());
    myProfileData = finalData;
    setState(() {});
  }

  refreshDataDB() async {
    SyncProfile syncProfile = SyncProfile();
    await syncProfile.fetchData();
    fetchProfileDB();
  }

  calculatePercent() {
    if (widget.profileData.businessName != '') {
      profilePercent += 10;
    }
    if (widget.profileData.businessPhone != '') {
      profilePercent += 10;
    }
    if (widget.profileData.businessEmail != '') {
      profilePercent += 10;
    }
    if (widget.profileData.businessAddress != '') {
      profilePercent += 10;
    }
    if (widget.profileData.businessType != '') {
      profilePercent += 10;
    }
    if (widget.profileData.businessCategory != '') {
      profilePercent += 10;
    }
    if (widget.profileData.businessSlogan != '') {
      profilePercent += 10;
    }
    if (widget.profileData.instagramName != '') {
      profilePercent += 10;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchProfileDB();
    refreshDataDB();
    calculatePercent();
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
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
                    const Text(
                      "My Shops",
                      style: TextStyle(
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
                                      AddNewShop(refreshData: () {
                                    refreshDataDB();
                                  }),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: const Text("Add new shop"),
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
              child: Column(
                children: [
                  // Image.asset("assets/images/card.png"),
                  SizedBox(
                    height: 200,
                    width: 300,
                    // color: Colors.green,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset("assets/images/card.png"),
                        ),
                        Positioned(
                          top: 97,
                          // left: 50,
                          right: 26,
                          bottom: 0,
                          child: Text(
                            widget.profileData.businessName.length > 13
                                ? widget.profileData.businessName
                                    .replaceRange(13, null, '...')
                                : widget.profileData.businessName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: patowaveWhite,
                            ),
                          ),
                        ),
                        Positioned(
                          // top: 95,
                          // left: 50,
                          right: 26,
                          bottom: 50,
                          child: Text(
                            widget.profileData.businessSlogan == ""
                                ? "Customer is king"
                                : widget.profileData.businessSlogan,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: patowaveBlack,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          left: 30,
                          // right: 26,
                          bottom: 0,
                          child: Text(
                            widget.profileData.businessAddress,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: patowaveWhite,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 80,
                          left: 30,
                          // right: 26,
                          bottom: 0,
                          child: Text(
                            widget.profileData.businessPhone,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: patowaveWhite,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 30,
                          // right: 26,
                          bottom: 0,
                          child: Text(
                            widget.profileData.businessEmail == ""
                                ? "Email"
                                : widget.profileData.businessEmail,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: patowaveWhite,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 120,
                          left: 30,
                          // right: 26,
                          bottom: 0,
                          child: Text(
                            widget.profileData.instagramName == ""
                                ? "_____"
                                : widget.profileData.instagramName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: patowaveWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Icon(Icons.download, size: 18),
                            Container(width: 10),
                            const Text("Download"),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Icon(Icons.share, size: 18),
                            Container(width: 10),
                            const Text("Share"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(height: 10),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            //   child: Image.asset("assets/images/card.png"),
            // ),
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
                            children: const [
                              Text(
                                "Your profile is almost complete!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                  "Please complete your profile to fill your business card."),
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
                                    profileData: widget.profileData,
                                    refreshData: widget.refreshData,
                                  ),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: const Text("Edit Business Profile"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 10),
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
              child: Container(
                height: 100,
                // width: 100,
              ),
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Change"),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Upload"),
                ),
                OutlinedButton(
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
                  onPressed: () {},
                  child: const Text("Remove"),
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
                  // ignore: use_build_context_synchronously
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) => const LoginPage(),
                  //     fullscreenDialog: true,
                  //   ),
                  // );
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false);
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
    List<Widget> data = [];
    for (ProfileData dx in myProfileData) {
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
            _setShop(dx);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          dx.businessName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          dx.businessAddress,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
                dx.id == widget.profileData.id
                    ? const Icon(
                        Icons.more_vert_outlined,
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
  }

  _setShop(ProfileData shop) async {
    await storage.write(key: "activeShop", value: "${shop.id}");
    widget.refreshData();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
