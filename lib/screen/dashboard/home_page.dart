import 'package:driver_app/core/constants/string_constants.dart';
import 'package:driver_app/core/utils/asset_provider.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:driver_app/screen/dashboard/attendance/attendance.dart';
import 'package:driver_app/screen/dashboard/home_drawer.dart';
import 'package:driver_app/screen/dashboard/report-issue/report_issue.dart';
import 'package:driver_app/screen/dashboard/student-list/student_list.dart';
import 'package:driver_app/screen/fuel/fuel_tracking.dart';
import 'package:driver_app/screen/servicing/servicing_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // This ensures the UI resizes when the keyboard appears
      key: _scaffoldKey,
      drawer: const HomePageDrawer(),
      appBar: _appBarContent(context),
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: MediaQuery.of(context).size.height * 0.09,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fuelLevelContent(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            _servicingDateContent(context),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            const Text(
              'Quick Access',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff363636),
              ),
            ),
            _quickAccessItems(context),
          ],
        ),
      ),
    );
  }

  Expanded _quickAccessItems(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.6,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Attendance(),
                ),
              );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.attendance,
              kAttendance,
              context,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FuelTrackingMain(),
                ),
              );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.fuel,
              kFuelTracking,
              context,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReportIssue(),
                ),
              );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.report,
              kReportIssue,
              context,
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServicingMain(),
                ),
              );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.servicing,
              kServicing,
              context,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BillMain(),
                ),
              );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.billupload,
              kBillUpload,
              context,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentList(),
                ),
              );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.studentlist,
              kStudentList,
              context,
            ),
          ),
        ],
      ),
    );
  }

  Column _servicingDateContent(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Next Servicing Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff363636),
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(
              'assets/svg_images/scheduled-maintenance.svg',
              height: 25,
              width: 25,
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.calendar_month),
            const Text(
              '5th November',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff221f1f),
              ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.04),
            const Text(
              '13 days from today',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _fuelLevelContent() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Fuel Level',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff363636),
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(
              'assets/svg_images/fuel-level.svg',
              height: 25,
              width: 25,
            ),
          ],
        ),
        // SizedBox(
        //   height: 10,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 6,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 2.5),
        //         child: Container(
        //           height: 10,
        //           width: 50,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(8),
        //               color: const Color(0xff60bf8f)),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        SizedBox(height: getHeight(context) * 0.01),
        SizedBox(
          height: 10,
          child: Builder(
            builder: (context) {
              double screenWidth = getWidth(context);
              double itemWidth = (screenWidth - 2 * 5) /
                  8; // Calculate width of each item based on screen width and spacing

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 10,
                      width: itemWidth, // Use calculated width for each item
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff60bf8f),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  PreferredSize _appBarContent(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(270),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.28,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff59CDDA), Color(0xff60BF8F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.07,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color(0xffcdeede),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: SvgPicture.asset(
                              'assets/svg_images/menu.svg',
                              height: 30,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/svg_images/notification.svg',
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(context) * 0.018),
                SizedBox(
                  height: getHeight(context) * 0.17,
                  child: Card(
                    color: const Color(0xffd8f3e1),
                    margin: EdgeInsets.symmetric(
                      horizontal: getWidth(context) * 0.021,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context) * 0.07,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/fake_profile.jpg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Lal Bahadur Ojha',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff221F1F),
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: getHeight(context) * 0.01),
                              const Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  'Bus No:Ba2 cha 9820',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff221F1F),
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              SizedBox(height: getHeight(context) * 0.01),
                              InkWell(
                                onTap: () {
                                  _openModalBottomSheetForStartRoute(context);
                                },
                                child: Container(
                                  width: getWidth(context) * 0.4,
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffff6448),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Start Route',
                                      style: TextStyle(
                                          color: Color(0xffFEFEFE),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openModalBottomSheetForStartRoute(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Enter Today's Starting KM",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff60bf8f),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Colors.green)),
                        child: TextFormField(
                          controller: _routeController,
                          textAlign: TextAlign.center,
                          cursorColor: const Color(0xffcdeede),
                          cursorHeight: 16,
                          decoration: InputDecoration(
                            hintText: 'XXX-XXX-XX',
                            hintStyle: TextStyle(color: Colors.grey.shade200),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 9),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          _openModalBottomSheetForPickDrop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0xff60bf8f),
                          ),
                          child: const Center(
                            child: Text(
                              'Start Route',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -30,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/svg_images/green-notification.svg',
                    height: 55,
                    width: 55,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openModalBottomSheetForPickDrop(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 195, 235, 227),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 90,
                    width: 139,
                    child: const Center(
                      child: Text(
                        'PICK UP',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff186444),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: Color(0xff8df3e1),
                      color: const Color.fromARGB(255, 195, 235, 227),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 90,
                    width: 139,
                    child: const Center(
                      child: Text(
                        'DROP OFF',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff186444),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -30,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/svg_images/green-notification.svg',
                height: 55,
                width: 55,
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget buildStdQuickAccessItem(
    String svgAsset, String label, BuildContext context) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            height: 30,
            width: 30,
          ),
          const SizedBox(height: 5.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xff60bf8f),
            ),
          ),
        ],
      ),
    ),
  );
}
