import 'package:driver_app/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserInfoRow extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String subtitle;
  final IconData? suffixIcon;
  final VoidCallback? onPressdSuffixIcon;

  const UserInfoRow({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.suffixIcon,
    this.onPressdSuffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(leadingIcon,
            width: 24.0, height: 24.0, color: const Color(0xff60bf8f)),
        SizedBox(width: getWidth(context) * 0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Color(0xffbfbfbf)),
            ),
            SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Color(0xff545454)),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => onPressdSuffixIcon,
          child: Icon(suffixIcon, color: const Color(0xff9c9c9c)),
        ),
      ],
    );
  }
}
