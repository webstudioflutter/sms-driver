import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:driver_app/screen/dashboard/profile/widgets/myaccount_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar(
        context: context,
        title: 'My Account',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
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
                      const UserInfoRow(
                          title: 'Full Name', subtitle: 'Lal Bahadur Ojha'),
                      SizedBox(height: getHeight(context) * 0.025),
                      const UserInfoRow(
                          title: 'License Number', subtitle: '2404044838383'),
                      SizedBox(height: getHeight(context) * 0.025),
                      const UserInfoRow(
                          title: 'Citizenship Number',
                          subtitle: '90-347-44477'),
                      SizedBox(height: getHeight(context) * 0.025),
                      UserInfoRow(
                        title: 'Contact Information',
                        subtitle: '+977-9858585858',
                        suffixIcon: Icons.edit_square,
                        onPressdSuffixIcon: () {},
                      ),
                      SizedBox(height: getHeight(context) * 0.025),
                      UserInfoRow(
                        title: 'Home Address',
                        subtitle: 'Ghantaghar Tole, Birgunj',
                        suffixIcon: Icons.edit_square,
                        onPressdSuffixIcon: () {},
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
                      const UserInfoRow(
                        title: 'Assigned Vehicle',
                        subtitle: 'Ba2 cha 9820',
                      ),
                      SizedBox(height: getHeight(context) * 0.025),
                      const UserInfoRow(
                        title: 'Years of Experience',
                        subtitle: '5 Years',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
