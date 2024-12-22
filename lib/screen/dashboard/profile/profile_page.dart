import 'dart:convert';
import 'dart:io';

import 'package:driver_app/Repository/auth/AuthenticationRepository.dart';
import 'package:driver_app/controller/Profilecontroller.dart';
import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/dashboard/home_drawer.dart';
import 'package:driver_app/screen/dashboard/profile/my_account.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:driver_app/screen/login_and_logout/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List locale = [
    {
      'name': 'English',
      'locale': const Locale('en', 'US'),
      'flag': 'assets/images/us.png',
    },
    {
      'name': 'नेपाली',
      'locale': const Locale('nep', 'NPL'),
      'flag': 'assets/images/np.png',
    },
    {
      'name': 'हिन्दी',
      'locale': const Locale('hi', 'IN'),
      'flag': 'assets/images/in.png',
    },
    {
      'name': 'Arabic',
      'locale': const Locale('arb', 'ARB'),
      'flag': 'assets/images/ar.png',
    },
  ];

  buildDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: const Text("Change Language"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.updateLocale(locale[index]['locale']);
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          locale[index]['flag'],
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 20),
                        Text(locale[index]['name']),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.blue,
                );
              },
              itemCount: locale.length,
            ),
          ),
        );
      },
    );
  }

  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> uploadedFiles = [];

  File? _profileImage;
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
            _profileImage = compressedImage;
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

  selectFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      var result = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 500,
        minHeight: 500,
        quality: 60,
        rotate: 0,
      );

      if (result != null) {
        File compressedImage = await File(imageFile.path).writeAsBytes(result);

        setState(() {
          _profileImage = compressedImage;
          _profileBase64 = base64Encode(result);
        });

        print("Encoded and compressed image as Base64: $_profileBase64");
      }
    }
  }

  final ProfileController controller = Get.put(ProfileController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      drawer: const HomePageDrawer(),
      appBar: _appBarContent(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: getHeight(context) * 0.13, right: 10, left: 10, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 0.5,
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(0.5, 0.5),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyAccount()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svg_images/profile.svg'),
                              const SizedBox(width: 10),
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'info'.tr,
                                      maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff545454),
                                      ),
                                    ),
                                    Text(
                                      'View your personal and work details',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffababab),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.chevron_right,
                                size: 35,
                                color: Color(0xff999999),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
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
                                    color: Color(0xff545454),
                                  ),
                                ),
                                Text(
                                  'Manage your device security',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xffababab),
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
                      Divider(),
                      InkWell(
                        onTap: () {
                          showLogoutConfirmation(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svg_images/logout.svg'),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: getWidth(context) * 0.6,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Log out',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff545454),
                                          ),
                                        ),
                                        Text(
                                          'Further secure your account for safety',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffababab),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 35,
                                color: Color(0xff999999),
                              ),
                            ],
                          ),
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
                    color: Color(0xff454951),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 0.5,
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(0.5, 0.5),
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: getHeight(context) * 0.01,
                        bottom: getHeight(context) * 0.01,
                        left: 5,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                              'assets/svg_images/notification2.svg'),
                          const SizedBox(width: 10),
                          const Text(
                            'Help & Support',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff545454),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Spacer(),
                          const Icon(
                            Icons.chevron_right,
                            size: 35,
                            color: Color(0xff999999),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        buildDialogue(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: getHeight(context) * 0.01,
                          bottom: getHeight(context) * 0.01,
                          left: 5,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0x1160bf8f),
                              child: SvgPicture.asset(
                                  'assets/svg_images/language.svg',
                                  width: 24.0,
                                  height: 24.0,
                                  color: const Color(0xff60bf8f)),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Change Language',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff545454),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Spacer(),
                            const Icon(
                              Icons.chevron_right,
                              size: 35,
                              color: Color(0xff999999),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _appBarContent(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.25),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.25,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff6bccc1), Color(0xff6fcf99)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.048,
            right: 18,
            left: 18,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Color(0xffcdeede),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: SvgPicture.asset(
                        'assets/svg_images/menu.svg',
                        height: 30,
                      ),
                    ),
                    Text(
                      "Profile",
                      style: const TextStyle(
                        color: pageTitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmergencyMain(),
                            ));
                      },
                      child: SvgPicture.asset(
                        'assets/svg_images/notification.svg',
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -95,
            right: 10,
            left: 10,
            child: SizedBox(
              // height: MediaQuery.sizeOf(context).height * 0.21,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.profile.value == null) {
                    return const Center(child: Text("Data not found"));
                  } else {
                    final profile = controller.profile.value!.result!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openModalBottomSheetForProfileEdit(context);
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                maxRadius: 60,
                                backgroundImage: _profileImage != null
                                    ? FileImage(_profileImage!)
                                    : (profile.profileImage == null ||
                                            profile.profileImage!.isEmpty
                                        ? const AssetImage(
                                            'assets/images/user.png')
                                        : MemoryImage(
                                            base64Decode(
                                                ("${profile.profileImage!.replaceFirst('data:image/jpeg;base64,', '')}")),
                                          )) as ImageProvider,
                              ),
                              Positioned(
                                right: -15,
                                bottom: 10,
                                child: Container(
                                  height: getHeight(context) * 0.05,
                                  width: getHeight(context) * 0.05,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.edit_square,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${profile.fullName}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff545454),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "License No :${profile.lisenceNo}" ?? 'N/A',
                          style: TextStyle(
                            color: Color(0xff676767),
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> openModalBottomSheetForProfileEdit(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.white,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Obx(() {
                // Loading state or profile not found handling
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.profile.value == null) {
                  return const Center(child: Text("Data not found"));
                } else {
                  final profile = controller.profile.value!.result;
                  String base64String = profile?.profileImage ?? '';
                  if (base64String.isNotEmpty) {
                    if (base64String.startsWith('data:image/jpeg;base64,')) {
                      base64String = base64String.replaceFirst(
                          'data:image/jpeg;base64,', '');
                    } else if (base64String
                        .startsWith('data:image/png;base64,')) {
                      base64String = base64String.replaceFirst(
                          'data:image/png;base64,', '');
                    } else {
                      throw Exception('Unsupported image format');
                    }
                  } else {
                    print('No profile image available');
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Display profile image in CircleAvatar
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CircleAvatar(
                            maxRadius: getHeight(context) * 0.07,
                            minRadius: getHeight(context) * 0.02,
                            backgroundImage: profile!.profileImage == null ||
                                    profile.profileImage == "false" ||
                                    profile.profileImage!.isEmpty
                                ? AssetImage('assets/images/user.png')
                                : MemoryImage(
                                    base64Decode(base64String),
                                  ),
                          ),
                        ),
                        // Take Photo Option
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: GestureDetector(
                            onTap: () async {
                              var image = await takePhoto();
                              if (image != null) {
                                setState(() {
                                  _profileImage = image;
                                  _profileBase64 =
                                      base64Encode(image.readAsBytesSync());
                                });
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.camera_alt_outlined),
                                SizedBox(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.02),
                                const Text('Take Photograph',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        // Select Photo from Gallery Option
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: GestureDetector(
                            onTap: () async {
                              final image = await selectFromGallery();
                              if (image != null) {
                                setState(() {
                                  _profileImage = image;
                                  _profileBase64 =
                                      base64Encode(image.readAsBytesSync());
                                });
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.image),
                                SizedBox(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.02),
                                const Text('Select from album',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        // Remove Profile Image Option
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _profileImage = null;
                                // Clear the selected profile image
                              });
                              Navigator.of(context).pop();
                              // Close dialog after removing// Close dialog after removal
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.delete, color: Colors.red),
                                SizedBox(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.02),
                                const Text('Remove Profile Picture',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red)),
                              ],
                            ),
                          ),
                        ),
                        // Update Profile Button
                        ElevatedButton(
                          onPressed: () {
                            if (_profileBase64 != null &&
                                _profileBase64!.isNotEmpty) {
                              var data = {
                                "profileImage":
                                    "data:image/jpeg;base64,$_profileBase64",
                              };
                              controller.updateProfile(data);
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.39,
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Update Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
          ),
        );
      },
    );
  }

  void showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Icon(Icons.logout, color: Colors.red),
              content: const Text('Are you sure you want to log out?'),
              actions: isLoading
                  ? <Widget>[const Center(child: CircularProgressIndicator())]
                  : <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          backgroundColor: const Color(0xffdddddd),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Yes',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });

                          await authenticationRepository.logout();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriverLoginScreen()),
                          );
                        },
                      ),
                    ],
            );
          },
        );
      },
    );
  }
}
