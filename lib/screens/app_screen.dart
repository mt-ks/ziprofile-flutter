import 'package:flutter/material.dart';
import './app/stories_screen.dart';
import '../screens/app/search_screen.dart';
import '../screens/app/settings_screen.dart';
import '../screens/app/profile_screen.dart';
import '../navigator/bottom_navigation.dart';

class AppScreen extends StatefulWidget {
  static const routeName = '/app';
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  late List<Widget> _pages;

  void onSelectedIndex(int index) {
    setState(() => _selectedPage = index);
  }

  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _selectedPage = 0;

    _pages = [
      ProfileScreen(
        navigatorKey: MyKeys.profileScreen,
        navIndex: (value) => onSelectedIndex(value),
      ),
      SearchScreen(
        navigatorKey: MyKeys.searchScreen,
      ),
      StoriesScreen(
        navigatorKey: MyKeys.storiesScreen,
      ),
      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return !await Navigator.maybePop(
            MyKeys.getKeys()[_selectedPage].currentState!.context,
          );
        },
        child: IndexedStack(
          index: _selectedPage,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNav(
          selectedPage: _selectedPage, onSelectedIndex: onSelectedIndex),
    );
  }
}

class MyKeys {
  static final profileScreen = GlobalKey(debugLabel: 'profileScreen');
  static final searchScreen = GlobalKey(debugLabel: 'searchScreen');
  static final storiesScreen = GlobalKey(debugLabel: 'storiesScreen');
  static final settingsScreen = GlobalKey(debugLabel: 'settingsScreen');

  static List<GlobalKey> getKeys() => [
        profileScreen,
        searchScreen,
        storiesScreen,
        settingsScreen,
      ];
}
