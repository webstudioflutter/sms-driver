import 'dart:async';
import 'dart:io';

import 'package:driver_app/core/widgets/FileUploadedWidget.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:driver_app/screen/servicing/servicing_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogServicingForm extends StatefulWidget {
  const LogServicingForm({super.key});

  @override
  _LogServicingFormState createState() => _LogServicingFormState();
}

class _LogServicingFormState extends State<LogServicingForm> {
  String _selectedDate = 'Select Date';
  List<Map<String, dynamic>> files = [];
  File? _selectedImage;
  String? _fileName;
  List<String> checkboxLabels = [
    "Brake Pads",
    "Battery",
    "Starter Motor",
    "Spark Plugs",
    "Tires",
    "Wiper Blades",
    "Air Filter",
    "Others",
  ];
  List<bool> checkboxValues = List.filled(8, false);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.sizeOf(context).height * 0.15),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                // height: MediaQuery.sizeOf(context).height * 0.20,
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
                top: MediaQuery.sizeOf(context).height * 0.07,
                right: 10,
                left: 10,
                child: PageTitleBar(
                  title: 'Servicing',
                  firstIcon: Icons.arrow_back,
                  lastWidget: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmergencyMain()));
                    },
                    child: SvgPicture.asset(
                      'assets/svg_images/notification.svg',
                      height: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildServiceDateSection(),
            const SizedBox(height: 15),
            _buildCheckboxSection(),
            const SizedBox(height: 25),
            _buildTotalAmountSection(),
            const SizedBox(height: 15),
            FileUploadedWidget(
              svgname: "assets/svg_images/upload_image_receipt.svg",
              Title: "Tap to Upload Image of Receipt ",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServicingMain()));
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const SizedBox(
                    width: 150,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showSubmitDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: const Color(0xff60BF8F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const SizedBox(
                    width: 150,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  // Bill Date section
  Widget _buildServiceDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Servicing Date',
              style: TextStyle(
                  color: Colors.black,
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
            child: Text(_selectedDate),
          ),
        ),
      ],
    );
  }

  // Widget _buildCheckboxSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           const Text(
  //             'Parts Replaced',
  //             style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w500),
  //           ),
  //           const SizedBox(width: 8),
  //           SvgPicture.asset('assets/svg_images/part_replacement.svg'),
  //         ],
  //       ),
  //       const SizedBox(height: 5),
  //       GridView.builder(
  //         shrinkWrap: true,
  //         itemCount: checkboxLabels.length,
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2,
  //           childAspectRatio: 3.5,
  //         ),
  //         itemBuilder: (context, index) {
  //           return CheckboxListTile(
  //             title: Text(checkboxLabels[index]),
  //             value: checkboxValues[index],
  //             onChanged: (value) {
  //               setState(() {
  //                 checkboxValues[index] = value!;
  //               });
  //             },
  //           );
  //         },
  //       )
  //     ],
  //   );
  // }

  // Total Amount section
  Widget _buildTotalAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Total Amount',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset('assets/svg_images/total_amt.svg'),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter Total Amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // Checkbox Section
  Widget _buildCheckboxSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Parts Replaced',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/svg_images/part_replacement.svg'),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 6,
          ),
          itemCount: checkboxLabels.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(checkboxLabels[index]),
              value: checkboxValues[index],
              onChanged: (value) {
                setState(() {
                  checkboxValues[index] = value!;
                });
              },
            );
          },
        ),
      ],
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: CircleAvatar(
              radius: 30,
              backgroundColor: Color(0x33008000),
              child: Icon(
                Icons.check_outlined,
                color: Colors.green,
                size: 30,
              )),
          content: Text('Your bill has been sucessfully upload!'),
        );
      },
    );
  }
}
