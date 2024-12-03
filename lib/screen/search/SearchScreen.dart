import 'package:driver_app/core/utils/asset_provider.dart';
import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:driver_app/screen/dashboard/attendance/attendance.dart';
import 'package:driver_app/screen/dashboard/report-issue/report_issue.dart';
import 'package:driver_app/screen/dashboard/student-list/student_list.dart';
import 'package:driver_app/screen/fuel/fuel_tracking.dart';
import 'package:driver_app/screen/servicing/servicing_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> features = [
    {
      'label': 'Attendance',
      'destination': Attendance(),
      'icon': Assets.svgImages.attendance,
    },
    {
      'label': 'fuel filling',
      'destination': FuelTrackingMain(),
      'icon': Assets.svgImages.fuel,
    },
    {
      'label': 'Report Issue',
      'destination': ReportIssue(),
      'icon': Assets.svgImages.report,
    },
    {
      'label': 'Servicing',
      'destination': ServicingMain(),
      'icon': Assets.svgImages.servicing,
    },
    {
      'label': 'Student List',
      'destination': StudentList(),
      'icon': Assets.svgImages.studentlist,
    },
    {
      'label': 'Bill',
      'destination': BillMain(),
      'icon': Assets.svgImages.billupload,
    },
  ];

  List<Map<String, dynamic>>? filteredFeatures;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredFeatures = features;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredFeatures = features
          .where((feature) =>
              feature['label'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 35.0, // Set your desired height
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 237, 239, 248), // Set the background color
                      borderRadius:
                          BorderRadius.circular(20.0), // Set the border radius
                    ),
                    child: Center(
                      child: TextField(
                        autofocus: true,
                        cursorColor: Colors.grey,
                        cursorHeight: 16,
                        onChanged: updateSearchQuery,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 9), // Add padding here
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              color: Colors
                                  .grey.shade400), // Customize hint text color
                          border: InputBorder.none, // Remove the border
                          focusedBorder:
                              InputBorder.none, // Remove the focused border
                          enabledBorder:
                              InputBorder.none, // Remove the enabled border
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            SizedBox(height: 10),
            Expanded(
              child: filteredFeatures!.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredFeatures!.length,
                      itemBuilder: (context, index) {
                        final feature = filteredFeatures![index];
                        return ListTile(
                          leading: SvgPicture.asset(
                            feature['icon'],
                            height: 20,
                            width: 20,
                          ),
                          title: Text(
                            feature['label'],
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => feature['destination']),
                            );
                          },
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No features found',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
