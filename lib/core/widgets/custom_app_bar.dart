// import 'package:driver_app/core/widgets/page_title_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// PreferredSize customBar(
//     {required BuildContext context, required String title}) {
//   return PreferredSize(
//     preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.13),
//     child: Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: MediaQuery.sizeOf(context).height * 0.28,
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xff6bccc1), Color(0xff6fcf99)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(40),
//                   bottomRight: Radius.circular(40))),
//         ),
//         Positioned(
//           top: MediaQuery.sizeOf(context).height * 0.07,
//           right: 10,
//           left: 10,
//           child: PageTitleBar(
//               firstIconAction: () {
//                 Navigator.pop(context);
//               },
//               title: title,
//               firstIcon: Icons.arrow_back,
//               lastWidget: SvgPicture.asset('assets/svg_images/notification.svg',
//                   height: 20)),
//         ),
//       ],
//     ),
//   );
// }

import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

PreferredSize customBar({
  required BuildContext context,
  required String title,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.14),
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
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.07,
          right: 10,
          left: 10,
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xffD8F3E1),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: pageTitleColor,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainNavbar()),
                        ModalRoute.withName('/'),
                      );
                    },
                  ),
                  Text(
                    title,
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
                          builder: (context) => const EmergencyMain(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0, bottom: 4),
                      child: SvgPicture.asset(
                        'assets/svg_images/notification.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
