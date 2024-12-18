// import 'dart:async';

// import 'package:driver_app/core/utils/util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class LiveTrackingMapPage extends StatefulWidget {
//   final LatLng destination =
//       const LatLng(27.7272, 85.3745); // Adjusted farther destination

//   const LiveTrackingMapPage({super.key});

//   @override
//   State<LiveTrackingMapPage> createState() => _LiveTrackingMapPageState();
// }

// class _LiveTrackingMapPageState extends State<LiveTrackingMapPage> {
//   LatLng busLocation =
//       const LatLng(27.7172, 85.324); // Initial bus location (start point)
//   Timer? timer;
//   int currentPointIndex = 0; // Track the current point index
//   double progress = 0.0; // Track progress between points
//   MapController mapController =
//       MapController(); // Initialize the map controller

//   // List of points including multiple stops and final destination
//   List<LatLng> points = [
//     const LatLng(27.7172, 85.324), // Starting point
//     const LatLng(27.7200, 85.328), // Stop 1
//     const LatLng(27.7225, 85.332), // Stop 2
//     const LatLng(27.7250, 85.338), // Stop 3
//     const LatLng(27.7272, 85.3745), // Final destination (farther away)
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   void startMovementSimulation() {
//     if (points.length < 2)
//       return; // Ensure there are enough points to interpolate

//     timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       setState(() {
//         if (currentPointIndex < points.length - 1) {
//           progress += 0.01; // Adjust the speed by changing this increment
//           if (progress >= 1.0) {
//             // Move to the next point
//             currentPointIndex++;
//             progress = 0.0; // Reset progress for the next segment
//           }
//           busLocation = _interpolate(points[currentPointIndex],
//               points[currentPointIndex + 1], progress);
//           // Update the map camera position to the bus's current location
//           mapController.move(busLocation, 16.0); // Adjust zoom level as needed
//         } else {
//           timer.cancel(); // Stop the timer when the destination is reached
//         }
//       });
//     });
//   }

//   LatLng _interpolate(LatLng start, LatLng end, double progress) {
//     double lat = start.latitude + (end.latitude - start.latitude) * progress;
//     double lng = start.longitude + (end.longitude - start.longitude) * progress;
//     return LatLng(lat, lng);
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: FlutterMap(
//               mapController: mapController, // Set the map controller
//               options: MapOptions(
//                 initialCenter: busLocation,
//                 initialZoom: 14.5,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       'https://{s}.basemaps.cartocdn.com/rastertiles/light_all/{z}/{x}/{y}.png',
//                   subdomains: const ['a', 'b', 'c'],
//                 ),
//                 PolylineLayer(
//                   polylines: [
//                     Polyline(
//                       points: points, // Route points
//                       strokeWidth: 8.0,
//                       color: const Color(0xff82d3a8),
//                     ),
//                   ],
//                 ),
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       point: points.first, // Starting point
//                       child: const Icon(
//                         Icons.home,
//                         color: Colors.green,
//                         size: 40,
//                         semanticLabel: "Start Point",
//                       ),
//                     ),
//                     Marker(
//                       point: busLocation, // Dynamic bus location
//                       child: const Icon(
//                         Icons.directions_bus,
//                         color: Colors.blue,
//                         size: 40,
//                         semanticLabel: "Baneshwor",
//                       ),
//                     ),
//                     Marker(
//                       point: points[1], // Stop 1
//                       child: const Icon(Icons.location_on,
//                           color: Colors.orange, size: 40),
//                     ),
//                     Marker(
//                       point: points[2], // Stop 2
//                       child: const Icon(Icons.location_on,
//                           color: Colors.orange, size: 40),
//                     ),
//                     Marker(
//                       point: points[3], // Stop 3
//                       child: const Icon(Icons.location_on,
//                           color: Colors.orange, size: 40),
//                     ),
//                     Marker(
//                       point: points.last, // Final destination
//                       child: const Icon(Icons.location_on,
//                           color: Colors.red, size: 40),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Stack(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.all(10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: SizedBox(
//                       // width: 150,
//                       width: getWidth(context) * 0.39,
//                       child: const Text(
//                         textAlign: TextAlign.center,
//                         'Cancel',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.all(10),
//                       backgroundColor: const Color(0xff60BF8F),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: SizedBox(
//                       // width: 150,
//                       width: getWidth(context) * 0.39,

//                       child: const Text(
//                         textAlign: TextAlign.center,
//                         'Submit',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/dashboard/home_drawer.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class LiveTrackingMapPage extends StatefulWidget {
  final LatLng destination =
      const LatLng(27.7272, 85.3745); // Adjusted farther destination

  const LiveTrackingMapPage({super.key});

  @override
  State<LiveTrackingMapPage> createState() => _LiveTrackingMapPageState();
}

class _LiveTrackingMapPageState extends State<LiveTrackingMapPage> {
  LatLng busLocation =
      const LatLng(27.7172, 85.324); // Initial bus location (start point)
  Timer? timer;
  int currentPointIndex = 0; // Track the current point index
  double progress = 0.0; // Track progress between points
  MapController mapController =
      MapController(); // Initialize the map controller

  // List of points including multiple stops and final destination
  List<LatLng> points = [
    const LatLng(27.7172, 85.324), // Starting point
    const LatLng(27.7200, 85.328), // Stop 1
    const LatLng(27.7225, 85.332), // Stop 2
    const LatLng(27.7250, 85.338), // Stop 3
    const LatLng(27.7272, 85.3745), // Final destination (farther away)
  ];

  @override
  void initState() {
    super.initState();
  }

  void startMovementSimulation() {
    if (points.length < 2)
      return; // Ensure there are enough points to interpolate

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (currentPointIndex < points.length - 1) {
          progress += 0.01; // Adjust the speed by changing this increment
          if (progress >= 1.0) {
            // Move to the next point
            currentPointIndex++;
            progress = 0.0; // Reset progress for the next segment
          }
          busLocation = _interpolate(points[currentPointIndex],
              points[currentPointIndex + 1], progress);
          // Update the map camera position to the bus's current location
          mapController.move(busLocation, 16.0); // Adjust zoom level as needed
        } else {
          timer.cancel(); // Stop the timer when the destination is reached
        }
      });
    });
  }

  LatLng _interpolate(LatLng start, LatLng end, double progress) {
    double lat = start.latitude + (end.latitude - start.latitude) * progress;
    double lng = start.longitude + (end.longitude - start.longitude) * progress;
    return LatLng(lat, lng);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      drawer: const HomePageDrawer(),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: busLocation,
              initialZoom: 14.5,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/light_all/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points, // Route points
                    strokeWidth: 8.0,
                    color: const Color(0xff82d3a8),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: points.first, // Starting point
                    child: const Icon(
                      Icons.home,
                      color: Colors.green,
                      size: 40,
                      semanticLabel: "Start Point",
                    ),
                  ),
                  Marker(
                    point: busLocation, // Dynamic bus location
                    child: const Icon(
                      Icons.directions_bus,
                      color: Colors.blue,
                      size: 40,
                      semanticLabel: "Baneshwor",
                    ),
                  ),
                  Marker(
                    point: points[1], // Stop 1
                    child: const Icon(Icons.location_on,
                        color: Colors.orange, size: 40),
                  ),
                  Marker(
                    point: points[2], // Stop 2
                    child: const Icon(Icons.location_on,
                        color: Colors.orange, size: 40),
                  ),
                  Marker(
                    point: points[3], // Stop 3
                    child: const Icon(Icons.location_on,
                        color: Colors.orange, size: 40),
                  ),
                  Marker(
                    point: points.last, // Final destination
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 40),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 30,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Color(0xff9BDCB9),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: SvgPicture.asset(
                              'assets/svg_images/menu.svg',
                              height: 30,
                            ),
                          ),
                        ),
                        const Text(
                          "Route Map",
                          style: TextStyle(
                            color: Color(0xff12422e),
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
                            padding:
                                const EdgeInsets.only(right: 12.0, bottom: 4),
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
              ],
            ),
          ),
          // Buttons at the top
          Positioned(
            left: 00,
            right: 00,
            bottom: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xffFF6448),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: SizedBox(
                    width: getWidth(context) * 0.35,
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Mark Stop Point',
                      style: TextStyle(
                          color: Color(0xfffefefe),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xffededed),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: SizedBox(
                    width: getWidth(context) * 0.35,
                    child: const Text(
                      textAlign: TextAlign.center,
                      'End Route',
                      style: TextStyle(
                          color: Color(0xff7b7b7b),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure?',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Are you sure you want to set this location as a pick-up point?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: const Color(0xffdddddd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: const Color(0xff60bf8f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:
                  const Text('Confirm', style: TextStyle(color: Colors.white)),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}

// import 'dart:async';

// import 'package:driver_app/screen/emergency/emergency_main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:latlong2/latlong.dart';

// class LiveTrackingMapPage extends StatefulWidget {
//   final LatLng destination = const LatLng(27.7272, 85.3745);

//   const LiveTrackingMapPage({super.key});

//   @override
//   State<LiveTrackingMapPage> createState() => _LiveTrackingMapPageState();
// }

// class _LiveTrackingMapPageState extends State<LiveTrackingMapPage> {
//   LatLng busLocation = const LatLng(27.7172, 85.324);
//   Timer? timer;
//   int currentPointIndex = 0;
//   double progress = 0.0;
//   MapController mapController = MapController();

//   List<LatLng> points = [
//     const LatLng(27.7172, 85.324),
//     const LatLng(27.7200, 85.328),
//     const LatLng(27.7225, 85.332),
//     const LatLng(27.7250, 85.338),
//     const LatLng(27.7272, 85.3745),
//   ];

//   List<Marker> additionalMarkers = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   void startMovementSimulation() {
//     if (points.length < 2) return;

//     timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       setState(() {
//         if (currentPointIndex < points.length - 1) {
//           progress += 0.01;
//           if (progress >= 1.0) {
//             currentPointIndex++;
//             progress = 0.0;
//           }
//           busLocation = _interpolate(points[currentPointIndex],
//               points[currentPointIndex + 1], progress);
//           mapController.move(busLocation, 16.0);
//         } else {
//           timer.cancel();
//         }
//       });
//     });
//   }

//   LatLng _interpolate(LatLng start, LatLng end, double progress) {
//     double lat = start.latitude + (end.latitude - start.latitude) * progress;
//     double lng = start.longitude + (end.longitude - start.longitude) * progress;
//     return LatLng(lat, lng);
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: mapController,
//             options: MapOptions(
//               initialCenter: busLocation,
//               initialZoom: 14.5,
//               onTap: (_, latLng) {
//                 setState(() {
//                   additionalMarkers.add(
//                     Marker(
//                       point: latLng,
//                       child: const Icon(Icons.location_on,
//                           color: Colors.blue, size: 40),
//                     ),
//                   );
//                 });
//               },
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate:
//                     'https://{s}.basemaps.cartocdn.com/rastertiles/light_all/{z}/{x}/{y}.png',
//                 subdomains: const ['a', 'b', 'c'],
//               ),
//               PolylineLayer(
//                 polylines: [
//                   Polyline(
//                     points: points,
//                     strokeWidth: 8.0,
//                     color: const Color(0xff82d3a8),
//                   ),
//                 ],
//               ),
//               MarkerLayer(
//                 markers: [
//                   Marker(
//                     point: points.first,
//                     child: const Icon(
//                       Icons.home,
//                       color: Colors.green,
//                       size: 40,
//                     ),
//                   ),
//                   Marker(
//                     point: busLocation,
//                     child: const Icon(
//                       Icons.directions_bus,
//                       color: Colors.blue,
//                       size: 40,
//                     ),
//                   ),
//                   Marker(
//                     point: points.last,
//                     child: const Icon(Icons.location_on,
//                         color: Colors.red, size: 40),
//                   ),
//                   ...additionalMarkers,
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             top: 50,
//             left: 10,
//             right: 10,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 50,
//                     decoration: const BoxDecoration(
//                       color: Color(0xff9BDCB9),
//                       borderRadius: BorderRadius.all(Radius.circular(25)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back,
//                               color: Color(0xff155037)),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         const Text(
//                           "Route Map",
//                           style: TextStyle(
//                             color: Color(0xff12422e),
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const EmergencyMain(),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(right: 12.0, bottom: 4),
//                             child: SvgPicture.asset(
//                               'assets/svg_images/notification.svg',
//                               height: 20,
//                               width: 20,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 8,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _showConfirmationDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.all(16),
//                     backgroundColor: const Color(0xffFF6448),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.35,
//                     child: const Text(
//                       textAlign: TextAlign.center,
//                       'Mark Stop Point',
//                       style: TextStyle(
//                           color: Color(0xfffefefe),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.all(16),
//                     backgroundColor: const Color(0xffededed),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.35,
//                     child: const Text(
//                       textAlign: TextAlign.center,
//                       'End Route',
//                       style: TextStyle(
//                           color: Color(0xff7b7b7b),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text(
//             'Are you sure?',
//             textAlign: TextAlign.center,
//           ),
//           content: const Text(
//             'Are you sure you want to set this location as a pick-up point?',
//             textAlign: TextAlign.center,
//           ),
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
//                 backgroundColor: const Color(0xff60bf8f),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child:
//                   const Text('Confirm', style: TextStyle(color: Colors.white)),
//               onPressed: () {
//                 setState(() {
//                   additionalMarkers.add(
//                     Marker(
//                       point: busLocation,
//                       child: const Icon(Icons.location_on,
//                           color: Colors.blue, size: 40),
//                     ),
//                   );
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
