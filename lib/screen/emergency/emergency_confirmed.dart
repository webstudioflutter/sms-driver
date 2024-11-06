import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';

class EmergencyConfirmedPage extends StatelessWidget {
  const EmergencyConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmergencyMain()),
                    );
                  },
                ),
                const Text(
                  "Emergency",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    width:
                        48), // Add space equal to IconButton to center the title
              ],
            ),
          ),
          const SizedBox(height: 40),
          // SOS Alert Circle
          const CircleAvatar(
            radius: 110,
            backgroundColor: Color(0x33ffffff),
            child: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.white,
              child: Text(
                'SOS',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'SOS alert activated. Help is on the way. Stay calm and safe.',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
