import 'dart:async';

import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class NavigateLocation extends StatefulWidget {
  final LatLng destination = const LatLng(27.7272, 85.3745);

  NavigateLocation({super.key});

  @override
  State<NavigateLocation> createState() => _NavigateLocationState();
}

class _NavigateLocationState extends State<NavigateLocation> {
  LatLng busLocation = const LatLng(27.7172, 85.324);
  Timer? timer;
  int currentPointIndex = 0;
  double progress = 0.0;
  MapController mapController = MapController();
  List<Map<String, String>> navDetails = [
    {'name': 'Charlie Press', 'class': '5A', 'location': 'Kathmandu'},
    {'name': 'Ahamad Donin', 'class': '4B', 'location': 'Lalitpur'},
  ];

  List<LatLng> points = [
    const LatLng(27.7172, 85.324),
    const LatLng(27.7200, 85.328),
    const LatLng(27.7250, 85.338),
    const LatLng(27.7272, 85.3745),
  ];

  @override
  void initState() {
    super.initState();
  }

  void startMovementSimulation() {
    if (points.length < 2) return;

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (currentPointIndex < points.length - 1) {
          progress += 0.01;
          if (progress >= 1.0) {
            currentPointIndex++;
            progress = 0.0;
          }
          busLocation = _interpolate(points[currentPointIndex],
              points[currentPointIndex + 1], progress);

          mapController.move(busLocation, 16.0);
        } else {
          timer.cancel();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    point: points.first,
                    child: const Icon(
                      Icons.home,
                      color: Colors.green,
                      size: 40,
                      semanticLabel: "Start Point",
                    ),
                  ),
                  Marker(
                    point: busLocation,
                    child: const Icon(
                      Icons.directions_bus,
                      color: Colors.blue,
                      size: 40,
                      semanticLabel: "Baneshwor",
                    ),
                  ),
                  Marker(
                    point: points[1],
                    child: const Icon(Icons.location_on,
                        color: Colors.orange, size: 40),
                  ),
                  Marker(
                    point: points[2],
                    child: const Icon(Icons.location_on,
                        color: Colors.orange, size: 40),
                  ),
                  Marker(
                    point: points[3],
                    child: const Icon(Icons.location_on,
                        color: Colors.orange, size: 40),
                  ),
                  Marker(
                    point: points.last,
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 40),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 50,
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
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Color(0xff155037)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    itemCount: navDetails.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 0.5,
                                      color: Colors.grey.withOpacity(0.2),
                                      offset: Offset(0.5, 0.5),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/fake_profile.jpg',
                                        width: getHeight(context) * 0.07,
                                        height: getHeight(context) * 0.07,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: getHeight(context) * 0.01),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          navDetails[index]['name']!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Class: ${navDetails[index]['class']}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff345326),
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    getHeight(context) * 0.01),
                                            Text(
                                              'Location: ${navDetails[index]['location']}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff345326),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                        'assets/svg_images/present.svg'),
                                    SizedBox(width: getHeight(context) * 0.01),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: getHeight(context) * 0.015),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
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
