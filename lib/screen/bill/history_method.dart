import 'package:driver_app/controller/BillController.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/bill/edit_bill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryMethod extends StatefulWidget {
  const HistoryMethod({super.key});

  @override
  _HistoryMethodState createState() => _HistoryMethodState();
}

class _HistoryMethodState extends State<HistoryMethod> {
  final BillController billController = Get.put(BillController());

  String? selectedBillType = 'other_bill'.tr;
  DateTime? selectedDate;

  List<String> billTypes = [
    'accident_bill'.tr,
    'part_bill'.tr,
    'tire_bill'.tr,
    'repair_bill'.tr,
    'battery_bill'.tr,
    'allowance_bill'.tr,
    'parking_bill'.tr,
    'violation_bill'.tr,
    'other_bill'.tr,
  ];

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} ${getMonthName(date.month)}, ${date.year}';
  }

  String getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'March',
      'April',
      'May',
      'June',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  Future<void> _refreshPage() async {
    billController.getBills();

    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    billController.getBills();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (billController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      var billsdata = billController.bills;

      var filteredBills = billsdata.where((bill) {
        final matchesBillType = selectedBillType == null ||
            selectedBillType == 'other_bill'.tr ||
            bill.billType == selectedBillType;
        final matchesDate = selectedDate == null ||
            bill.date == DateFormat('yyyy-MM-dd').format(selectedDate!);
        return matchesBillType && matchesDate;
      }).toList();

      return RefreshIndicator(
        onRefresh: _refreshPage,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: getHeight(context) * 0.08,
                      child: DropdownButtonFormField<String>(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff545454),
                          fontWeight: FontWeight.w900,
                        ),
                        value: selectedBillType,
                        hint: Text(
                          'bill_type'.tr,
                          style: TextStyle(
                            fontSize: 19,
                            color: Color(0xff545454),
                          ),
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffe0e0e0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffe0e0e0)),
                          ),
                        ),
                        items: billTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedBillType = value;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2025),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        height: getHeight(context) * 0.08,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffe0e0e0))),
                            border: OutlineInputBorder(),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate == null
                                    ? 'choose_date'.tr
                                    : formatDate(selectedDate!),
                                style: const TextStyle(
                                    color: Color(0xff545454), fontSize: 16),
                              ),
                              Visibility(
                                visible: selectedDate == null,
                                child: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.grey,
                                  size: 24.0,
                                ),
                              ),
                              if (selectedDate != null)
                                IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                    size: 24.0,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedDate = null;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBills.length,
                itemBuilder: (context, index) {
                  final item = filteredBills[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: const Offset(0.5, 0.5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month_outlined,
                                        color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      item.date!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffadadad)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Bill Type : ${item.billType}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff545454),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Rs ${item.billAmount}',
                                  style: const TextStyle(
                                      color: Color(0xff545454),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditBillMethod(
                                              totalAmount:
                                                  item.billAmount!.toDouble(),
                                              billType: item.billType!,
                                              Date: item.date!,
                                              billImage: item.billImage!,
                                              billId: item.id!,
                                            )));
                              },
                              child: const Icon(
                                Icons.edit_square,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
