import 'package:driver_app/controller/Home/AttendanceController.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';

class Attendance extends StatelessWidget {
  Attendance({super.key});

  final AttendanceController attendanceController =
      Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.26),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.26,
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
              top: MediaQuery.sizeOf(context).height * 0.05,
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
                          height: getHeight(context) * 0.09,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  // '25',
                                  "${attendanceController.presentStudent}",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0b835c),
                                  ),
                                ),
                              ),
                              Text(
                                'Present',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff1d1d1d),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                          height: getHeight(context) * 0.09,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  // '05',
                                  "${attendanceController.absentStudent}",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffe01e31),
                                  ),
                                ),
                              ),
                              Text(
                                'Absent',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff1d1d1d),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
      body: Obx(() {
        if (attendanceController.isLoading.value) {
          // Show loading spinner when data is being fetched
          return const Center(child: CircularProgressIndicator());
        }

        if (attendanceController.attendanceModel.value == null) {
          // Show error or no data message if the model is null
          return const Center(
            child: Text(
              'No attendance data available.',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final attendanceModel = attendanceController.attendanceModel.value!;
        if (attendanceModel.count == 0) {
          return const Center(child: Text('No attendance data available.'));
        }

        // Render attendance list
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: getHeight(context) * 0.01),
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
                        horizontal: 20,
                        vertical: 10,
                      ),
                      height: getHeight(context) * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.edit_square,
                            color: Color(0xff221f1f),
                          ),
                          SizedBox(width: getWidth(context) * 0.01),
                          const Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff363636),
                            ),
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
                            const Icon(Icons.swap_vert,
                                size: 30, color: Color(0xff221f1f)),
                            SizedBox(width: getWidth(context) * 0.01),
                            const Text(
                              'Sort',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff363636),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getHeight(context) * 0.01),
              Expanded(
                child: ListView.builder(
                  itemCount: attendanceModel.result?.length,
                  itemBuilder: (context, index) {
                    final contact = attendanceModel.result![index];
                    return Card(
                      child: Padding(
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 5.0, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/fake_profile.jpg',
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: getHeight(context) * 0.01),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.user?.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2b2b2b),
                                  ),
                                ),
                                Text(
                                  "Class:${contact.className?.className ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff345326),
                                  ),
                                ),
                                Text(
                                  "Location:${contact.user?.pickDropLocation}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff345326),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                // SizedBox(
                                //   width: getWidth(context) * 0.4,
                                //   child:
                                //   Text(
                                //     "Location:${contact.user?.pickDropLocation}",
                                //     style: const TextStyle(
                                //       fontSize: 12,
                                //       color: Color(0xff345326),
                                //     ),
                                //     overflow: TextOverflow.ellipsis,
                                //     maxLines: 1,
                                //   ),
                                // ),
                              ],
                            ),
                            const Spacer(),
                            ////Present
                            InkWell(
                              onTap: () {
                                if (contact.status == true) {
                                  attendanceController.markPresent();
                                }
                              },
                              child: SvgPicture.asset(
                                // 'assets/svg_images/present.svg',
                                // contact.status == true
                                //     ? 'assets/svg_images/present.svg'
                                //     :
                                'assets/svg_images/check-mark.svg',
                                color: Color(0xffb7b7b7),
                                height: 44,
                                width: 44,
                              ),
                            ),
                            SizedBox(width: getHeight(context) * 0.01),

                            ////Absent
                            InkWell(
                              onTap: () {
                                if (contact.status == false) {
                                  attendanceController.markAbsent();
                                }
                              },
                              child: SvgPicture.asset(
                                // 'assets/svg_images/absent.svg',
                                // contact.status == false
                                //     ? 'assets/svg_images/absent.svg'
                                'assets/svg_images/default-absent.svg',

                                height: 44,
                                width: 44,
                              ),
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
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff60bd8f),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(8.0), // Adjust the radius as needed
            ),
          ),
          onPressed: () {},
          child: Text(
            'Confirm Attendance',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
                value: attendanceController.sortParameter.value == 'name',
                onChanged: (bool? value) {
                  attendanceController.sortParameter.value = 'name';
                  attendanceController.sortAttendance();
                  Navigator.of(context).pop();
                },
              ),
              CheckboxListTile(
                title: const Text('By Location'),
                value: attendanceController.sortParameter.value == 'location',
                onChanged: (bool? value) {
                  attendanceController.sortParameter.value = 'location';
                  attendanceController.sortAttendance();
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
}
