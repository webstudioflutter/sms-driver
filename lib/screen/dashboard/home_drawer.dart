import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:driver_app/screen/dashboard/attendance/attendance.dart';
import 'package:driver_app/screen/dashboard/home_page.dart';
import 'package:driver_app/screen/fuel/fuel_tracking.dart';
import 'package:driver_app/screen/servicing/servicing_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({
    super.key,
  });

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  Future<void> _makePhoneCall() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+1234567890', // Replace with your desired phone number
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xff36a674),
        child: Column(
          children: [
            _headerPart(context),
            Expanded(child: _buildDrawerOptions(context)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(color: Colors.white54),
            ),
            _logoutButton(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }

  Center _headerPart(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: getHeight(context) * 0.09,
          bottom: getHeight(context) * 0.03,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                'https://img.freepik.com/free-vector/gradient-high-school-logo-design_23-2149626932.jpg?t=st=1731222465~exp=1731226065~hmac=373644b2dd9c85880d024478d228c20810da4d9e6bc4fb3f07c8fcef59a5a57a&w=740',
                width: getHeight(context) * 0.07,
                height: getHeight(context) * 0.07,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: getWidth(context) * 0.04),
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
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {},
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
      ),
    );
  }

  Widget _buildDrawerOptions(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 8.0),
      children: [
        const DrawerCard(
          svgAsset: 'assets/svg_images/drawer/home.svg',
          imageColor: Colors.white,
          label: 'Home',
          destination: HomePage(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/attendance.svg',
          label: 'Attendance',
          destination: Attendance(),
        ),
        const DrawerCard(
          svgAsset: 'assets/svg_images/location.svg',
          label: 'Live Overview',
          // destination: AssignmentScreen(),
        ),
        const DrawerCard(
          svgAsset: 'assets/svg_images/drawer/maintenance.svg',
          label: 'Maintenance',
          // destination: AssignmentScreen(),
        ),
        const DrawerCard(
          svgAsset: 'assets/svg_images/drawer/fuel-tracking.svg',
          label: 'Fuel Tracking',
          destination: FuelTrackingMain(),
        ),
        const DrawerCard(
          svgAsset: 'assets/svg_images/drawer/servicing.svg',
          label: 'Servicing',
          destination: ServicingMain(),
        ),
        const DrawerCard(
          svgAsset: 'assets/svg_images/drawer/servicing.svg',
          label: 'Bill Upload',
          destination: BillMain(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/quick-call.svg',
          label: 'Quick Call',
          onPressed: _makePhoneCall,
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
  final VoidCallback? onPressed;

  const DrawerCard({
    super.key,
    required this.svgAsset,
    required this.label,
    this.destination,
    this.badgeColor,
    this.imageColor = Colors.white,
    this.onPressed,
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
        if (onPressed != null) {
          onPressed!();
        } else if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destination!,
            ),
          );
        }
      },
    );
  }
}
