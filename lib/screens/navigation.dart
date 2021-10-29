import 'package:migscourier/screens/account.dart';
import 'package:migscourier/screens/home.dart';
import 'package:migscourier/constants.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> _screens = [
    HomeScreen(),
    AccountScreen(),
  ];

  PageController _pageController = PageController();

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTap(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kNavBarBGColor,
        onTap: _onItemTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.delivery_dining,
              size: 28,
              color:
                  _selectedIndex == 0 ? kInactiveNavItemColor : kDisabledColor,
            ),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color:
                  _selectedIndex == 1 ? kInactiveNavItemColor : kDisabledColor,
            ),
            label: 'Account',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
