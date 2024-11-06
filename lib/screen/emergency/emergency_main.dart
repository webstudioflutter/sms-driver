import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'emergency_confirmation.dart';

class EmergencyMain extends StatelessWidget {
  const EmergencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BillMain()));
          },
        ),
        title: const Text("Report", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // SOS Button
            const CircleAvatar(
              radius: 70,
              backgroundColor: Color(0x33FF3333), // Red color with 20% opacity
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffFF3333), // Fully opaque red
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
            const Text(
              'Raise SOS Alert',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Subtitle
            const Text(
              'Only use SOS in emergencies',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            // Emergency options grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: const [
                  EmergencyOption(
                      svgPath: 'assets/svg_images/history.svg',
                      label: 'Medical Emergency'),
                  EmergencyOption(
                      svgPath: 'assets/svg_images/bill.svg', label: 'Accident'),
                  EmergencyOption(
                      svgPath: 'assets/svg_images/fire.svg', label: 'Fire'),
                  EmergencyOption(
                      svgPath: 'assets/svg_images/weather.svg',
                      label: 'Severe Weather'),
                  EmergencyOption(
                      svgPath: 'assets/svg_images/security.svg',
                      label: 'Security Threat'),
                  EmergencyOption(
                      svgPath: 'assets/svg_images/others.svg', label: 'Others'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyOption extends StatelessWidget {
  final String svgPath;
  final String label;

  const EmergencyOption({
    super.key,
    required this.svgPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmergencyConfirmationPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: SvgPicture.asset(
                svgPath,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

