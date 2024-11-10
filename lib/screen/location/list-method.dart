import 'package:flutter/material.dart';

class ListMethod extends StatefulWidget {
  ListMethod({super.key});

  @override
  _ListMethodState createState() => _ListMethodState();
  final List<Map<String, String>> servicehistory = [
    {
      'date': '07 August, 2024',
      'items': 'Brake Pads, Wiper Blades,Air Filler',
      'price': 'Rs.25000'
    },
    {
      'date': '07 August, 2024',
      'items': 'Brake Pads, Wiper Blades,Air Filler',
      'price': 'Rs.25000'
    }
  ];
}

class _ListMethodState extends State<ListMethod> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/bus_route.png'),
                // SizedBox(width: getWidth(context) * 0.1),
                const Column(
                  children: [
                    Text(
                      'Route No: 33450',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('Total: 36 students'),
                    Text('Completed: 3/36'),
                    Text('Started: 8:03am, 10/21/2024')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
