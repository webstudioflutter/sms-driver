import 'package:driver_app/controller/Profilecontroller.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:driver_app/screen/dashboard/home_drawer.dart';
import 'package:driver_app/screen/dashboard/profile/widgets/myaccount_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomePageDrawer(),
      appBar: customBar(
        context: context,
        title: 'myacc'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.profile.value == null) {
                return const Center(child: Text("Data not found"));
              } else {
                final profile = controller.profile.value!.result!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getHeight(context) * 0.025),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'personal_det'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/circle-user.svg',
                              title: 'full_name'.tr,
                              subtitle: profile.fullName ?? 'N/A',
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/legal.svg',
                              title: 'Lice_no'.tr,
                              subtitle: profile.lisenceNo != null
                                  ? profile.lisenceNo.toString()
                                  : "N/A",
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/id-badge.svg',
                              title: 'citizenship_no'.tr,
                              subtitle: profile.citizenshipNo != null
                                  ? "${profile.citizenshipNo}"
                                  : 'N/A',
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon:
                                  'assets/svg_images/blood-test-tube.svg',
                              title: 'blood_grp'.tr,
                              subtitle: profile.bloodGroup != null
                                  ? "${profile.bloodGroup}"
                                  : 'N/A',
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/phone-call.svg',
                              title: 'contact'.tr,
                              subtitle: profile.contactNumber != null
                                  ? "${profile.contactNumber}"
                                  : 'N/A',
                              suffixIcon: Icons.edit_square,
                              onTap: () async {
                                final newContact = await numberController(
                                  context,
                                  title: 'edit_contact'.tr,
                                  initialValue: "${profile.contactNumber}",
                                );
                              },
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/home_profile.svg',
                              title: 'address'.tr,
                              subtitle: profile.address!.location != null
                                  ? "${profile.address!.location}, ${profile.address!.country}"
                                  : 'N/A',
                              suffixIcon: Icons.edit_square,
                              onTap: () async {
                                final newAddress = await showAddressEditDialog(
                                  context,
                                  title: 'edit_address'.tr,
                                  initialValue: profile.address != null
                                      ? "${profile.address!.location}, ${profile.address!.country}"
                                      : '',
                                );
                              },
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            Text(
                              'other_info'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/bus.svg',
                              title: 'assigned_vehicle'.tr,
                              subtitle: profile.transporation != ""
                                  ? "${profile.transporation!.name}"
                                  : 'N/A',
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/employee-man.svg',
                              title: 'experience'.tr,
                              subtitle: profile.experiencedYear != null
                                  ? "${profile.experiencedYear}"
                                  : "0",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String?> numberController(
    BuildContext context, {
    required String title,
    required String initialValue,
  }) {
    final TextEditingController textController =
        TextEditingController(text: initialValue);

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: "Enter new value"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              var data = {"contactNumber": textController.text};
              controller.updateProfile(data);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<String?> showAddressEditDialog(
    BuildContext context, {
    required String title,
    required String initialValue,
  }) {
    final TextEditingController textController = TextEditingController();
    final TextEditingController streetController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Container(
          height: 150,
          child: Column(
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: "Enter location"),
              ),
              TextField(
                controller: streetController,
                decoration: InputDecoration(
                  labelText: "Enter country",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              var data = {
                "address": {
                  "city": "",
                  "district": "",
                  "muncipality": "",
                  "street": "",
                  "location": textController.text,
                  "country": streetController.text,
                }
              };
              controller.updateProfile(data);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
