import 'package:dotted_border/dotted_border.dart';
import 'package:driver_app/core/utils/asset_provider.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({super.key});

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  // Function to pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      setState(() {
        _image = image;
      });
      if (image != null) {
        // You can use the image file here, e.g., display it or upload it
        print('Picked image path: ${image.path}');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar(
        context: context,
        title: 'Report Issue',
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
            SizedBox(height: getHeight(context) * 0.04),
            submitButton(context),
            SizedBox(height: getHeight(context) * 0.03),
          ],
        ),
      ),
    );
  }

  Container submitButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xffff6448),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SUBMIT ISSUE',
              style: TextStyle(
                  color: Color(0xffFEFEFE),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.03),
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  DottedBorder imageUploadSection(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).primaryColor,
      strokeWidth: 1,
      dashPattern: const [8, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: InkWell(
        onTap: () {
          _pickImage(ImageSource.gallery); // Select from gallery
        },
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
              const Text(
                'Tap to Upload Image of Fuel Receipt',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Row addPhotoTitle(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Add Photo',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).height * 0.01),
        const Icon(Icons.camera_alt_outlined),
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
              Assets.svgImages.attendance,
              'Engine Light',
              context,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: buildStdQuickAccessItem(
              Assets.svgImages.fuel,
              'Brake Issue',
              context,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ReportIssue(),
              //   ),
              // );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.report,
              'Flat Tire',
              context,
            ),
          ),
          GestureDetector(
            onTap: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AssignmentScreen(),
              //   ),
              // );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.servicing,
              'Battery Issue',
              context,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const BillMain(),
              //   ),
              // );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.billupload,
              'Transmission',
              context,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         const StudyMaterialsScreen(),
              //   ),
              // );
            },
            child: buildStdQuickAccessItem(
              Assets.svgImages.studentlist,
              'Others',
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
        const Text(
          'Select Issue',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).height * 0.01),
        const Icon(Icons.warning_amber_rounded),
      ],
    );
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
              height: 40,
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
}
