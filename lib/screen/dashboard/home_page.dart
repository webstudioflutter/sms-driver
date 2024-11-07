import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();

  List<Map<String, dynamic>> items = [
    {'image': 'assets/svg_images/attendance.svg', 'text': 'Attendance'},
    {'image': 'assets/svg_images/fuel.svg', 'text': 'Fuel Tracking'},
    {'image': 'assets/svg_images/report.svg', 'text': 'Report Issue'},
    {'image': 'assets/svg_images/servicing.svg', 'text': 'Servicing'},
    {'image': 'assets/svg_images/bill-upload.svg', 'text': 'Bill Upload'},
    {'image': 'assets/svg_images/student-list.svg', 'text': 'Student List'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset:
          true, // This ensures the UI resizes when the keyboard appears
      key: _scaffoldKey, // Assign the key to the Scaffold
      drawer: const HomePageDrawer(),

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(270),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background with a curved bottom
              Container(
                height: 190,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff59CDDA),
                        Color(0xff60BF8F)
                      ], // Gradient colors
                      begin: Alignment.topLeft, // Start point of gradient
                      end: Alignment.bottomRight, // End point of gradient
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
              ),
              Positioned(
                top: 20,
                left: 10,
                right: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50, // Height of the container
                        decoration: const BoxDecoration(
                            color: Color(0xffcdeede),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg_images/menu.svg'),
                            SvgPicture.asset(
                                'assets/svg_images/notification.svg'),
                          ],
                        ),
                        // TextFormField(
                        //   controller: _searchController,
                        //   cursorColor: const Color(0xffcdeede),
                        //   // cursorHeight: 16,
                        //   decoration: InputDecoration(
                        //     prefixIcon: GestureDetector(
                        //         onTap: () {
                        //           // Open the drawer when the menu icon is clicked
                        //           _scaffoldKey.currentState?.openDrawer();
                        //         },
                        //         child: const Icon(Icons.menu, size: 100)
                        //         //     SvgPicture.asset(
                        //         //   'assets/svg_images/menu.svg', // Load image from assets
                        //         //   height: 20, // Adjust size for the menu icon
                        //         //   width: 10, // Adjust size for the menu icon
                        //         // ),
                        //         ),
                        //     suffixIcon: Icon(Icons.notifications_active_sharp,
                        //         color: Colors.red.shade500),
                        //     //     SvgPicture.asset(
                        //     //   'assets/svg_images/notification.svg', // Load image from assets
                        //     //   height: 20, // Adjust size for the notification icon
                        //     //   width: 20, // Adjust size for the notification icon
                        //     // ),
                        //     // contentPadding: const EdgeInsets.symmetric(
                        //     //   horizontal:
                        //     //       15.0, // Adjust the left and right padding for better spacing
                        //     //   vertical:
                        //     //       10, // Adjust the vertical padding for better height alignment
                        //     // ),
                        //     border: InputBorder.none, // Remove the border
                        //     focusedBorder:
                        //         InputBorder.none, // Remove the focused border
                        //     enabledBorder:
                        //         InputBorder.none, // Remove the enabled border
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.21,
                      child: Card(
                        color: const Color(0xffd8f3e1),
                        // color: Colors.yellow,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 15, left: 30, top: 20, bottom: 20),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/fake_profile.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(80),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xffB4E6C8),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  border: Border.all(
                                      width: 1,
                                      color: const Color(0xffB4E6C8))),
                            ),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.06),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Lal Bahadur Ojha',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff221F1F))),
                                const SizedBox(height: 13),
                                const Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'Bus No:Ba2 cha 9820',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff221F1F)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    _openModalBottomSheetForStartRoute(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffff6448),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Start Route',
                                        style: TextStyle(
                                            color: Color(0xffFEFEFE),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
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
                  ],
                ),
              ),
            ],
          ),
        ),

        body: Padding(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: MediaQuery.of(context).size.height * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Next Servicing Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff363636),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/svg_images/scheduled-maintenance.svg',
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const Text(
                    '5th November',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff221f1f),
                    ),
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.04),
                  const Text(
                    '13 days from today',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff999999),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              const Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff363636),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        ///Perform navigation for Quick Access Items like this
                        if (index == 0) {
                        } else if (index == 1) {
                        } else if (index == 2) {
                        } else if (index == 3) {
                        } else if (index == 4) {
                        } else if (index == 5) {}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  item['image'] ?? '',
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  item['text'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff60bf8f),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  void _openModalBottomSheetForStartRoute(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Enter Today's Starting KM",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff60bf8f),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Colors.green)),
                        child: TextFormField(
                          controller: _routeController,
                          textAlign: TextAlign.center,
                          cursorColor: const Color(0xffcdeede),
                          cursorHeight: 16,
                          decoration: InputDecoration(
                            hintText: 'XXX-XXX-XX',
                            hintStyle: TextStyle(color: Colors.grey.shade200),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 9),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          _openModalBottomSheetForPickDrop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0xff60bf8f),
                          ),
                          child: const Center(
                            child: Text(
                              'Start Route',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -30,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/svg_images/green-notification.svg',
                    height: 55,
                    width: 55,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openModalBottomSheetForPickDrop(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 195, 235, 227),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 90,
                    width: 139,
                    child: const Center(
                      child: Text(
                        'PICK UP',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff186444),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: Color(0xff8df3e1),
                      color: const Color.fromARGB(255, 195, 235, 227),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 90,
                    width: 139,
                    child: const Center(
                      child: Text(
                        'DROP OFF',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff186444),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -30,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/svg_images/green-notification.svg',
                height: 55,
                width: 55,
              ),
            ),
          ],
        );
      },
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/fuel.svg', // Load image from assets
                          colorFilter: const ColorFilter.mode(
                              Colors.blue, BlendMode.lighten),
                          height: 20,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BillMain()));
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
