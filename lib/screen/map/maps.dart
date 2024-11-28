import 'dart:async';
import 'dart:developer';

import 'package:driver_app/controller/transportcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

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
  ];

  // User's current location
  LatLng? userLocation;
  late WebSocketChannel channel;
  String receivedData = '';
  // Track zoom and center
  LatLng currentCenter = LatLng(27.7172, 85.3240);
  double currentZoom = 14.5;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    Timer.periodic(
      const Duration(seconds: 2), // Hits the API every 2 seconds
      (Timer timer) async {
        final FlutterSecureStorage _secureStorage =
            const FlutterSecureStorage();
        String? driverId = await _secureStorage.read(key: 'driverId');

        if (driverId != null) {
          var data = {
            "currentLocation": {
              "latitude": userLocation!.latitude.toStringAsFixed(4),
              "longitude": userLocation!.longitude.toStringAsFixed(4)
            }
          };
          log("mahesh ${data}");
          transportBloc.postlocation("6745b249a5ec2c2dd8a90544", data);
        } else {
          // Stop the timer if `driverId` is not found.
          timer.cancel();
        }
      },
    );

    channel = WebSocketChannel.connect(
      Uri.parse('http://62.72.42.129:8090'),
    );

    // Listen to the stream for incoming data
    channel.stream.listen(
      (data) {
        setState(() {
          receivedData = data; // Update UI with the received data
        });
        log('WebSocket Error: ${receivedData}');
      },
      onError: (error) {
        log('WebSocket Error: $error');
      },
      onDone: () {
        log('WebSocket closed');
      },
    );
  }

  @override
  void dispose() {
    // Close the WebSocket connection when the widget is disposed
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  void sendMessage() {
    channel.sink.add('{"message": "Hello WebSocket"}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Location Tracking'),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
          stream: transportBloc.transportInfoInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("data");
            }
            if (snapshot.hasError) {
              return Text("data");
            }
            var datas = snapshot.data!.data;
            return Stack(
              children: [
                // FlutterMap Widget
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: currentCenter,
                    initialZoom: currentZoom,
                    interactionOptions: InteractionOptions(
                      flags: ~InteractiveFlag
                          .doubleTapZoom, // Disable double-tap zoom
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
                          child: const Icon(Icons.home,
                              color: Colors.green, size: 40),
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
                  bottom: 20,
                  left: 20,
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
                  top: 100,
                  right: 60,
                  child: Text(
                      " my location ${datas!.currentLocation!.latitude}  ${datas.currentLocation!.longitude}"),
                )
              ],
            );
          }),
    );
  }
}
