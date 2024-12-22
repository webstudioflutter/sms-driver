import 'dart:developer';

import 'package:driver_app/controller/Home/ServicingHistoryController.dart';
import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:driver_app/screen/servicing/log_servicing_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ServicingMain extends StatefulWidget {
  const ServicingMain({super.key});

  @override
  _ServicingMainState createState() => _ServicingMainState();
}

class _ServicingMainState extends State<ServicingMain> {
  final servicingHistroyController = Get.put(ServicingHistoryController());
  Future<void> _refreshPage() async {
    servicingHistroyController.fetchServicingHistoryList();

    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    servicingHistroyController.fetchServicingHistoryList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customBar(
          context: context,
          title: 'servicing'.tr,
        ),
        body: Obx(() {
          // Loading state
          if (servicingHistroyController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check if no data found and display message
          if (servicingHistroyController
                  .servicingHistoryModel.value?.result?.isEmpty ??
              true) {
            return const Center(
              child: Text(
                'No servicing data found.',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: RefreshIndicator(
              onRefresh: _refreshPage,
              child: Column(
                children: [
                  _servicingDateContent(),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'servicing_history'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff545454),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/svg_images/history.svg',
                          height: 25,
                          width: 25,
                          color: Color(0xff545454),
                        ),
                      ],
                    ),
                  ),
                  _servingHistoryContent(),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Obx(() {
          if (servicingHistroyController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogServicingForm()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Color(0xffff6448),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    'log_servicing'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          );
        }));
  }

  Widget _servicingDateContent() {
    var nextServiceDateString = servicingHistroyController
            .servicingHistoryModel.value?.result?[0].nextServiceDate ??
        "";

    int remainingDays = 0;
    if (nextServiceDateString.isNotEmpty) {
      try {
        DateTime nextServiceDate = DateTime.parse(nextServiceDateString);
        DateTime today = DateTime.now();
        remainingDays = nextServiceDate.difference(today).inDays;
      } catch (e) {
        print("Error parsing date: $e");
        // remainingDays = -1; // Use -1 to indicate an error
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'nextservicingdate'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff545454),
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                'assets/svg_images/scheduled-maintenance.svg',
                height: 25,
                width: 25,
                color: Color(0xff545454),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(width: 5),
              Text(
                nextServiceDateString.isNotEmpty
                    ? nextServiceDateString
                    : "You haven't input the next Servicing date",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff363636),
                ),
              ),
              SizedBox(width: MediaQuery.sizeOf(context).width * 0.04),
              Text(
                remainingDays > 0
                    ? "$remainingDays days from today"
                    : (remainingDays == 0
                        ? "Today is the servicing day"
                        : "Invalid or past date"),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: remainingDays > 0 ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _servingHistoryContent() {
    var data = servicingHistroyController.servicingHistoryModel.value!.result!
        .where((datas) {
      return datas.billType == "Servicing Bill";
    }).toList();
    log("${data}");
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: const Offset(0.5, 0.5),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined,
                            color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          // item['date'] ?? '',
                          item.date ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffadadad),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      (item.partsUsed?.isNotEmpty ?? false)
                          ? item.partsUsed?.join(', ') ?? "No parts found"
                          : "No parts found",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff545454),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Rs ${item.billAmount}",
                      style: const TextStyle(
                        color: Color(0xff545454),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
