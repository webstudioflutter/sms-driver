import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(270),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background with a curved bottom
            Container(
              height: 191,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff6bccc1),
                      Color(0xff6fcf99)
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
              right: 10,
              left: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 50, // Height of the container
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                        color: Color(0xffcdeede),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                        const Spacer(),
                        const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                                Icons.notifications_active_outlined)),
                      ],
                    )),
              ),
            ),

            Positioned(
              bottom: -95,
              right: 10,
              left: 10,
              child: SizedBox(
                // height: MediaQuery.sizeOf(context).height * 0.21,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/fake_profile.jpg',
                              height: 120,
                              width:
                                  120, // Make sure width and height are the same to ensure a perfect circle
                              fit: BoxFit
                                  .cover, // Ensure the image covers the circle without distortion
                            ),
                          ),
                          Positioned(
                              right: -5,
                              bottom: 10,
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.edit_square,
                                    size: 25,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                      const Text(
                        'Lal Bahadur Ojha',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text('License No: 4048683576'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 110.0, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg_images/profile.svg'),
                            const SizedBox(width: 10),
                            const Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('General Information'),
                                  Text(
                                    'View your personal and work details',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset('assets/svg_images/warning.svg'),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.chevron_right,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg_images/lock.svg'),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Face ID / Touch ID'),
                                Text(
                                  'Manage your device security',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 5),
                            const Spacer(),
                            Switch(value: false, onChanged: (value) {})
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg_images/logout.svg'),
                            const SizedBox(width: 10),
                            const Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Log out'),
                                  Text(
                                    'Further secure your account for safety',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.chevron_right,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Text('More'),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 5),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg_images/notification2.svg'),
                    const SizedBox(width: 10),
                    const Text(
                      'Help & Support',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.chevron_right,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
