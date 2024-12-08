import 'dart:async';
import 'dart:developer';

import 'package:driver_app/controller/transportcontroller.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/dashboard/home_drawer.dart';
import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapTrackingPage extends StatefulWidget {
  @override
  _MapTrackingPageState createState() => _MapTrackingPageState();
}

class _MapTrackingPageState extends State<MapTrackingPage> {
  final MapController mapController = MapController();

  // Dummy data for the route
  final List<LatLng> points = [
    LatLng(27.7172, 85.3240), // Kathmandu
    LatLng(27.7182, 85.3250),
    LatLng(27.7192, 85.3260),
    LatLng(27.7202, 85.3270),
    LatLng(27.7202, 85.3290),
  ];

  // User's current location
  LatLng? userLocation;
  String receivedData = '';
  // Track zoom and center
  LatLng currentCenter = LatLng(27.7172, 85.3240);
  double currentZoom = 14.5;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    Timer.periodic(
      const Duration(seconds: 1), // Hits the API every 2 seconds
      (Timer timer) async {
        final _secureStorage = const FlutterSecureStorage();
        String? transportId =
            await _secureStorage.read(key: 'transportationId');

        if (transportId != null) {
          var data = {
            "currentLocation": {
              "latitude": userLocation!.latitude.toStringAsFixed(4),
              "longitude": userLocation!.longitude.toStringAsFixed(4)
            }
          };
          transportBloc.postlocation(transportId, data);
        } else {
          // Stop the timer if `driverId` is not found.
          timer.cancel();
        }
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Stream<Position>? positionStream;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request the user to enable them
      await Geolocator.openLocationSettings();
      return;
    }

    // Check and request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle accordingly
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle accordingly
      return;
    }
    // Create a position stream with a small distance filter (1 meter)
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1, // Detect movements as small as 1 meter
      ),
    );

    // Listen for position changes
    positionStream.listen((Position position) {
      log('Moved to: Lat: ${position.latitude}, Long: ${position.longitude}, Alt: ${position.altitude}');
    });

    // Get the current location
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      // Center the map on the user's location
      mapController.move(userLocation!, currentZoom);
    });

    // Update location periodically
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
        mapController.move(userLocation!, currentZoom);
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomePageDrawer(),
      body: Stack(
        children: [
          // FlutterMap Widget
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentCenter,
              initialZoom: currentZoom,
              interactionOptions: InteractionOptions(
                flags:
                    ~InteractiveFlag.doubleTapZoom, // Disable double-tap zoom
              ),
            ),
            children: [
              // Map tiles
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/light_all/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              // Route polyline
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    strokeWidth: 5.0,
                    color: const Color(0xff0f53ff),
                  ),
                ],
              ),
              // Markers
              MarkerLayer(
                markers: [
                  Marker(
                    point: points.first, // Starting point
                    child:
                        const Icon(Icons.home, color: Colors.green, size: 40),
                  ),
                  if (userLocation != null)
                    Marker(
                      point: userLocation!, // User's location
                      child: const Icon(Icons.person_pin_circle,
                          color: Colors.blue, size: 40),
                    ),
                  Marker(
                    point: points.last, // End point
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 40),
                  ),
                ],
              ),
            ],
          ),

          // Status Bar
          Positioned(
            bottom: 80,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.person_pin_circle, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text(
                    userLocation != null
                        ? 'Your Location: (${userLocation!.latitude.toStringAsFixed(4)}, '
                            '${userLocation!.longitude.toStringAsFixed(4)})'
                        : 'Fetching location...',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
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
            left: 0,
            right: 0,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    width: 120,
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
                    width: 120,
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
