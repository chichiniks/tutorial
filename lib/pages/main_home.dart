
import 'package:fellowship/pages/saved.dart';
import 'package:flutter/material.dart';
import 'package:fellowship/pages/cardswipe_page.dart';
import 'package:fellowship/pages/search_input.dart';
// import 'package:fellowship/pages/sear'

class MainHome extends StatefulWidget{
  const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final controllerCity = TextEditingController();
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    SwipePage(),
    SearchPage(),
    SavedPage()
  ];
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items : [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Save'),
    ]
    // padding: EdgeInsets.all(16),
      )
      );
  }
}