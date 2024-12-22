import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:driver_app/controller/ReportIssueController.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({super.key});

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  final vechileIssueController controller = Get.put(vechileIssueController());

  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> uploadedFiles = [];
  List<String> selectedIssues = [];

  File? profileImage;
  String? _profileBase64;

  takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      try {
        File imageFile = File(image.path);
        var result = await FlutterImageCompress.compressWithFile(
          imageFile.absolute.path,
          minWidth: 500,
          minHeight: 500,
          quality: 60,
          rotate: 0,
        );
        // Read image bytes and decode
        if (result != null) {
          File compressedImage =
              await File(imageFile.path).writeAsBytes(result);

          setState(() {
            profileImage = compressedImage;
            _profileBase64 = base64Encode(result);
          });

          print("Encoded and compressed image as Base64: $_profileBase64");
        }
      } catch (e) {
        print("Error while processing image: $e");
      }
    } else {
      print("No image selected.");
    }
  }

  List<File> selectedImages = [];
  List<String> selectedImagesBase64 = [];

  selectFromGallery() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      List<File> tempFiles = [];
      List<String> tempBase64 = [];

      for (var image in images) {
        File imageFile = File(image.path);

        var result = await FlutterImageCompress.compressWithFile(
          imageFile.absolute.path,
          minWidth: 500,
          minHeight: 500,
          quality: 60,
          rotate: 0,
        );

        if (result != null) {
          tempFiles.add(File(imageFile.path));
          tempBase64.add("data:image/jpeg;base64," + base64Encode(result));
        }
      }

      setState(() {
        selectedImages = tempFiles;
        selectedImagesBase64 = tempBase64;
      });

      print("Selected images: $selectedImages");
      print("Encoded images as Base64: $selectedImagesBase64");
    } else {
      print("No images selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar(
        context: context,
        title: 'report_issue'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: getHeight(context) * 0.03),
            issueTitle(context),
            issueList(context),
            SizedBox(height: getHeight(context) * 0.03),
            addPhotoTitle(context),
            SizedBox(height: getHeight(context) * 0.01),
            imageUploadSection(context),
            // FileUploadedWidget(
            //   svgname: "assets/svg_images/upload_icon.svg",
            //   title: "Tap to Upload Image of Fuel Receipt",
            //   files: imageReceipt,
            //   onFileUpload: (file) {
            //     setState(() {
            //       imageReceipt.add(file);
            //     });
            //   },
            // ),
            SizedBox(height: getHeight(context) * 0.04),
            submitButton(context),
            SizedBox(height: getHeight(context) * 0.03),
          ],
        ),
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31.0),
      child: ElevatedButton(
        onPressed: () async {
          final _secureStorage = const FlutterSecureStorage();
          String formattedDate =
              DateFormat('yyyy-MM-dd').format(DateTime.now());

          var schoolId = await _secureStorage.read(key: 'schoolId');
          var driverId = await _secureStorage.read(key: 'driverId');
          var drivername = await _secureStorage.read(key: 'drivername');
          var transportationId =
              await _secureStorage.read(key: 'transportationId');
          var transporationName =
              await _secureStorage.read(key: 'transporationName');

          var data = {
            "schoolId": "${schoolId}",
            "date": "${formattedDate}",
            "issues": selectedIssues.toList(), // Selected issues
            "issuesImages": selectedImagesBase64.toList(), // Encoded images
            "driverInfo": {
              "_id": "${driverId}",
              "name": "${drivername}",
            },
            "vehicleInfo": {
              // "_id": "${transportationId}",
              "_id": "67189289a610cd23428ebc55",
              "name": "5580"

              // "name": "${transporationName}"
            },
            "issuesStatus": "PENDING",
          };

          controller.postvechileIssue(data);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainNavbar(),
            ),
            (route) => false,
          );
          // Clear all fields after submission
          setState(() {
            selectedImages.clear(); // Clear selected images
            selectedImagesBase64.clear(); // Clear Base64 strings
            selectedIssues.clear(); // Clear selected issues
            profileImage = null; // Reset profile image
            _profileBase64 = null; // Reset single Base64
          });

          log("Data submitted and cleared: $data");

          // Optionally, show a success message
          Get.snackbar(
            "Success",
            "Issue submitted successfully!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          print("Submitted data: $data");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffff6448),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(double.infinity, 48),
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'submit_issue'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                  )
                ],
              ),
      ),
    );
  }

  // DottedBorder imageUploadSection(BuildContext context) {
  //   return DottedBorder(
  //     color: Theme.of(context).primaryColor,
  //     strokeWidth: 1,
  //     dashPattern: const [8, 4],
  //     borderType: BorderType.RRect,
  //     radius: const Radius.circular(8),
  //     child: InkWell(
  //       onTap: () {
  //         // takePhoto();
  //         selectFromGallery();
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.all(10),
  //         alignment: Alignment.center,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SvgPicture.asset(
  //               'assets/svg_images/upload_icon.svg',
  //               height: 48,
  //               width: 48,
  //             ),
  //             const SizedBox(height: 10),
  //             const Text(
  //               'Tap to Upload Image',
  //               style: TextStyle(fontSize: 14, color: Colors.black54),
  //             ),
  //             const SizedBox(height: 10),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  DottedBorder imageUploadSection(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).primaryColor,
      strokeWidth: 1,
      dashPattern: const [8, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: InkWell(
        onTap: () {
          selectFromGallery();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedImages.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: selectedImages.map((image) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            image,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.cancel, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                int index = selectedImages.indexOf(image);
                                selectedImages.removeAt(index);
                                selectedImagesBase64.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              if (selectedImages.isEmpty)
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svg_images/upload_icon.svg',
                      height: 48,
                      width: 48,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'upload_image'.tr,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Row addPhotoTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          'add_photo'.tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff545454),
          ),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).height * 0.01),
        const Icon(
          Icons.camera_alt_outlined,
          color: Color(0xff545454),
        ),
      ],
    );
  }

  Flexible issueList(BuildContext context) {
    return Flexible(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.6,
        children: [
          GestureDetector(
            onTap: () {},
            child: buildStdQuickAccessItem(
              "assets/images/car-engine.png",
              'engine'.tr,
              context,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: buildStdQuickAccessItem(
              "assets/images/brake-disc.png",
              'brake'.tr,
              context,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: buildStdQuickAccessItem(
              "assets/images/flat-tire.png",
              'tire'.tr,
              context,
            ),
          ),
          GestureDetector(
            onTap: () async {},
            child: buildStdQuickAccessItem(
              "assets/images/battery.png",
              'battery'.tr,
              context,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: buildStdQuickAccessItem(
              "assets/images/transmission.png",
              'transmission'.tr,
              context,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: buildStdQuickAccessItem(
              "assets/images/application.png",
              'others'.tr,
              context,
            ),
          ),
        ],
      ),
    );
  }

  Row issueTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          'select_issue'.tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff545454),
          ),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).height * 0.01),
        const Icon(
          Icons.warning_amber_rounded,
          color: Color(0xff545454),
        ),
      ],
    );
  }

  Widget buildStdQuickAccessItem(
      String asset, String label, BuildContext context) {
    bool isSelected = selectedIssues.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedIssues.remove(label);
          } else {
            selectedIssues.add(label);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffe0f2f1) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 0.5,
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0.5, 0.5),
            ),
          ],
          border: isSelected
              ? Border.all(color: Color(0xff4cb495), width: 2)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                asset,
                height: 40,
                width: 40,
                color: isSelected ? Color(0xff4cb495) : Color(0xff60bf8f),
              ),
              const SizedBox(height: 5.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Color(0xff4cb495) : Color(0xff60bf8f),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
