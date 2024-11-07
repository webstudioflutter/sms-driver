import 'package:driver_app/screen/emergency/emergency_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmergencyMain extends StatelessWidget {
  const EmergencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90), // Custom height
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
                      child: TextFormField(
                        cursorColor: const Color(0xffcdeede),
                        decoration: InputDecoration(
                          labelText: "Report",
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              // Handle back action if necessary
                            },
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
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
                radius: 50,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
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

// EmergencyOption Widget for the grid items
class EmergencyOption extends StatelessWidget {
  final String svgPath;
  final String label;

  const EmergencyOption(
      {super.key, required this.svgPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
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
            SvgPicture.asset(
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
