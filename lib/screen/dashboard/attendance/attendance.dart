// lib/attendance.dart
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  Map<String, List<Map<String, String>>> contacts = {
    'A': [
      {'name': 'Aakash Kunwar', 'class': '5A', 'location': 'Kathmandu'},
      {'name': 'Aarohi', 'class': '4B', 'location': 'Lalitpur'},
      {'name': 'Aashish Bhai', 'class': '6C', 'location': 'Bhaktapur'},
      {'name': 'Amit Poudel', 'class': '3A', 'location': 'Pokhara'},
      {'name': 'Arun Bhai', 'class': '5B', 'location': 'Biratnagar'},
    ],
    'B': [
      {'name': 'Bage', 'class': '4A', 'location': 'Chitwan'},
      {'name': 'Bed', 'class': '7A', 'location': 'Janakpur'},
      {'name': 'Bharat Fupaju', 'class': '5C', 'location': 'Hetauda'},
      {'name': 'Bharat Sathi', 'class': '6A', 'location': 'Dharan'},
    ],
    'C': [
      {'name': 'Chandan', 'class': '6B', 'location': 'Mahendranagar'},
      {'name': 'Chandravardana', 'class': '7B', 'location': 'Nagarjuna'},
      {'name': 'Chandravani', 'class': '3B', 'location': 'Rameshwaram'},
    ],
    'D': [
      {'name': 'Dilip', 'class': '2A', 'location': 'Butwal'},
      {'name': 'Divya', 'class': '3C', 'location': 'Nepalgunj'},
      {'name': 'Dinesh', 'class': '4C', 'location': 'Rajbirajanagar'},
    ],
  };

  bool sortByName = false;
  bool sortByLocation = false;

  void sortContacts() {
    contacts.forEach((letter, namesList) {
      if (sortByName) {
        namesList.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (sortByLocation) {
        namesList.sort((a, b) => a['location']!.compareTo(b['location']!));
      }
    });
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
                value: sortByName,
                onChanged: (bool? value) {
                  setState(() {
                    sortByName = value ?? false;
                    sortByLocation =
                        false; // Uncheck location if name is selected
                    sortContacts();
                  });
                  Navigator.of(context).pop();
                },
              ),
              CheckboxListTile(
                title: const Text('By Location'),
                value: sortByLocation,
                onChanged: (bool? value) {
                  setState(() {
                    sortByLocation = value ?? false;
                    sortByName = false; // Uncheck name if location is selected
                    sortContacts();
                  });
                  Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.29),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.29,
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
                        elevation: 2,
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
                        elevation: 2,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 1,
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
                    elevation: 1,
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
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  String letter = contacts.keys.elementAt(index);
                  List<Map<String, String>> names = contacts[letter]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          letter,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...names.map((contact) => Card(
                            child: Padding(
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 5.0, vertical: 8),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      'assets/images/fake_profile.jpg',
                                      width: getHeight(context) * 0.07,
                                      height: getHeight(context) * 0.07,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: getHeight(context) * 0.01),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contact['name']!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Class: ${contact['class']}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff676767),
                                        ),
                                      ),
                                      Text(
                                        'Location: ${contact['location']}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff676767),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                      'assets/svg_images/present.svg'),
                                  SizedBox(width: getHeight(context) * 0.01),
                                  SvgPicture.asset(
                                      'assets/svg_images/absent.svg'),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(height: getHeight(context) * 0.015),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
