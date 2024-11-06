import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> items = [
    {'image': 'assets/images/attendance.svg', 'text': 'Attendance'},
    {'image': 'assets/images/fuel.svg', 'text': 'Fuel Tracking'},
    {'image': 'assets/images/report.svg', 'text': 'Report Issue'},
    {'image': 'assets/images/servicing.svg', 'text': 'Servicing'},
    {'image': 'assets/images/bill-upload.svg', 'text': 'Bill Upload'},
    {'image': 'assets/images/student-list.svg', 'text': 'Student List'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      drawer: const HomePageDrawer(),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(270),
        child: Stack(
          children: [
            // Background with a curved bottom
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: 245,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    // colors: [Colors.teal, Colors.greenAccent],
                    colors: [Color(0xff6bccc1), Color(0xff6dc69f)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Color(0xffcdeede),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: const Color(0xffcdeede),
                    cursorHeight: 16,
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                          onTap: () {
                            // Open the drawer when the menu icon is clicked
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Icon(Icons.menu)),
                      suffixIcon: const Icon(
                        Icons.notifications_on_outlined,
                        color: Color(0xfff24b3f),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 9), // Add padding here
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
            ),

            Positioned(
              top: 90,
              left: 10,
              right: 10,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.21,
                child: Card(
                  color: const Color(0xffd8f3e1),
                  // color: Colors.yellow,
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
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.06),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Lal Bahadur Ojha'),
                            const SizedBox(height: 5),
                            const Text('Bus No:Ba2 cha 9820'),
                            const SizedBox(height: 5),
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
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the entire body with a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Next Servicing Date',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  // SizedBox(width: MediaQuery.sizeOf(context).width * 0.04),
                  // const HugeIcon(
                  //   icon: HugeIcons.strokeRoundedWrench02,
                  //   color: Color(0xff686868),
                  //   size: 30.0,
                  // ),
                  Icon(
                    Icons.timer,
                    color: Color(0xff686868),
                    size: 20.0,
                  )
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
              const Text(
                'Quick Access',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              GridView.builder(
                shrinkWrap: true, // Ensure it doesn't take up infinite space
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling on the GridView itself
                // Number of items in the cross-axis (2 items per row)
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0, // Space between columns
                  mainAxisSpacing: 16.0, // Space between rows
                  childAspectRatio: 1.3, // Aspect ratio of each grid item
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Card(
                      elevation:
                          2, // Card's elevation will still give it some internal shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Rounded corners for the card
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              item['image'] ??
                                  '', // Load image from assets (with fallback)
                              height: 40, // Set a fixed size for the image
                              width: 40,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              item['text'] ?? '', // Text displayed in the card
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff60bf8f),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff36a674),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              // This centers the content in the DrawerHeader.
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centers Row content horizontally.
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Centers content vertically inside Row.
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Ensures column contents are centered vertically.
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Ensures column items are centered horizontally.
                      children: [
                        SvgPicture.asset(
                          'assets/images/fuel.svg', // Load image from assets
                          colorFilter: const ColorFilter.mode(
                              Colors.blue, BlendMode.lighten),
                          height: 20, // Set a fixed size for the image
                          width: 20,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'BLUE RIDGE',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff2078bf),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Ensures the texts are centered in the column.
                      children: [
                        Text(
                          'Bright Horizons School',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'GoSchool',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // First ListTile with icon and text
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.date_range_rounded,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  // Second ListTile with icon and text
                  ListTile(
                    leading: const Icon(Icons.settings,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Attendance',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  // Additional ListTile with icon and text
                  ListTile(
                    leading: const Icon(Icons.location_on,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Live Overview',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Maintenance',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.percent,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Fuel Tracking',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people_alt_outlined,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Servicing',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people_alt_outlined,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Bill Upload',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.call,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Quick Call',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Color(0xff5bb28d),
                    // color: Colors.amber,
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_mark_rounded,
                        color: Colors.white), // Icon for the item
                    title: const Text(
                      'Support',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Handle tap (navigate, etc.)
                    },
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: Color(0xfff24b3f),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Color(0xfff24b3f),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Clipper for a subtle curved background with rounded corners on the bottom left and right
// Custom Clipper for a path with steeper curves on the bottom left and right
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // Start from the top left corner
    path.lineTo(
        0,
        size.height -
            80); // Move down to the left bottom with some height for the curve

    // Create a steeper curve for the bottom left
    var controlPoint1 = Offset(size.width * 0.25,
        size.height + 30); // Adjust the control point for steepness
    var endPoint1 = Offset(size.width * 0.5,
        size.height - 20); // Midpoint stays lower for a straight line

    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);

    // Create a steeper curve for the bottom right
    var controlPoint2 = Offset(size.width * 0.75, size.height + 30);
    var endPoint2 = Offset(size.width,
        size.height - 80); // End at the right side, matching the left side

    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);

    path.lineTo(size.width, 0); // Draw the top line to the right side
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
