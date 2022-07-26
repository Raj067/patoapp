// ignore: file_names
import 'package:flutter/material.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/backend/sync/sync_profile.dart';
import 'package:patoapp/pages/business.dart';
import 'package:patoapp/pages/home.dart';
import 'package:patoapp/pages/more.dart';
import 'package:patoapp/pages/parties.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  ProfileData profileData = ProfileData(
    businessName: '',
    id: 0,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              businessPhone: dx['businessPhone'],
              businessAddress: dx['businessAddress'],
              businessName: dx['businessName'],
              id: dx['id'],
            ))
        .toList());
    if (finalData.isNotEmpty) {
      profileData = finalData[1];
    }
    setState(() {});
  }

  refreshDataDB() async {
    SyncProfile syncProfile = SyncProfile();
    await syncProfile.fetchData();
    fetchProfileDB();
  }

  @override
  void initState() {
    super.initState();
    fetchProfileDB();
    refreshDataDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: <Widget>[
          MainEntryHomePage(profileData: profileData),
          BusinessPage(profileData: profileData),
          PartiesPage(profileData: profileData),
          MorePage(profileData: profileData),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? SvgPicture.asset(
                    "assets/svg/home2.svg",
                    width: 20,
                    height: 20,
                  )
                : SvgPicture.asset(
                    color: Theme.of(context).iconTheme.color,
                    "assets/svg/home1.svg",
                    width: 20,
                    height: 20,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? SvgPicture.asset(
                    "assets/svg/b2.svg",
                    width: 20,
                    height: 20,
                  )
                : SvgPicture.asset(
                    color: Theme.of(context).iconTheme.color,
                    "assets/svg/b1.svg",
                    width: 20,
                    height: 20,
                  ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 20,
                  )
                : FaIcon(
                    FontAwesomeIcons.user,
                    color: Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? SvgPicture.asset(
                    "assets/svg/more2.svg",
                    width: 20,
                    height: 20,
                  )
                : SvgPicture.asset(
                    color: Theme.of(context).iconTheme.color,
                    "assets/svg/more1.svg",
                    width: 20,
                    height: 20,
                  ),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: patowavePrimary,
        onTap: _onItemTapped,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
