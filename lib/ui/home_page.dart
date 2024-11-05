import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> items = [
    {'icon': Icons.home, 'text': 'Attendance'},
    {'icon': Icons.search, 'text': 'Fuel Tracking'},
    {'icon': Icons.notifications, 'text': 'Report Issue'},
    {'icon': Icons.settings, 'text': 'Servicing'},
    {'icon': Icons.person, 'text': 'Bill Upload'},
    {'icon': Icons.person, 'text': 'Student List'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.35),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    color: Color(0xffcdeede),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextFormField(
                  autofocus: true,
                  cursorColor: const Color(0xffcdeede),
                  cursorHeight: 16,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.menu),
                    suffixIcon: Icon(Icons.notifications),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 9), // Add padding here
                    hintText: 'Search',
                    // Customize hint text color
                    border: InputBorder.none, // Remove the border
                    focusedBorder:
                        InputBorder.none, // Remove the focused border
                    enabledBorder:
                        InputBorder.none, // Remove the enabled border
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
              child: Card(
                color: const Color(0xffd8f3e1),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          color: Colors.grey,
                          child: const FlutterLogo(
                            size: 80,
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.06),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Lal Bahadur Ojha'),
                          const SizedBox(height: 10),
                          const Text('Bus No:Ba2 cha 9820'),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 35,
                              width: MediaQuery.sizeOf(context).width * 0.43,
                              decoration: BoxDecoration(
                                color: const Color(0xffff6448),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Start Route',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the entire body with a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Next Servicing Date'),
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.04),
                  const Icon(Icons.settings),
                  const Icon(Icons.timer)
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const Text('5th November'),
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.04),
                  Text(
                    '13 days from today',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
              const Text('Quick Access'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true, // Ensure it doesn't take up infinite space
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling on the GridView itself
                  // Number of items in the cross-axis (2 items per row)
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0, // Space between columns
                    mainAxisSpacing: 16.0, // Space between rows
                    childAspectRatio: 1, // Aspect ratio of each grid item
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(item['icon'], color: Colors.blue, size: 30),
                            const SizedBox(height: 8.0),
                            Text(
                              item['text'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
