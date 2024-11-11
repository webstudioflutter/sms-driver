// import 'package:driver_app/core/utils/util.dart';
// import 'package:driver_app/screen/emergency/emergency_main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class RouteMapScreen extends StatefulWidget {
//   const RouteMapScreen({super.key});

//   @override
//   _RouteMapScreenState createState() => _RouteMapScreenState();
// }

// class _RouteMapScreenState extends State<RouteMapScreen> {
//   late GoogleMapController mapController;
//   final Set<Polyline> _polylines = {};
//   final List<LatLng> _routePoints = [
//     const LatLng(27.7172, 85.3240), // Example coordinates
//     const LatLng(27.7182, 85.3250),
//     const LatLng(27.7190, 85.3265),
//     // Add more route points here
//   ];

//   // Dummy student list data
//   List<Map<String, String>> students = [
//     {"name": "Charlie Press", "class": "5A", "location": "Balaju"},
//     {"name": "Ahmad Donin", "class": "5A", "location": "Balaju"},
//   ];

//   // State to control visibility of student list
//   bool showStudentList = false;

//   @override
//   void initState() {
//     super.initState();
//     _createPolylines();
//   }

//   void _createPolylines() {
//     _polylines.add(
//       Polyline(
//         polylineId: const PolylineId("route"),
//         points: _routePoints,
//         color: Colors.green,
//         width: 5,
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _checkLocation(LatLng currentLocation) {
//     for (LatLng point in _routePoints) {
//       if ((currentLocation.latitude - point.latitude).abs() < 0.0005 &&
//           (currentLocation.longitude - point.longitude).abs() < 0.0005) {
//         setState(() {
//           showStudentList = true; // Show student list when in proximity
//         });
//         return;
//       }
//     }
//     setState(() {
//       showStudentList = false; // Hide list otherwise
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(150), // Custom height
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Positioned(
//               top: 20,
//               left: 10,
//               right: 10,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 50,
//                       decoration: const BoxDecoration(
//                         color: Color(0xbb9BDCB9),
//                         borderRadius: BorderRadius.all(Radius.circular(25)),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             icon: const Icon(
//                               Icons.arrow_back,
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                           const Text(
//                             "Route Map",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff12422e),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const EmergencyMain(),
//                                 ),
//                               );
//                             },
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(right: 12.0, bottom: 4),
//                               child: SvgPicture.asset(
//                                 'assets/svg_images/notification.svg',
//                                 height: 20,
//                                 width: 20,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _routePoints[0], // Center on starting point
//               zoom: 15,
//             ),
//             polylines: _polylines,
//             markers: {
//               Marker(
//                 markerId: const MarkerId("start"),
//                 position: _routePoints[0],
//               ),
//               Marker(
//                 markerId: const MarkerId("end"),
//                 position: _routePoints[_routePoints.length - 1],
//               ),
//             },
//             onCameraMove: (position) {
//               _checkLocation(position.target);
//             },
//           ),
//           if (showStudentList)
//             Positioned(
//               bottom: 20,
//               left: 10,
//               right: 10,
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 color: Colors.white,
//                 child: Column(
//                   children: students.map((student) {
//                     return ListTile(
//                       leading: const CircleAvatar(
//                         child: Icon(Icons.person),
//                       ),
//                       title: Text(student['name']!),
//                       subtitle: Text(
//                           'Class: ${student['class']}, Location: ${student['location']}'),
//                       trailing:
//                           const Icon(Icons.check_circle, color: Colors.green),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           setState(() {
//             showStudentList = !showStudentList;
//           });
//         },
//         label: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.all(10),
//                 backgroundColor: const Color(0xffFF6448),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: SizedBox(
//                 // width: 150,
//                 width: getWidth(context) * 0.39,
//                 child: const Text(
//                   textAlign: TextAlign.center,
//                   'Mark Stop Point',
//                   style: TextStyle(
//                       color: Color(0xffFEFEFE),
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.all(10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: SizedBox(
//                 // width: 150,
//                 width: getWidth(context) * 0.39,
//                 child: const Text(
//                   textAlign: TextAlign.center,
//                   'End Route',
//                   style: TextStyle(
//                       color: Color(0xff7b7b7b),
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//           ],
//         ),

//         //Text(showStudentList ? 'End Route' : 'Mark Stop Point'),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class RouteMapScreen extends StatefulWidget {
//   const RouteMapScreen({super.key});

//   @override
//   _RouteMapScreenState createState() => _RouteMapScreenState();
// }

// class _RouteMapScreenState extends State<RouteMapScreen> {
//   GoogleMapController? mapController;
//   final Set<Polyline> _polylines = {};
//   final List<LatLng> _routePoints = [
//     const LatLng(27.7172, 85.3240), // Example coordinates
//     const LatLng(27.7182, 85.3250),
//     const LatLng(27.7190, 85.3265),
//     // Add more route points here
//   ];

//   // Dummy student list data
//   List<Map<String, String>> students = [
//     {"name": "Charlie Press", "class": "5A", "location": "Balaju"},
//     {"name": "Ahmad Donin", "class": "5A", "location": "Balaju"},
//   ];

//   // State to control visibility of student list
//   bool showStudentList = false;

//   @override
//   void initState() {
//     super.initState();
//     _createPolylines();
//   }

//   void _createPolylines() {
//     _polylines.add(
//       Polyline(
//         polylineId: const PolylineId("route"),
//         points: _routePoints,
//         color: Colors.green,
//         width: 5,
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _checkLocation(LatLng currentLocation) {
//     for (LatLng point in _routePoints) {
//       if ((currentLocation.latitude - point.latitude).abs() < 0.0005 &&
//           (currentLocation.longitude - point.longitude).abs() < 0.0005) {
//         setState(() {
//           showStudentList = true; // Show student list when in proximity
//         });
//         return;
//       }
//     }
//     setState(() {
//       showStudentList = false; // Hide list otherwise
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80), // Custom height
//         child: AppBar(
//           title: const Text(
//             "Route Map",
//             style: TextStyle(color: Colors.black),
//           ),
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           actions: [
//             GestureDetector(
//               onTap: () {
//                 // Navigate to EmergencyMain or perform action
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 12.0, bottom: 4),
//                 child: SvgPicture.asset(
//                   'assets/svg_images/notification.svg',
//                   height: 24,
//                   width: 24,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             mapType: MapType.normal,
//             initialCameraPosition: CameraPosition(
//               target: _routePoints[0],
//               zoom: 15,
//             ),
//             polylines: _polylines,
//             markers: {
//               Marker(
//                 markerId: const MarkerId("start"),
//                 position: _routePoints[0],
//               ),
//               Marker(
//                 markerId: const MarkerId("end"),
//                 position: _routePoints[_routePoints.length - 1],
//               ),
//             },
//             onCameraMove: (position) {
//               _checkLocation(position.target);
//             },
//           ),
//           if (showStudentList)
//             Positioned(
//               bottom: 20,
//               left: 10,
//               right: 10,
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 10,
//                       spreadRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: students.map((student) {
//                     return ListTile(
//                       leading: const CircleAvatar(
//                         child: Icon(Icons.person),
//                       ),
//                       title: Text(student['name']!),
//                       subtitle: Text(
//                           'Class: ${student['class']}, Location: ${student['location']}'),
//                       trailing:
//                           const Icon(Icons.check_circle, color: Colors.green),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               // Add functionality for marking stop point
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xffFF6448),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               'Mark Stop Point',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Add functionality for ending route
//             },
//             style: OutlinedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               'End Route',
//               style: TextStyle(color: Color(0xff7b7b7b), fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMapScreen extends StatefulWidget {
  const RouteMapScreen({super.key});

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  GoogleMapController? mapController;

  // Initial position on the map
  final LatLng _initialPosition =
      const LatLng(27.7172, 85.3240); // Example: Kathmandu, Nepal

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("initial_marker"),
            position: _initialPosition,
            infoWindow: const InfoWindow(
              title: "Kathmandu",
              snippet: "Initial Position",
            ),
          ),
        },
      ),
    );
  }
}
