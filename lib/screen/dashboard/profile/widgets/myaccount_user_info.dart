import 'package:flutter/material.dart';

class UserInfoRow extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final IconData? suffixIcon;
  final VoidCallback? onPressdSuffixIcon;

  const UserInfoRow({
    super.key,
    this.leadingIcon = Icons.person_3_outlined,
    required this.title,
    required this.subtitle,
    this.suffixIcon,
    this.onPressdSuffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(leadingIcon, color: const Color(0xff60bf8f)),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Color(0xffbfbfbf)),
            ),
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
