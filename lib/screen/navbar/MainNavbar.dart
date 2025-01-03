import 'package:driver_app/controller/Home/ServicingController.dart';
import 'package:driver_app/controller/NotificationController.dart';
import 'package:driver_app/controller/Profilecontroller.dart';
import 'package:driver_app/controller/SchoosettingController.dart';
import 'package:driver_app/core/utils/asset_provider.dart';
import 'package:driver_app/screen/dashboard/home_page.dart';
import 'package:driver_app/screen/dashboard/profile/profile_page.dart';
import 'package:driver_app/screen/map/maps.dart';
import 'package:driver_app/screen/notification/notificationScreen.dart';
import 'package:driver_app/screen/search/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key});

  @override
  _MainNavbarState createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  final controller = Get.put(ProfileController());
  final servicecontroller = Get.put(ServicingController());

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    SearchScreen(),
    MapTrackingPage(),
    NotificationScreen(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    ccontroller.getSchoolSetting();
    servicecontroller.resetFields();
    super.initState();
  }

  final schoolsettingController ccontroller =
      Get.put(schoolsettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xffcdeede),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              Assets.svgImages.homecopy,
              "home".tr,
              0,
              Assets.svgImages.home2,
            ),
            _buildNavItem(
              Assets.svgImages.searchnormal,
              "search".tr,
              1,
              Assets.svgImages.searchnormal,
            ),
            const SizedBox(width: 20),
            _buildNavItem(
              Assets.svgImages.Component3,
              "notification".tr,
              3,
              Assets.svgImages.notificationcopy,
            ),
            _buildNavItem(
              Assets.svgImages.user,
              "profile".tr,
              4,
              Assets.svgImages.user2,
            ),
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
                  color: const Color(0xff60BF8F),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(1, -1),
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              _selectedIndex == 2
                  ? Assets.svgImages.Component4
                  : Assets.svgImages.location,
              height: 25,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      String svgAsset, String label, int index, String svgAsset2) {
    bool isSelected = index == _selectedIndex;

    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  isSelected ? svgAsset2 : svgAsset,
                  height: 22,
                  color: isSelected ? Colors.green : const Color(0xff516B5E),
                ),
                if (index == 3)
                  StreamBuilder<int>(
                    stream: notificationbloc.unreadCount,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data! > 0) {
                        return Positioned(
                          right: -6,
                          top: -6,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${snapshot.data}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
              ],
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
