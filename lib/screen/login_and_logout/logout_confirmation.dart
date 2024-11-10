// import 'package:driver_app/screen/login_and_logout/login.dart';
// import 'package:flutter/material.dart';

// class LogoutConfirmation extends StatelessWidget {
//   const LogoutConfirmation({super.key});

//   void showLogoutConfirmation(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Icon(Icons.warning, color: Colors.red),
//           content: const Text('Are you sure you want to log out'),
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
//                 backgroundColor: const Color(0xffff3333),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text('Yes', style: TextStyle(color: Colors.white)),
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const LoginPage()));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }


// }
