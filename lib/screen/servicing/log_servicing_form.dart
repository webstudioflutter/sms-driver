import 'dart:async';

import 'package:driver_app/controller/Home/ServicingController.dart';
import 'package:driver_app/core/widgets/FileUploadedWidget.dart';
import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LogServicingForm extends StatefulWidget {
  const LogServicingForm({super.key});

  @override
  _LogServicingFormState createState() => _LogServicingFormState();
}

class _LogServicingFormState extends State<LogServicingForm> {
  final ServicingController servicingController =
      Get.put(ServicingController());

  String _selectedDate = 'Select Date';

  List<Map<String, dynamic>> servicingFiles = [];
  final List<String> base64servicingImage = [];

  List<Map<String, dynamic>> damagedFiles = [];
  final List<String> base64DamageImage = [];

  List<Map<String, dynamic>> replacedFiles = [];
  final List<String> base64ReplaceImage = [];

  List<String> checkboxLabels = [
    'Brake Pads',
    'Battery',
    'Starter Motor',
    'Spark Plugs',
    'Tires',
    'Wiper Blades',
    'Air Filter',
    'Others',
  ];
  final List<String> selectedItems = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        servicingController.servicingDate.value = '';
        _selectedDate = "${picked.year}-${picked.month}-${picked.day}";
        servicingController.servicingDate.value = _selectedDate;
      });
    }
  }

  Future<void> _selectnextDate(BuildContext context) async {
    final nextpicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2400),
    );
    if (nextpicked != null) {
      setState(() {
        servicingController.nextservicingDate.value = '';
        _selectedDate =
            "${nextpicked.year}-${nextpicked.month}-${nextpicked.day}";
        servicingController.nextservicingDate.value = _selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar(
        context: context,
        title: 'servicing'.tr,
      ),
      bottomNavigationBar: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: servicingController.isLoading.value
                  ? null // Disable the button while loading
                  : () {
                      servicingController.submitServicingData(context);
                    },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                backgroundColor: const Color(0xff60BF8F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: servicingController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'submit'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildnextServiceDateSection(),
          _buildServiceDateSection(),
          const SizedBox(height: 15),
          _buildCheckboxSection(),
          const SizedBox(height: 25),
          _buildTotalAmountSection(),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                'servicing_bill'.tr,
                style: TextStyle(
                    color: Color(0xff676767),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset('assets/svg_images/bill_receipt.svg'),
            ],
          ),
          SizedBox(height: 5),

          FileUploadedWidget(
              svgname: "assets/svg_images/upload_image_receipt.svg",
              title: 'servicing_bill_upload'.tr,
              files: servicingFiles,
              onSubmitImages: (base64ImagesList) {
                setState(() {
                  servicingController.billImage.clear();
                  servicingController.billImage.addAll(base64ImagesList);
                });
              }),

          Row(
            children: [
              Text(
                'damagedPart'.tr,
                style: TextStyle(
                    color: Color(0xff676767),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset('assets/svg_images/bill_receipt.svg'),
            ],
          ),
          SizedBox(height: 5),

          FileUploadedWidget(
              svgname: "assets/svg_images/upload_image_receipt.svg",
              title: 'damagedPartImage'.tr,
              files: damagedFiles,
              onSubmitImages: (base64ImagesList) {
                setState(() {
                  // base64DamageImage.clear();
                  // base64DamageImage.addAll(base64ImagesList);
                  servicingController.damagedPartImage.clear();
                  servicingController.damagedPartImage.addAll(base64ImagesList);
                });
              }),

          ///Replaced Part
          Row(
            children: [
              Text(
                'replacedPart'.tr,
                style: TextStyle(
                    color: Color(0xff676767),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset('assets/svg_images/bill_receipt.svg'),
            ],
          ),
          SizedBox(height: 5),

          FileUploadedWidget(
            svgname: "assets/svg_images/upload_image_receipt.svg",
            title: 'replacedPartImage'.tr,
            files: replacedFiles,
            onSubmitImages: (base64ImagesList) {
              setState(() {
                servicingController.replacedPartImage.clear();
                servicingController.replacedPartImage.addAll(base64ImagesList);
              });
            },
          ),
        ],
      ),
    );
  }

  // Bill Date section
  Widget _buildServiceDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'servicing_date'.tr,
              style: TextStyle(
                  color: Color(0xff676767),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/svg_images/bill_date.svg'),
          ],
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: const Icon(Icons.calendar_month_outlined),
            ),
            child: Text(
              servicingController.servicingDate.value,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildnextServiceDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'nextservicingdate'.tr,
              style: TextStyle(
                  color: Color(0xff676767),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/svg_images/bill_date.svg'),
          ],
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () => _selectnextDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: const Icon(Icons.calendar_month_outlined),
            ),
            child: Text(
              servicingController.nextservicingDate.value,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'total_amount'.tr,
              style: TextStyle(
                  color: Color(0xff676767),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SvgPicture.asset('assets/svg_images/total_amt.svg'),
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          controller: servicingController.totalAmountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'tot_amt_hint'.tr,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'parts_replaced'.tr,
              style: TextStyle(
                  color: Color(0xff676767),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/svg_images/part_replacement.svg'),
          ],
        ),
        Wrap(
          spacing: 3.0,
          children: checkboxLabels.map((label) {
            final bool isSelected = selectedItems.contains(label);

            return ChoiceChip(
              label: Text(label),
              selected: isSelected,
              selectedColor: const Color.fromARGB(
                  255, 134, 216, 144), // Color for selected chips
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedItems.add(label);
                  } else {
                    selectedItems.remove(label);
                  }
                  servicingController.partsUsed.value = selectedItems;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CircleAvatar(
              radius: 30,
              backgroundColor: Color(0x33008000),
              child: Icon(
                Icons.check_outlined,
                color: Colors.green,
                size: 30,
              )),
          content: Text('upload_msg'.tr),
        );
      },
    );
  }
}
