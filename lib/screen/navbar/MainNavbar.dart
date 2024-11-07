import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:driver_app/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key});

  @override
  _MainNavbarState createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const BillMain(),
    const Center(child: Text("Location Page")),
    const Center(child: Text("Notification Page")),
    const Center(child: Text("Profile Page")),
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
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.search, "Search", 1),
            const SizedBox(width: 20),
            _buildNavItem(Icons.notifications, "Notification", 3),
            _buildNavItem(Icons.person, "Profile", 4),
          ],
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
                  color: Colors.green, // Green background color
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
            Icon(
              Icons.location_on,
              color: _selectedIndex == 2 ? Colors.grey : Colors.white,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
