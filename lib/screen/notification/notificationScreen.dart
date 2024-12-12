import 'dart:async';
import 'dart:developer';

import 'package:driver_app/controller/NotificationController.dart';
import 'package:driver_app/core/widgets/responsive_text.dart';
import 'package:driver_app/screen/dashboard/attendance/attendance.dart';
import 'package:driver_app/screen/dashboard/home_drawer.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:driver_app/screen/error/notfoundpage.dart';
import 'package:driver_app/screen/error/servererror.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Timer? timer;
  Future<void> _refreshPage() async {
    notificationbloc.notificationdata();
    await Future.delayed(const Duration(seconds: 1));
  }

  String formatBattleTime(String battleTime) {
    DateTime dateTime = DateTime.parse(battleTime);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      int hours = difference.inHours;
      int minutes = difference.inMinutes.remainder(60);
      if (minutes > 0) {
        return '$hours hours ago';
      } else {
        return '${hours}h ago';
      }
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  @override
  void initState() {
    super.initState();
    notificationbloc.notificationdata();
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      notificationbloc.notificationdata();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const HomePageDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xff4cb495),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 2,
          title: Center(
            child: ResponsiveText(
              "Notification",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              textColor: Colors.white,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyMain(),
                    ));
              },
              child: SvgPicture.asset(
                'assets/svg_images/notification.svg',
                height: 20,
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshPage,
          child: StreamBuilder(
            stream: notificationbloc.notificationinfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return ServerError();
              } else if (!snapshot.hasData || snapshot.data?.result == null) {
                return DataNotFound();
              } else {
                final data = snapshot.data!.result!;
                if (data.isEmpty || snapshot.data!.count == 0) {
                  return Center(
                    child: Image.asset(
                      "assets/images/notification.png",
                      height: 200,
                      width: 200,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final datas = data[index];
                        String formattedDate =
                            DateFormat('MMM dd, yyyy').format(datas.createdAt!);
                        return notificationCard(
                            title: datas.title ?? "No Title",
                            description: datas.body ?? "No Description",
                            time: "${datas.createdAt}",
                            status: datas.notificationStatus ?? "Unread",
                            pageName: datas.type ?? "",
                            id: datas.id);
                      }),
                );
              }
            },
          ),
        ));
  }

  Widget notificationCard({
    required String title,
    required String description,
    required String time,
    required String status,
    required String pageName,
    String? id,
  }) {
    return GestureDetector(
      onTap: () async {
        navigateToPage(pageName);
        await notificationbloc.updatenotificationdata("${id}");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: status == "READ" ? Colors.white : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: const Offset(0.5, 0.5),
              spreadRadius: 0.5,
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  formatBattleTime(time),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPage(String pageName) {
    switch (pageName) {
      case "attendance":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "homework":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "assignment":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "result":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "studymaterial":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "fee":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "routine":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "books":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "announcement":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;

      case "profile":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationScreen()),
        );
        break;
      case "event":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      case "maps":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attendance()),
        );
        break;
      default:
        log("Page not found: $pageName");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Page not found: $pageName")),
        );
    }
  }
}
