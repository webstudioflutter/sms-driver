import 'dart:async';
import 'dart:io';

import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/FileUploadedWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BillMethod extends StatefulWidget {
  const BillMethod({super.key});

  @override
  _BillMethodState createState() => _BillMethodState();
}

class _BillMethodState extends State<BillMethod> {
  String _selectedDate = 'Select Date';
  // File? _selectedImage;
  List<Map<String, dynamic>> uploadedFiles = [];
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBillTypeSection(),
          const SizedBox(height: 10),
          _buildBillDateSection(),
          const SizedBox(height: 10),
          _buildTotalAmountSection(),
          const SizedBox(height: 15),
          FileUploadedWidget(
            svgname: "assets/svg_images/upload_icon.svg",
            title: "Tap to upload your bill",
            files: uploadedFiles,
            onFileUpload: (file) {
              setState(() {
                uploadedFiles.add(file);
              });
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: SizedBox(
                  // width: 150,
                  width: getWidth(context) * 0.39,
                  child: const Text(
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
                child: SizedBox(
                  // width: 150,
                  width: getWidth(context) * 0.39,

                  child: const Text(
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
      ),
    );
  }

// Bill Type section
  Widget _buildBillTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Bill Type',
              style: TextStyle(
                  color: Color(0xff676767),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SvgPicture.asset('assets/svg_images/bill_type.svg'),
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: 'Select Bill Type',
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xffc8c8c8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xffc8c8c8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Bill Date section
  Widget _buildBillDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: [
              const Text(
                'Bill Date',
                style: TextStyle(
                    color: Color(0xff676767),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset('assets/svg_images/bill_date.svg'),
            ],
          ),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffc8c8c8)),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffc8c8c8)),
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: const Icon(Icons.calendar_month_outlined,
                  color: Color(0xffc8c8c8)),
            ),
            child: Text(
              _selectedDate,
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
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter Total Amount',
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xffc8c8c8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xffc8c8c8),
              ),
            ),
          ),
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
