// ignore: file_names
import 'package:flutter/material.dart';
import 'package:patoapp/pages/business.dart';
import 'package:patoapp/pages/home.dart';
import 'package:patoapp/pages/more.dart';
import 'package:patoapp/pages/parties.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // InventoryPage(),
    MainEntryHomePage(),
    BusinessPage(),
    PartiesPage(),
    MorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      //   actions: [Icon(Icons.notifications)],
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? const FaIcon(FontAwesomeIcons.house)
                : const FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const FaIcon(FontAwesomeIcons.book)
                : const FaIcon(FontAwesomeIcons.book),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const FaIcon(FontAwesomeIcons.user)
                : const FaIcon(FontAwesomeIcons.user),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const FaIcon(FontAwesomeIcons.grip)
                : const FaIcon(FontAwesomeIcons.gripLines),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: patowavePrimary,
        onTap: _onItemTapped,
        // unselectedItemColor: Colors.green,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
