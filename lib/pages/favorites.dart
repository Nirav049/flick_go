import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flick_go/navigationBar.dart';
import 'package:flutter/material.dart';


class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();

}

class _FavoritesPageState extends State<FavoritesPage> {
  int _currentIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Page'),
        backgroundColor: Color.fromRGBO(33, 150, 243, 1),
      ),
      body: Center(
        child: Text('Welcome to the Favorites Page!'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
