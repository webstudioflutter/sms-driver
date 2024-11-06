import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';

import 'emergency_confirmed.dart';

class EmergencyConfirmationPage extends StatelessWidget {
  const EmergencyConfirmationPage({super.key});

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
                MaterialPageRoute(builder: (context) => const EmergencyMain()));
          },
        ),
        title: const Text("Emergency", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmergencyConfirmedPage()));
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
          const Text(
            'By clicking this red button, you\'re activating the SOS alert, sharing your live location, and placing an emergency call.',
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
