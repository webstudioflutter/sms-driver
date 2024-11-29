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
        title: 'My Account',
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
                            const Text(
                              'Personal Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/circle-user.svg',
                              title: 'Full Name',
                              subtitle: profile.fullName ?? 'N/A',
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/legal.svg',
                              title: 'License Number',
                              subtitle: profile.lisenceNo != null
                                  ? profile.lisenceNo.toString()
                                  : "N/A",
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/id-badge.svg',
                              title: 'Citizenship Number',
                              subtitle: profile.citizenshipNo != null
                                  ? "${profile.citizenshipNo}"
                                  : 'N/A',
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon:
                                  'assets/svg_images/blood-test-tube.svg',
                              title: 'Blood Group',
                              subtitle: profile.bloodGroup != null
                                  ? "${profile.bloodGroup}"
                                  : 'N/A',
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/phone-call.svg',
                              title: 'Contact Information',
                              subtitle: profile.contactNumber != null
                                  ? "${profile.contactNumber}"
                                  : 'N/A',
                              suffixIcon: Icons.edit_square,
                              onTap: () async {
                                final newContact = await numberController(
                                  context,
                                  title: "Edit Contact Information",
                                  initialValue: "${profile.contactNumber}",
                                );
                              },
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/home_profile.svg',
                              title: 'Home Address',
                              subtitle: profile.address!.city != null
                                  ? "${profile.address!.street}${profile.address!.city}"
                                  : 'N/A',
                              suffixIcon: Icons.edit_square,
                              onTap: () async {
                                final newAddress = await showAddressEditDialog(
                                  context,
                                  title: "Edit Home Address",
                                  initialValue: profile.address != null
                                      ? "${profile.address!.street}, ${profile.address!.city}"
                                      : '',
                                );
                              },
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            const Text(
                              'Other Information',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/bus.svg',
                              title: 'Assigned Vehicle',
                              subtitle: profile.transporation?.name ?? 'N/A',
                            ),
                            SizedBox(height: getHeight(context) * 0.025),
                            UserInfoRow(
                              leadingIcon: 'assets/svg_images/employee-man.svg',
                              title: 'Years of Experience',
                              subtitle: "${profile.experiencedYear}" ?? 'N/A',
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
    final TextEditingController textController =
        TextEditingController(text: initialValue);
    final TextEditingController streetController =
        TextEditingController(text: initialValue);

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: "Enter new city"),
            ),
            TextField(
              controller: streetController,
              decoration: InputDecoration(
                labelText: "Enter new street",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              var data = {
                "address": {
                  "city": textController.text,
                  "district": "",
                  "muncipality": "",
                  "street": streetController.text,
                  "location": ""
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
