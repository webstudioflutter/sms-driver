import 'dart:developer';

import 'package:driver_app/controller/SchoosettingController.dart';
import 'package:driver_app/screen/dashboard/home_page.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyConfirmationPage extends StatefulWidget {
  const EmergencyConfirmationPage({super.key});

  @override
  State<EmergencyConfirmationPage> createState() =>
      _EmergencyConfirmationPageState();
}

class _EmergencyConfirmationPageState extends State<EmergencyConfirmationPage> {
  final schoolsettingController controller = Get.put(schoolsettingController());

  @override
  void initState() {
    // TODO: implement initState
    controller.getSchoolSetting();
    super.initState();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Stream<Position>? positionStream;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request the user to enable them
      await Geolocator.openLocationSettings();
      return;
    }

    // Check and request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle accordingly
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle accordingly
      return;
    }
    // Create a position stream with a small distance filter (1 meter)
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1, // Detect movements as small as 1 meter
      ),
    );

    // Listen for position changes
    positionStream.listen((Position position) {
      log('Moved to: Lat: ${position.latitude}, Long: ${position.longitude}, Alt: ${position.altitude}');
    });

    // Get the current location
    Position position = await Geolocator.getCurrentPosition();
    // setState(() {
    //   userLocation = LatLng(position.latitude, position.longitude);
    //   // Center the map on the user's location
    //   mapController.move(userLocation!, currentZoom);
    // });

    // // Update location periodically
    // Geolocator.getPositionStream().listen((Position position) {
    //   setState(() {
    //     userLocation = LatLng(position.latitude, position.longitude);
    //     mapController.move(userLocation!, currentZoom);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Custom height
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 20,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xffff3333),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            'emergency'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                          ),
                        ],
                      ),
                      // child: TextFormField(
                      //   cursorColor: const Color(0xffcdeede),
                      //   decoration: InputDecoration(
                      //     hintText: "Emergency",
                      //     labelStyle: const TextStyle(color: Colors.white),
                      //     prefixIcon: IconButton(
                      //       icon: const Icon(Icons.arrow_back,
                      //           color: Colors.white),
                      //       onPressed: () {
                      //         Navigator.of(context).pop();
                      //       },
                      //     ),
                      //     border: InputBorder.none,
                      //     focusedBorder: InputBorder.none,
                      //     enabledBorder: InputBorder.none,
                      //     suffixIcon: IconButton(
                      //       icon: const Icon(Icons.close, color: Colors.white),
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => const HomePage()));
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
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
                getCurrentLocation();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainNavbar(),
                  ),
                  (route) => false,
                );
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const EmergencyConfirmedPage()));
              },
              child: const CircleAvatar(
                radius: 110,
                backgroundColor: Color(0x33FF3333),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.red,
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'btn_msg'.tr,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
