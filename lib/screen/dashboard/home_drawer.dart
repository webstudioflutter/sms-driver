import 'dart:convert';

import 'package:driver_app/controller/SchoosettingController.dart';
import 'package:driver_app/core/utils/asset_provider.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:driver_app/screen/fuel/fuel_tracking.dart';
import 'package:driver_app/screen/map/maps.dart';
import 'package:driver_app/screen/servicing/servicing_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({
    super.key,
  });

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  final schoolsettingController controller = Get.put(schoolsettingController());

  @override
  void initState() {
    // TODO: implement initState
    controller.getSchoolSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: height,
        color: const Color(0xff36a674),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context) * 0.09,
                  left: 10,
                  bottom: getHeight(context) * 0.01,
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Obx(() {
                        return CircleAvatar(
                          maxRadius: getHeight(context) * 0.04,
                          minRadius: getHeight(context) * 0.02,
                          backgroundImage: controller.list.first.schoolLogo ==
                                      null ||
                                  controller.list.first.schoolLogo == "fasle" ||
                                  controller.list.first.schoolLogo == ""
                              ? const AssetImage('assets/images/user.png')
                              : MemoryImage(
                                  base64Decode(
                                    controller.list.first.schoolLogo!
                                        .replaceFirst(
                                            'data:image/jpeg;base64,', ''),
                                  ),
                                ),
                        );
                      }),
                    ),
                    SizedBox(width: getWidth(context) * 0.04),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            "${controller.list.first.schoolId}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            "Offday: ${controller.list.first.offDays!.first}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(child: _buildDrawerOptions(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerOptions(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 8.0),
      children: [
        // DrawerCard(
        //   svgAsset: 'assets/svg_images/drawer/attendance.svg',
        //   label: 'Attendance',
        //   destination: Attendance(),
        // ),
        DrawerCard(
          svgAsset: 'assets/svg_images/location.svg',
          label: 'Live Overview',
          destination: MapTrackingPage(),
        ),
        // const DrawerCard(
        //   svgAsset: 'assets/svg_images/drawer/maintenance.svg',
        //   label: 'Servicing',
        //   destination: ServicingMain(),
        // ),
        DrawerCard(
          svgAsset: Assets.svgImages.fuel,
          label: 'Fuel Re-Filling',
          destination: FuelTrackingMain(),
        ),
        DrawerCard(
          svgAsset: Assets.svgImages.servicing,
          label: 'Servicing',
          destination: ServicingMain(),
        ),
        DrawerCard(
          svgAsset: Assets.svgImages.billupload,
          label: 'Bill Upload',
          destination: BillMain(),
        ),
        DrawerCard(
          svgAsset: 'assets/svg_images/drawer/quick-call.svg',
          label: 'Quick Call',
          onPressed: () async {
            final Uri phoneUri = Uri(
              scheme: 'tel',
              path: controller.list.first.contactNo != ""
                  ? "${controller.list.first.contactNo}"
                  : '1234567890', // Replace with your desired phone number
            );

            if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri);
            } else {
              throw 'Could not launch $phoneUri';
            }
          },
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
