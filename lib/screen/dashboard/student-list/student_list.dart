import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  String? classSelectedValue;
  String? locationSelectedValue;
  List<String> classDropdownItems = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4'
  ];
  List<String> locationDropdownItems = [
    'Baneshowar',
    'Ratnapark',
    'Kalopul',
    'Setopul'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.28),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.28,
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
              top: MediaQuery.sizeOf(context).height * 0.06,
              right: 10,
              left: 10,
              child: Column(
                children: [
                  PageTitleBar(
                    firstIconAction: () {
                      Navigator.pop(context);
                    },
                    lastIconAction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmergencyMain(),
                          ));
                    },
                    title: 'Student List',
                    firstIcon: Icons.arrow_back,
                    lastWidget: SvgPicture.asset(
                        'assets/svg_images/notification.svg',
                        height: 20),
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
                            '25',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0b835c)),
                          ),
                          Text(
                            'Total Student',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff221f1f),
                            ),
                          ),
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
      body: Column(
        children: [
          SizedBox(height: getHeight(context) * 0.01),

          ///Edit and Sort
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      child: DropdownButton<String>(
                        value: classSelectedValue,
                        hint: const Text(
                          'Class',
                          style: TextStyle(
                            color: Color(0xff221f1f),
                          ),
                        ),
                        iconEnabledColor: Color(0xff221f1f),
                        items: classDropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            classSelectedValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: getWidth(context) * 0.02),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      height: getHeight(context) * 0.06,
                      child: DropdownButton<String>(
                        value: locationSelectedValue,
                        hint: const Text(
                          'Location',
                          style: TextStyle(
                            color: Color(0xff221f1f),
                          ),
                        ),
                        iconEnabledColor: Color(0xff221f1f),
                        items: locationDropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            locationSelectedValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: getHeight(context) * 0.02),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 16),
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
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sahadev Kunwar',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff221f1f),
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    'Class: 5A ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff676767),
                                    ),
                                  ),
                                  Text(
                                    ' Location: Kathmandu',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff676767),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Gender: Male',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff676767),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_sharp)),
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
          ),
        ],
      ),
    );
  }
}
