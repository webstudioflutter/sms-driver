// import 'package:driver_app/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key});

  @override
  _MainNavbarState createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // const DashboardPage(),
    const Center(child: Text("Search Page")),
    const Center(child: Text("Location Page")),
    const Center(child: Text("Notification Page")),
    // const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const BottomAppBar(
        color: Color(0xffcdeede),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // children: [
          //   _buildNavItem(Assets.svgImages.home2, "Home", 0),
          //   _buildNavItem(Assets.svgImages.searchnormal, "Search", 1),
          //   const SizedBox(width: 20),
          //   _buildNavItem(Assets.svgImages.Component3, "Notification", 3),
          //   _buildNavItem(Assets.svgImages.user, "Profile", 4),
          // ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () => _onItemTapped(2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: 0.85,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xff60BF8F), // Green background color
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.2), // Shadow color
                      blurRadius: 10, // Shadow blur radius
                      offset: const Offset(1, -1), // Shadow position
                    ),
                  ],
                ),
              ),
            ),
            // SvgPicture.asset(
            //   Assets.svgImages.notification2,
            //   height: 25,
            //   color: _selectedIndex == 2 ? Colors.green : Colors.white,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgAsset, String label, int index) {
    bool isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgAsset,
              height: 22,
              color: isSelected ? Colors.green : const Color(0xff516B5E),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.green : const Color(0xff516B5E),
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
