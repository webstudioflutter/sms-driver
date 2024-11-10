import 'dart:io';

import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:driver_app/screen/login_and_logout/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.25),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.27,
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
                title: 'Profile',
                firstIcon: Icons.arrow_back,
                lastWidget: SvgPicture.asset(
                    'assets/svg_images/notification.svg',
                    height: 20),
              ),
            ),
            Positioned(
              bottom: -95,
              right: 10,
              left: 10,
              child: SizedBox(
                // height: MediaQuery.sizeOf(context).height * 0.21,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xff60bf8f),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                'https://thumbs.wbm.im/pw/medium/6ee9298a0daeccde4df0d2df499bda96.avif',
                                height: getHeight(context) * 0.14,
                                width: getHeight(context) * 0.14,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -10,
                            bottom: 10,
                            child: Container(
                              height: getHeight(context) * 0.05,
                              width: getHeight(context) * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit_square,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                onPressed: () =>
                                    _openModalBottomSheetForProfileEdit(
                                        context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Lal Bahadur Ojha',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text('License No: 4048683576'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: getHeight(context) * 0.13,
          right: 10,
          left: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg_images/profile.svg'),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: getWidth(context) * 0.6,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'General Information',
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'View your personal and work details',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.warning, color: Colors.red),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.chevron_right,
                              size: 35,
                              color: Color(0xff999999),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg_images/lock.svg'),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Face ID / Touch ID',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Manage your device security',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          const Spacer(),
                          Switch(value: false, onChanged: (value) {})
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg_images/logout.svg'),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: getWidth(context) * 0.6,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Log out',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Further secure your account for safety',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.chevron_right,
                              size: 35,
                              color: Color(0xff999999),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                'More',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.only(
                  // top: 20.0,
                  top: getHeight(context) * 0.01,
                  // bottom: 20,
                  bottom: getHeight(context) * 0.01,
                  left: 5,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg_images/notification2.svg'),
                    const SizedBox(width: 10),
                    const Text(
                      'Help & Support',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.chevron_right,
                        size: 35,
                        color: Color(0xff999999),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openModalBottomSheetForProfileEdit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Makes the border circular
                    border: Border.all(
                      color: const Color(0xff60bf8f),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: _image == null
                        ? Image.asset(
                            'assets/images/fake_profile.jpg',
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.camera); // Select from camera
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera_alt_outlined),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),
                      const Text(
                        'Take Photograph',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.gallery); // Select from gallery
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.image),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),
                      const Text(
                        'Select from album',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),
                      const Text(
                        'Remove Profile Picture',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.logout, color: Colors.green),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: const Color(0xffdddddd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TeacherLoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }
}

// void showLogoutConfirmation(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Icon(Icons.logout, color: Colors.green),
//           content: const Text('Are you sure you want to log out?'),
//           actions: <Widget>[
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.all(10),
//                 backgroundColor: const Color(0xffdddddd),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child:
//                   const Text('Cancel', style: TextStyle(color: Colors.black)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.all(10),
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text('Yes', style: TextStyle(color: Colors.white)),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const TeacherLoginScreen()));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
