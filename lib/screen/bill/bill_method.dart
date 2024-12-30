import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:driver_app/controller/postBillController.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class BillMethod extends StatefulWidget {
  BillMethod({super.key});

  @override
  _BillMethodState createState() => _BillMethodState();
}

class _BillMethodState extends State<BillMethod> {
  final _controller = Get.put(PostBillController());
  String selectedDate = 'bill_date_hint'.tr;
  String billType = '';
  double totalAmount = 0.0;
  TextEditingController amountcontroller = TextEditingController();
  List<Map<String, dynamic>> uploadedFiles = [];
  var billImage = <String>[].obs;
  File? _profileImage;
  String? profileBase64;
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Future<void> takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      try {
        File imageFile = File(image.path);

        // Read image bytes and decode
        final bytes = await imageFile.readAsBytes();
        final img.Image? originalImage = img.decodeImage(bytes);

        if (originalImage != null) {
          // Fix orientation and encode to JPEG
          img.Image fixedImage = img.bakeOrientation(originalImage);
          final fixedImageBytes = img.encodeJpg(fixedImage);
          final fixedImageFile = File(imageFile.path)
            ..writeAsBytesSync(fixedImageBytes);

          // Convert to Base64 string
          final base64Image = base64Encode(fixedImageBytes);

          // Update state
          setState(() {
            profileBase64 = base64Image;
            _profileImage = fixedImageFile;
          });

          print("Profile Image File: $_profileImage");
          print("Base64 Image: $profileBase64");
        } else {
          print("Failed to decode the image.");
        }
      } catch (e) {
        print("Error while processing image: $e");
      }
    } else {
      print("No image selected.");
    }
  }

  Future<void> selectFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      var result = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 500,
        minHeight: 500,
        quality: 88,
        rotate: 0,
      );

      if (result != null) {
        File compressedImage = await File(imageFile.path).writeAsBytes(result);

        // Update the profile image and Base64 string
        setState(() {
          _profileImage = compressedImage;
          profileBase64 = base64Encode(result);
        });

        print("Encoded and compressed image as Base64: $profileBase64");
      }
    }
  }

  void showSubmitDialog() {}

  @override
  void initState() {
    _controller.postbill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return _controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildBillTypeSection(),
                const SizedBox(height: 10),
                _buildBillDateSection(),
                const SizedBox(height: 10),
                _buildTotalAmountSection(),
                const SizedBox(height: 15),
                if (profileBase64 == null || profileBase64!.isEmpty)
                  DottedBorder(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 1,
                    dashPattern: const [8, 4],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    child: InkWell(
                      onTap: pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg_images/upload_icon.svg',
                              height: 48,
                              width: 48,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'bill_upload'.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (profileBase64 != null && profileBase64!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: DottedBorder(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 1,
                      dashPattern: const [8, 4],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      child: _profileImage != null
                          ? Image.file(
                              height: 250,
                              width: width,
                              _profileImage!,
                              fit: BoxFit.fill,
                            )
                          : Center(
                              child: Text(
                                'No image selected',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                    ),
                  ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainNavbar()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: SizedBox(
                        width: getWidth(context) * 0.39,
                        child: Text(
                          textAlign: TextAlign.center,
                          'cancel_btn'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
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
                        if (billType.isEmpty ||
                            selectedDate.isEmpty ||
                            totalAmount <= 0 ||
                            profileBase64 == null) {
                          Get.snackbar(
                            'Validation Error',
                            'Please fill all required fields.',
                            backgroundColor: Colors.red.shade400,
                            colorText: Colors.white,
                          );
                          return;
                        } else {
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
                                content: Text('success_upload'.tr),
                              );
                            },
                          );
                          var data = {
                            "schoolId": "${schoolname}",
                            "date": selectedDate,
                            "expenseType": "PICKED",
                            "billType": "${billType}",
                            "billTitle": "",
                            "billAmount": "${amountcontroller.text}",
                            "nextServiceDate": "",
                            "partsUsed": [""],
                            "oldPartsImages": [""],
                            "billImage":
                                "data:image/jpeg;base64,${profileBase64}",
                            "newPartsImages": [""],
                            "driverInfo": {
                              "_id": "${driverId}",
                              "name": "${drivername}"
                            },
                            "vehicleInfo": {
                              "_id": "${transportationId}",
                              "name": "${transporationName}"
                            },
                            "status": true
                          };

                          await _controller.postGetBills(data);
                        }

                        setState(() {
                          selectedDate = 'bill_date_hint'.tr;
                          billType = '';
                          amountcontroller.clear();
                          _profileImage = null;
                          profileBase64 = null;
                        });
                        profileBase64 = null;
                        amountcontroller.text.isBlank;
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
                        child: Text(
                          textAlign: TextAlign.center,
                          'submit_btn'.tr,
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
            );
    }));
  }

  Future<void> pickImage() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SvgPicture.asset('assets/svg_images/take_photo.svg'),
                title: Text('take_photo'.tr),
                onTap: () async {
                  Navigator.pop(context);
                  takePhoto();
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/svg_images/select_album.svg'),
                title: Text('select_album'.tr),
                onTap: () async {
                  Navigator.pop(context);
                  selectFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Bill Type section with dropdown inside a border
  Widget _buildBillTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'bill_type'.tr,
              style: TextStyle(
                color: Color(0xff676767),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
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
              value: billType.isEmpty
                  ? null
                  : billType, // Use null when there's no selection
              hint: Text(
                'bill_type_hint'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  billType = newValue ??
                      ''; // If no value selected, set to empty string
                });
              },
              items: [
                'Accident Repair Bill',
                'Spare Parts Bill',
                'flat tire Bill',
                'Repair Bill',
                'Battery Bill',
                'Allowances Bill',
                'Parking Bill',
                'Traffic Violation Bill',
                'Others Bill',
              ].map<DropdownMenuItem<String>>((String value) {
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
            Text(
              'bill_date'.tr,
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
              selectedDate,
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
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              totalAmount = double.tryParse(value) ?? 0.0;
            });
          },
          controller: amountcontroller,
          decoration: InputDecoration(
            hintText: 'tot_amt_hint'.tr,
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
