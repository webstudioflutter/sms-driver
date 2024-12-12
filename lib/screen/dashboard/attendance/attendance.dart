import 'dart:convert'; // For JSON encoding/decoding
import 'dart:developer';

import 'package:driver_app/Repository/vechileAttendanceRepository.dart';
import 'package:driver_app/controller/Home/AttendanceController.dart';
import 'package:driver_app/controller/Home/StudentListController.dart';
import 'package:driver_app/controller/UpdateAttandanceController.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:driver_app/core/widgets/responsive_text.dart';
import 'package:driver_app/screen/dashboard/attendance/pickedattendance/updateAttendance.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Attendance extends StatefulWidget {
  Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final controller = Get.put(StudentListController());
  Map<String, String> attendanceMap = {}; // To track attendance
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  var pickdrop;
  void checkif() async {
    pickdrop = await _secureStorage.read(key: 'pickdrop');
    if (pickdrop == "DROPPED") {}
  }

  final updatecontroller = Get.put(vechileattandancebyprops());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getStudentList(); // Fetch data after the initial build
    });
    _checkAndResetAttendanceState();
  }

  void _showattandanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Center(child: const Text("Confirm")),
          content: const Text("Do you really want to Submit?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                selectionColor: Colors.red,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                await resetAttendanceState();

                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavbar(),
                    ),
                    (route) => false,
                  );
                });
              },
            ),
            TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
          ],
        ),
      ),
    );
  }

  Future<void> resetAttendanceState() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      attendanceMap.clear(); // Reset attendance
    });
    await prefs.remove('attendanceMap'); // Remove attendance data
    await prefs.remove('lastUpdateDate'); // Reset the date
    // controller.getStudentList();
    // Notify other parts of the app if needed
    log('Attendance state has been reset.');
  }

  // Load attendance data from SharedPreferences
  Future<void> _loadAttendanceState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAttendance = prefs.getString('attendanceMap');
    if (savedAttendance != null) {
      setState(() {
        attendanceMap = Map<String, String>.from(json.decode(savedAttendance));
      });
    }
  }

  // Save attendance data to SharedPreferences
  Future<void> _saveAttendanceState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('attendanceMap', json.encode(attendanceMap));

    // Save today's date
    final today = DateTime.now().toIso8601String().split('T')[0];
    await prefs.setString('lastUpdateDate', today);
  }

  // Check if the attendance state needs to be reset
  Future<void> _checkAndResetAttendanceState() async {
    final prefs = await SharedPreferences.getInstance();

    // Get the last update date
    final lastUpdateDate = prefs.getString('lastUpdateDate');
    final today = DateTime.now().toIso8601String().split('T')[0];

    // If the date is different or not saved, reset the attendance state
    if (lastUpdateDate == null || lastUpdateDate != today) {
      setState(() {
        attendanceMap.clear(); // Reset attendance
      });
      await prefs.remove('attendanceMap'); // Clear saved attendance data
      await prefs.setString('lastUpdateDate', today); // Save today's date
    } else {
      // Load the saved attendance state
      await _loadAttendanceState();
    }
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
                    firstIconAction: () => Navigator.pop(context),
                    lastIconAction: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmergencyMain()),
                    ),
                    title: pickdrop == "DROPPED"
                        ? 'Dropped Attendance'
                        : 'Picked Attendance',
                    firstIcon: Icons.arrow_back,
                    lastWidget: SvgPicture.asset(
                      'assets/svg_images/notification.svg',
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCounterBox(
                        count: attendanceMap.values
                            .where((status) => status == "Present")
                            .length,
                        label: "Present",
                        color: Color(0xff0b835c),
                      ),
                      _buildCounterBox(
                        count: attendanceMap.values
                            .where((status) => status == "Absent")
                            .length,
                        label: "Absent",
                        color: Color(0xffe01e31),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          _showattandanceDialog(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          height: 50,
          width: width * 0.8,
          child: Center(
            child: Text(
              'Confirm',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: getHeight(context) * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  final _secureStorage = const FlutterSecureStorage();
                  var schoolId = await _secureStorage.read(key: 'schoolId');
                  var transportationId =
                      await _secureStorage.read(key: 'transportationId');
                  var updatedata = {
                    "schoolId": "${schoolId}",
                    "date": "${formattedDate}",
                    "transportationId": "67189289a610cd23428ebc55"
                  };
                  attandancebyprops.getbyprops(updatedata);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateAttendance(),
                    ),
                  );
                },
                child: Container(
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
              ),
              SizedBox(width: getWidth(context) * 0.02),
              GestureDetector(
                onTap: () {
                  showSortDialog(context);
                },
                child: Container(
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
          Obx(() {
            if (controller.isLoadingStudentList.value) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: height * 0.6,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    final data = controller.list[index];
                    final studentId = data.id; // Assume student has a unique ID
                    return _buildStudentTile(
                      data: data,
                      isPresent: attendanceMap[studentId] == "Present",
                      isAbsent: attendanceMap[studentId] == "Absent",
                      onPresentTap: () async {
                        if (!attendanceMap.containsKey(studentId)) {
                          setState(() {
                            attendanceMap[studentId!] = "Present";
                          });
                          _saveAttendanceState(); // Save state
                          var transportID = await _secureStorage.read(
                              key: 'transportationId');
                          var transportname = await _secureStorage.read(
                              key: 'transporationName');
                          var school =
                              await _secureStorage.read(key: 'schoolId');

                          var pickdrop =
                              await _secureStorage.read(key: 'pickdrop');
                          var dataofstd = {
                            // "schoolId": "${school}",
                            "schoolId": "@nidisecondaryschool",
                            "date": "${formattedDate}",
                            "attendaceType": "${pickdrop}",
                            "user": {
                              "_id": data.id,
                              "name": "${data.fullName}",
                              "profileImage": "${data.profileImage}",
                              "pickDropLocation":
                                  "${data.pickDropLocation!.busRoute}"
                            },
                            "class": {
                              "_id": "${data.className!.id}",
                              "className": "${data.className!.classNameClass}"
                            },
                            "transportation": {
                              "_id": "67189289a610cd23428ebc55",

                              // "_id": "${transportID}",
                              // "name": "${transportname}"
                              "name": "5580"
                            },
                            "time": "${formattedTime}",
                            "status": true
                          };
                          vechileattendanceRepository.AttendanceData(dataofstd);
                        }
                      },
                      onAbsentTap: () async {
                        if (!attendanceMap.containsKey(studentId)) {
                          setState(() {
                            attendanceMap[studentId!] = "Absent";
                          });
                          _saveAttendanceState(); // Save state
                          var transportID = await _secureStorage.read(
                              key: 'transportationId');
                          var transportname = await _secureStorage.read(
                              key: 'transporationName');
                          var school =
                              await _secureStorage.read(key: 'schoolId');

                          var pickdrop =
                              await _secureStorage.read(key: 'pickdrop');
                          var dataofstd = {
                            // "schoolId": "${school}",
                            "schoolId": "@nidisecondaryschool",
                            "date": "${formattedDate}",
                            "attendaceType": "${pickdrop}",
                            "user": {
                              "_id": data.id,
                              "name": "${data.fullName}",
                              "profileImage": "${data.profileImage}",
                              "pickDropLocation":
                                  "${data.pickDropLocation!.busRoute}"
                            },
                            "class": {
                              "_id": "${data.className!.id}",
                              "className": "${data.className!.classNameClass}"
                            },
                            "transportation": {
                              "_id": "67189289a610cd23428ebc55",

                              // "_id": "${transportID}",
                              // "name": "${transportname}"
                              "name": "5580"
                            },
                            "time": "${formattedTime}",
                            "status": false
                          };
                          vechileattendanceRepository.AttendanceData(dataofstd);
                        }
                      },
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCounterBox(
      {required int count, required String label, required Color color}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
            horizontal: MediaQuery.sizeOf(context).width * 0.06),
        height: MediaQuery.sizeOf(context).height * 0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$count",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff1d1d1d),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentTile({
    required dynamic data,
    required bool isPresent,
    required bool isAbsent,
    required VoidCallback onPresentTap,
    required VoidCallback onAbsentTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
        padding: const EdgeInsets.all(16),
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
                        data.profileImage!
                            .replaceFirst('data:image/jpeg;base64,', ''),
                      ),
                    ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).height * 0.01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getWidth(context) * 0.3,
                  child: ResponsiveText(
                    data.fullName ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2b2b2b),
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: getWidth(context) * 0.3,
                  child: ResponsiveText(
                    "Class:${data.contactNumber ?? ""}",
                    style: const TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xff345326),
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: getWidth(context) * 0.3,
                  child: Text(
                    data.pickDropLocation != null
                        ? "Location: ${data.pickDropLocation!.busRoute}"
                        : "Location: kathmandu",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff345326),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                InkWell(
                  hoverColor: Colors.grey,
                  onTap: isPresent ? null : onPresentTap,
                  child: SvgPicture.asset(
                    'assets/svg_images/present.svg',
                    height: 44,
                    width: 44,
                    color: isPresent ? Colors.green : null,
                  ),
                ),
                SizedBox(width: 20),
                InkWell(
                  hoverColor: Colors.grey,
                  onTap: isAbsent ? null : onAbsentTap,
                  child: SvgPicture.asset(
                    'assets/svg_images/absent.svg',
                    height: 44,
                    width: 44,
                    color: isAbsent ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSortDialog(BuildContext context) {
    bool? value;
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
                onChanged: (value) {
                  value != value;
                  controller.sortListByName();
                  Navigator.of(context).pop();
                },
              ),
              CheckboxListTile(
                title: const Text('By Location'),
                value: attendanceController.sortParameter.value == 'location',
                onChanged: (value) {
                  value != value;
                  controller.sortListByLocation();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: const Text('Close'),
          //   ),
          // ],
        );
      },
    );
  }
}
