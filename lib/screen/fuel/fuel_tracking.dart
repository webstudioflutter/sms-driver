import 'package:flutter/material.dart';

class FuelTrackingMain extends StatefulWidget {
  const FuelTrackingMain({super.key});

  @override
  _FuelTrackingMainState createState() => _FuelTrackingMainState();
}

class _FuelTrackingMainState extends State<FuelTrackingMain> {
  double fuelQuantity = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Tracking'),
        centerTitle: true,
        backgroundColor: Colors.green.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.sunny, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quantity', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Slider(
              value: fuelQuantity,
              min: 5,
              max: 50,
              divisions: 5,
              label: '${fuelQuantity.round()}L',
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  fuelQuantity = value;
                });
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('5L'),
                Text('10L'),
                Text('20L'),
                Text('30L'),
                Text('50L'),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text('Odometer Reading', style: TextStyle(fontSize: 16)),
                Icon(Icons.info_outline, size: 18, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Reading on Odometer',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('ADD RECORD'),
            ),
          ],
        ),
      ),
    );
  }
}
