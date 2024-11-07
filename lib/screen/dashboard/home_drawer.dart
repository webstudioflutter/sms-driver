import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xff36a674),
        child: Column(
          children: [
            _headerPart(),
            Expanded(child: _buildDrawerOptions(context)),
            const Divider(color: Colors.white54),
            _logoutButton(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }

  Center _headerPart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/fake_profile.jpg',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'BLUE RIDGE',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff2078bf),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bright Horizons School',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'GoSchool',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _logoutButton(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_outlined,
              color: Color(0xfff24b3f),
            ),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(
                color: Color(0xfff24b3f),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerOptions(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 8.0),
      children: const [
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/home.svg',
          imageColor: Colors.white,
          label: 'Home',
          // destination: AssignmentScreen(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/attendance.svg',
          label: 'Assignment',
          // destination: AssignmentScreen(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/location.svg',
          label: 'Live Overview',
          // destination: AssignmentScreen(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/maintenance.svg',
          label: 'Maintenance',
          // destination: AssignmentScreen(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/fuel-tracking.svg',
          label: 'Fuel Tracking',
          // destination: AssignmentScreen(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/servicing.svg',
          label: 'Servicing',
          // destination: AssignmentScreen(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/servicing.svg',
          label: 'Bill Upload',
          destination: BillMain(),

          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const BillMain()));
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/quick-call.svg',
          label: 'Quick Call',
          // destination: AssignmentScreen(),
        ),
      ],
    );
  }
}

class DrawerCard extends StatelessWidget {
  final String svgAsset;
  final String label;
  final Color? badgeColor;
  final Color? imageColor;
  final Widget? destination;

  const DrawerCard({
    super.key,
    required this.svgAsset,
    required this.label,
    this.destination,
    this.badgeColor,
    this.imageColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        svgAsset,
        height: 25,
        color: imageColor,
      ),
      title: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => destination ?? const SizedBox.shrink()),
        );
      },
    );
  }
}
