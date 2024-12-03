import 'package:driver_app/controller/Home/AttendanceController.dart';
import 'package:driver_app/controller/Home/StudentListController.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Attendance extends StatefulWidget {
  Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());

  final controller = Get.put(StudentListController());

  @override
  void initState() {
    super.initState();
    controller.getStudentList();
    Future.delayed(Duration(seconds: 1), () {
      // setState(() {
      //   locationDropdownItems = controller.list
      //       .where((data) => data.pickDropLocation?.busRoute != null)
      //       .map((data) => data.pickDropLocation!.busRoute!)
      //       .toSet()
      //       .toList();
      // });
    });
  }

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
                      Container(
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
                      Container(
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
        if (controller.isLoadingClassList.value) {
          // Show loading spinner when data is being fetched
          return const Center(child: CircularProgressIndicator());
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
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                    child: Container(
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
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    final data = controller.list[index];

                    false;
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
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 5.0, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/fakeprofile.jpg',
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
                                  data.fullName ?? "",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2b2b2b),
                                  ),
                                ),
                                Text(
                                  "Class:${data.contactNumber ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff345326),
                                  ),
                                ),
                                Text(
                                  "Location:${data.pickDropLocation!.busRoute}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff345326),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const Spacer(),

                            // Present Button
                            // Obx(() {
                            //   final status = attendanceController
                            //       .attendanceStatus[studentId];
                            //   return InkWell(
                            //     onTap: () =>
                            //         attendanceController.markPresent(studentId),
                            //     child: SvgPicture.asset(
                            //       status == true
                            //           ? 'assets/svg_images/check-mark.svg'
                            //           : 'assets/svg_images/default-present.svg',
                            //       height: 44,
                            //       width: 44,
                            //     ),
                            //   );
                            // }),
                            Obx(() {
                              // final id = attendanceController
                              //     .attendanceModel.value?.result![index].sId;
                              return InkWell(
                                onTap: () => attendanceController
                                    .updateStudentStatus(index, true),
                                child: SvgPicture.asset(
                                  'assets/svg_images/present.svg',
                                  height: 44,
                                  width: 44,
                                  color: attendanceController.attendanceModel
                                              .value?.result![index].status ==
                                          true
                                      ? Colors.green
                                      : null,
                                ),
                              );
                            }),

                            SizedBox(width: getHeight(context) * 0.01),
                            // Absent Button
                            Obx(() {
                              // final status = attendanceController
                              //     .attendanceStatus[studentId];
                              return InkWell(
                                onTap: () => attendanceController
                                    .updateStudentStatus(index, false),
                                child: SvgPicture.asset(
                                  attendanceController.attendanceModel.value
                                              ?.result![index].status ==
                                          false
                                      ? 'assets/svg_images/default-absent.svg'
                                      : 'assets/svg_images/absent.svg',
                                  height: 44,
                                  width: 44,
                                ),
                              );
                            }),
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
