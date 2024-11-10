import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Attendance extends StatelessWidget {
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.3),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.3,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff6bccc1), Color(0xff6fcf99)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.07,
              right: 10,
              left: 10,
              child: Column(
                children: [
                  PageTitleBar(
                    firstIconAction: () {
                      Navigator.pop(context);
                    },
                    title: 'Attendance',
                    firstIcon: Icons.arrow_back,
                    lastWidget: SvgPicture.asset(
                        'assets/svg_images/notification.svg',
                        height: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context) * 0.06,
                          ),
                          height: getHeight(context) * 0.1,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '25',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0b835c)),
                              ),
                              Text('Present'),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context) * 0.06,
                          ),
                          height: getHeight(context) * 0.1,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '05',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffe01e31)),
                              ),
                              Text('Absent'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(height: getHeight(context) * 0.02),

            ///Edit and Sort
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: getHeight(context) * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit_square),
                        SizedBox(width: getWidth(context) * 0.01),
                        const Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: getWidth(context) * 0.02),
                GestureDetector(
                  onTap: () {
                    showSortDialog(context);
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      height: getHeight(context) * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.swap_vert, size: 30),
                          SizedBox(width: getWidth(context) * 0.01),
                          const Text(
                            'Sort',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight(context) * 0.04),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8),
                      child: Row(
                        children: [
                          // Container(
                          //   decoration: const BoxDecoration(
                          //     shape: BoxShape.circle,
                          //   ),
                          //   child: ClipOval(
                          //     child: Image.asset(
                          //       'assets/images/fake_profile.jpg',
                          //       height: getHeight(context) * 0.07,
                          //       width: getHeight(context) * 0.07,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),

                          ClipOval(
                            child: Image.asset(
                              'assets/images/fake_profile.jpg',
                              width: getHeight(context) * 0.07,
                              height: getHeight(context) * 0.07,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(width: getHeight(context) * 0.01),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sahadev Kunwar',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Class: 5A',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff345326),
                                ),
                              ),
                              Text(
                                'Location: Kathmandu',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff345326),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SvgPicture.asset('assets/svg_images/present.svg'),
                          SizedBox(width: getHeight(context) * 0.01),
                          SvgPicture.asset('assets/svg_images/absent.svg'),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: getHeight(context) * 0.015);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Align(
            alignment: Alignment.center,
            child: Text('Sort By'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                title: const Text('By Name'),
                value: true, // Set to true for demonstration
                onChanged: (bool? value) {
                  // Handle change
                },
              ),
              CheckboxListTile(
                title: const Text('By Location'),
                value: false,
                onChanged: (bool? value) {
                  // Handle change
                },
              ),
              CheckboxListTile(
                title: const Text('By Name'),
                value: false,
                onChanged: (bool? value) {
                  // Handle change
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
