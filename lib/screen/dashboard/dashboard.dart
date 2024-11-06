import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/screen/dashboard/home_page.dart';
import 'package:driver_app/screen/dashboard/profile_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  // List of pages for each bottom navigation item
  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text('Search Page')),
    const Center(child: Text('Add Page')),
    const Center(child: Text('Notifications Page')),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfffefefe),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          // Always show labels for all items
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 4,
          selectedItemColor: const Color(0xff60bf8f),
          unselectedItemColor: const Color(0xff516b5e),
          backgroundColor: secondaryColor,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
