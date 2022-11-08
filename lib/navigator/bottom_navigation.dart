import 'package:flutter/material.dart';
import '../icons/nav_icons.dart';

class BottomNav extends StatelessWidget {
  BottomNav({
    super.key,
    required this.selectedPage,
    required this.onSelectedIndex,
  });
  final int selectedPage;
  final ValueChanged<int> onSelectedIndex;
  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(NavIcons.user_icon),
      label: "Profil",
      backgroundColor: Colors.black,
    ),
    BottomNavigationBarItem(
      icon: Icon(NavIcons.search_icon),
      label: "Ara",
      backgroundColor: Colors.black,
    ),
    BottomNavigationBarItem(
      icon: Icon(NavIcons.stories),
      label: "Hikayeler",
      backgroundColor: Colors.black,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
      backgroundColor: Colors.black,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromRGBO(124, 118, 146, 1),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: _items,
      currentIndex: selectedPage,
      onTap: (index) => onSelectedIndex(index),
    );
  }
}
