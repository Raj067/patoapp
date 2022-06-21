// ignore: file_names
import 'package:flutter/material.dart';
import 'package:patoapp/pages/business.dart';
import 'package:patoapp/pages/home.dart';
import 'package:patoapp/pages/inventoryPage.dart';
import 'package:patoapp/pages/more.dart';
import 'package:patoapp/pages/parties.dart';
import 'package:patoapp/themes/lightTheme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    InventoryPage(),
    // MainEntryHomePage(),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind_outlined),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
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
