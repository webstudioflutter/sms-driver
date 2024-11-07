import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';

import 'emergency_confirmed.dart';

class EmergencyConfirmationPage extends StatelessWidget {
  const EmergencyConfirmationPage({super.key});

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
                      child: TextFormField(
                        cursorColor: const Color(0xffcdeede),
                        decoration: InputDecoration(
                          labelText: "Emergency",
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EmergencyMain()));
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
      ),
    );
  }
}
