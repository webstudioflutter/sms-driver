import 'package:driver_app/core/utils/asset_provider.dart';
import 'package:driver_app/screen/bill/bill_main.dart';
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
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 237, 239, 248),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: TextField(
                        cursorColor: Colors.grey,
                        cursorHeight: 16,
                        onChanged: updateSearchQuery,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 9),
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
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
