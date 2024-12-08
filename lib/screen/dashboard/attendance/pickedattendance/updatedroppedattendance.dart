import 'dart:convert';

import 'package:driver_app/controller/UpdateAttandanceController.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDroppedAttendance extends StatefulWidget {
  UpdateDroppedAttendance({super.key});

  @override
  State<UpdateDroppedAttendance> createState() => _UpdateAttendance();
}

class _UpdateAttendance extends State<UpdateDroppedAttendance> {
  Map<String, String> attendanceMap = {}; // To track attendance
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Map<String, String> dropattendanceMap = {}; // To track attendance

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

  void _showdroppedDialog(BuildContext context) {
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
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(0.5),
                      Colors.red.withOpacity(0.2)
                    ],
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
                    title: 'Dropped Attendance',
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
                        count: dropattendanceMap.values
                            .where((status) => status == "Present")
                            .length,
                        label: "Present",
                        color: Color(0xff0b835c),
                      ),
                      _buildCounterBox(
                        count: dropattendanceMap.values
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
          _showdroppedDialog(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.5),
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
      body: StreamBuilder(
        stream: attandancebyprops.vechileattendanceinfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("sever error");
          } else if (!snapshot.hasData ||
              snapshot.data?.result == null ||
              snapshot.data!.result!.isEmpty) {
            return Text("sever error");
          } else {
            // var model = snapshot.data!.result!;
            var model = snapshot.data!.result!
                .where((att) => att.attendaceType == "DROPPED")
                .toList();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: model.length,
                itemBuilder: (context, index) {
                  final data = model[index];
                  bool isPresent = attendanceMap[data.id] == "Present" ||
                      data.status == true;
                  bool isAbsent = attendanceMap[data.id] == "Absent" ||
                      data.status == false;

                  return Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 30,
                            minRadius: 30,
                            backgroundImage: data.user!.profileImage == null ||
                                    data.user!.profileImage == "fasle" ||
                                    data.user!.profileImage == ""
                                ? const AssetImage('assets/images/user.png')
                                : MemoryImage(
                                    base64Decode(
                                      data.user!.profileImage!.replaceFirst(
                                          'data:image/jpeg;base64,', ''),
                                    ),
                                  ),
                          ),
                          SizedBox(
                              width: MediaQuery.sizeOf(context).height * 0.01),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.user?.name ?? "Unknown"}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2b2b2b),
                                ),
                              ),
                              Text(
                                "Class: ${data.attendaceType ?? ""}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff345326),
                                ),
                              ),
                              Text(
                                "Location: ${data.user?.pickDropLocation ?? "N/A"}",
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
                          Row(
                            children: [
                              InkWell(
                                hoverColor: Colors.grey,
                                onTap: () async {
                                  var schoolId = await _secureStorage.read(
                                      key: 'schoolId');
                                  var updatedData = {
                                    "user": {
                                      "_id": "${data.user!.id}",
                                      "name": "${data.user!.name}"
                                    },
                                    "status": true,
                                    "schoolId": "$schoolId",
                                    "date": "$formattedDate"
                                  };
                                  await attandancebyprops.patchattandance(
                                      "${data.id}", updatedData);

                                  setState(() {
                                    attendanceMap[data.id!] = "Present";
                                  });
                                },
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
                                onTap: () async {
                                  var schoolId = await _secureStorage.read(
                                      key: 'schoolId');
                                  var updatedData = {
                                    "user": {
                                      "_id": "${data.user!.id}",
                                      "name": "${data.user!.name}"
                                    },
                                    "status": false,
                                    "schoolId": "$schoolId",
                                    "date": "$formattedDate"
                                  };
                                  await attandancebyprops.patchattandance(
                                      "${data.id}", updatedData);

                                  setState(() {
                                    attendanceMap[data.id!] = "Absent";
                                  });
                                },
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
                },
              ),
            );
          }
        },
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
}
