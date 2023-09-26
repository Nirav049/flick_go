import 'package:flick_go/pages/Search.dart';
import 'package:flick_go/pages/favorites.dart';
import 'package:flick_go/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  int currentindx = 0;
  final Function(int) onItemSelected;
  CustomBottomNavigationBar({required this.selectedIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60,
      color: Color.fromRGBO(33, 150, 243, 1),
      backgroundColor: Colors.transparent,
      
      items: <Widget>[
        ImageIcon(AssetImage('assets/images/icons/home.png'), size: 30, color: Colors.white),
        ImageIcon(AssetImage('assets/images/icons/search.png'), size: 30, color: Colors.white),
        ImageIcon(AssetImage('assets/images/icons/heart.png'), size: 30, color: Colors.white),
      ],
      onTap: (index) {
        switch (index) {
          case 0: // Home icon tapped
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage(), // Replace with your Home page widget
            ));
            break;
          case 1: // Search icon tapped
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SearchPage(), // Replace with your Search page widget
            ));
            break;
          case 2: // Heart icon tapped
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FavoritesPage(), // Replace with your Favorites page widget
            ));
            break;
        }
      },
      index: selectedIndex,
    );
  }
}
