import 'dart:convert';

import 'package:driver_app/controller/Home/StudentListController.dart';
import 'package:driver_app/controller/Home/classListController.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:driver_app/core/widgets/responsive_text.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final controller = Get.put(StudentListController());
  final classcontroller = Get.put(classListController());

  String? classSelectedValue;
  String? locationSelectedValue;
  List<String> locationDropdownItems = [];
  List<String> classDropdownItems = [];

  @override
  void initState() {
    super.initState();
    controller.getStudentList();
    classcontroller.getClassList();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        locationDropdownItems = controller.list
            .where((data) => data.pickDropLocation?.busRoute != null)
            .map((data) => data.pickDropLocation!.busRoute!)
            .toSet()
            .toList();
      });
    });
  }

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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context) * 0.06,
                      ),
                      height: getHeight(context) * 0.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              "${controller.list.length}",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0b835c),
                              ),
                            ),
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
      body: Obx(() {
        if (controller.isLoadingStudentList.value ||
            controller.isLoadingClassList.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Generate sorted dropdown items dynamically
        List<String> classDropdownItems = classcontroller
            .classListModel.value!.result!
            .map((element) => "Class ${element.className} ${element.section}")
            .toList();
        return Column(
          children: [
            SizedBox(height: getHeight(context) * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 1,
                            spreadRadius: 0.5,
                            offset: const Offset(0.5, 0.5),
                          ),
                        ],
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
                              child: ResponsiveText(
                                item,
                                maxLines: 1,
                                fontSize: 12,
                                textOverflow: TextOverflow.ellipsis,
                              ),
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 1,
                            spreadRadius: 0.5,
                            offset: const Offset(0.5, 0.5),
                          ),
                        ],
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
            /////////////////////////////////
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: controller.list
                      .where((data) {
                        bool matchesClass = classSelectedValue == null ||
                            "Class ${data.className!.classNameClass} ${data.className!.section}" ==
                                classSelectedValue;
                        bool matchesLocation = locationSelectedValue == null ||
                            data.pickDropLocation?.busRoute ==
                                locationSelectedValue;

                        return matchesClass || matchesLocation;
                      })
                      .toList()
                      .length,
                  itemBuilder: (context, index) {
                    var filteredList = controller.list.where((data) {
                      bool matchesClass = classSelectedValue == null ||
                          "Class ${data.className!.classNameClass} ${data.className!.section}" ==
                              classSelectedValue;
                      bool matchesLocation = locationSelectedValue == null ||
                          data.pickDropLocation?.busRoute ==
                              locationSelectedValue;

                      return matchesClass || matchesLocation;
                    }).toList();

                    var data = filteredList[index];
                    if (filteredList.isEmpty) return Text("no value");

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 1,
                            spreadRadius: 0.5,
                            offset: const Offset(0.5, 0.5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 30,
                              minRadius: 30,
                              backgroundImage: data.profileImage == null ||
                                      data.profileImage == "fasle" ||
                                      data.profileImage == ""
                                  ? const AssetImage('assets/images/user.png')
                                  : MemoryImage(
                                      base64Decode(
                                        data.profileImage!.replaceFirst(
                                            'data:image/jpeg;base64,', ''),
                                      ),
                                    ),
                            ),
                            SizedBox(width: getHeight(context) * 0.01),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.fullName}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff221f1f),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  data.className != null
                                      ? "Class ${data.className!.classNameClass} ${data.className!.section}"
                                      : "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff676767),
                                  ),
                                ),
                                Text(
                                  data.pickDropLocation != null
                                      ? "${data.pickDropLocation!.busRoute}"
                                      : "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff676767),
                                  ),
                                ),
                                Text(
                                  data.contactNumber != null
                                      ? "${data.contactNumber}"
                                      : "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff676767),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                var phoneNumber =
                                    await "tel:${data.contactNumber}";
                                final Uri callUri = Uri.parse(phoneNumber);

                                if (await canLaunchUrl(callUri)) {
                                  await launchUrl(callUri);
                                } else {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      message: 'Cannot call phone',
                                      duration: Duration(seconds: 1),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.call),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
