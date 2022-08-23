// ignore: file_names
import 'package:flutter/material.dart';
import 'package:patoapp/components/top_bar.dart';
import 'package:patoapp/pages/business.dart';
import 'package:patoapp/pages/home.dart';
import 'package:patoapp/pages/more.dart';
import 'package:patoapp/pages/parties.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: const ProfileIcon(),
        actions: const [NotificationIcon(), SizedBox(width: 10)],
        elevation: 0,
      ),
      body: Center(
        child: <Widget>[
          const MainEntryHomePage(),
          const BusinessPage(),
          const PartiesPage(),
          const MorePage(),
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
            label: AppLocalizations.of(context)!.home,
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
            label: AppLocalizations.of(context)!.cashBook,
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
            label: AppLocalizations.of(context)!.contacts,
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
            label: AppLocalizations.of(context)!.more,
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
