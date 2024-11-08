import 'package:driver_app/core/widgets/page_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

PreferredSize customBar(
    {required BuildContext context, required String title}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.13),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.28,
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
              firstIconAction: () {
                Navigator.pop(context);
              },
              title: title,
              firstIcon: Icons.arrow_back,
              lastWidget: SvgPicture.asset('assets/svg_images/notification.svg',
                  height: 20)),
        ),
      ],
    ),
  );
}
