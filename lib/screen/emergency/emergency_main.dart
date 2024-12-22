import 'package:driver_app/screen/dashboard/home_page.dart';
import 'package:driver_app/screen/emergency/emergency_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyMain extends StatelessWidget {
  const EmergencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Custom height
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
                            'report'.tr,
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SOS Button
            const CircleAvatar(
              radius: 70,
              backgroundColor: Color(0x33FF3333),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFF3333),
                child: Text(
                  'SOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Title
            Text(
              'Raise_alert'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Subtitle
            Text(
              'sub_msg'.tr,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            // Emergency options grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  EmergencyOption(
                      svgPath: 'assets/images/medical.png',
                      label: 'medical'.tr),
                  EmergencyOption(
                      svgPath: 'assets/images/accident.png',
                      label: 'accident'.tr),
                  EmergencyOption(
                      svgPath: 'assets/images/fire.png', label: 'fire'.tr),
                  EmergencyOption(
                      svgPath: 'assets/images/severe-weather.png',
                      label: 'weather'.tr),
                  EmergencyOption(
                      svgPath: 'assets/images/crisis.png', label: 'threat'.tr),
                  EmergencyOption(
                      svgPath: 'assets/images/magnifying-glass.png',
                      label: 'other'.tr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// EmergencyOption Widget for the grid items
class EmergencyOption extends StatelessWidget {
  final String svgPath;
  final String label;

  const EmergencyOption(
      {super.key, required this.svgPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff676767),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 0.5,
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(0.5, 0.5),
            )
          ]),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmergencyConfirmationPage()));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              svgPath,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
