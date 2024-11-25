import 'dart:async';

import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/FileUploadedWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BillMethod extends StatefulWidget {
  const BillMethod({super.key});

  @override
  _BillMethodState createState() => _BillMethodState();
}

class _BillMethodState extends State<BillMethod> {
  String _selectedDate = 'Select Date';
  String _billType = '';
  double _totalAmount = 0.0;
  TextEditingController amountcontroller = TextEditingController();
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
        _selectedDate = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  void _showSubmitDialog(String message) {
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
          content: Text(message),
        );
      },
    );
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
                onPressed: () async {
                  try {
                    final FlutterSecureStorage _secureStorage =
                        const FlutterSecureStorage();
                    String? driverId =
                        await _secureStorage.read(key: 'driverId');
                    String? drivername =
                        await _secureStorage.read(key: 'drivername');
                    String? schoolname =
                        await _secureStorage.read(key: 'schoolId');
                    String? transportationId =
                        await _secureStorage.read(key: 'transportationId');
                    String? transporationName =
                        await _secureStorage.read(key: 'transporationName');

                    final Map<String, dynamic> requestBody = {
                      "schoolId": schoolname,
                      "date": _selectedDate,
                      "expenseType": "",
                      "billType": _billType,
                      "billTitle": "",
                      "billAmount": amountcontroller.text,
                      "nextServiceDate": "",
                      "partsUsed": [],
                      "billImage": [uploadedFiles],
                      "oldPartsImages": [],
                      "newPartsImages": [],
                      "driverInfo": {"_id": driverId, "name": drivername},
                      "vehicleInfo": {
                        "_id": transportationId,
                        "name": transporationName
                      },
                      "status": true
                    };
                  } catch (e) {
                    _showSubmitDialog("Error: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color(0xff60BF8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: SizedBox(
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

  // Bill Type section with dropdown inside a border
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
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffc8c8c8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              value: _billType.isEmpty ? null : _billType,
              hint: Text('Select Bill Type',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  )),
              onChanged: (String? newValue) {
                setState(() {
                  _billType = newValue ?? '';
                });
              },
              items: ['Fuel', 'Maintenance']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
              underline: Container(),
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
        Row(
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
          onChanged: (value) {
            setState(() {
              _totalAmount = double.tryParse(value) ?? 0.0;
            });
          },
          controller: amountcontroller,
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
}
