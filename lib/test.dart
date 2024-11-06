import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background with a curved bottom
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: 330,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.greenAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Profile Card
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Color(0xffcdeede),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: const Color(0xffcdeede),
                    cursorHeight: 16,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.menu),
                      suffixIcon: Icon(Icons.notifications),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 9), // Add padding here
                      // Customize hint text color
                      border: InputBorder.none, // Remove the border
                      focusedBorder:
                          InputBorder.none, // Remove the focused border
                      enabledBorder:
                          InputBorder.none, // Remove the enabled border
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 15,
              right: 15,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          color: Colors.grey,
                          child: const FlutterLogo(
                            size: 60,
                          ),
                        ),
                      ),
                      // SvgPicture.asset(
                      //   'assets/images/attendance.svg', // Load image from assets
                      //   height: 40, // Set a fixed size for the image
                      //   width: 40,
                      // ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Lal Bahadur Ojha',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Bus No.: Ba2 cha 9820',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Add your onPressed logic here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Start Route',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Clipper for the more curved background
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height - 70); // Move the line further down for a deeper curve

    // Lower the control point's y-coordinate to create a more pronounced dip
    var controlPoint = Offset(size.width / 2, size.height + 40);
    var endPoint =
        Offset(size.width, size.height - 70); // Adjust the end point as well

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Custom Clipper for the curved background
// class BottomCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height - 50);
//     var controlPoint = Offset(size.width / 2, size.height);
//     var endPoint = Offset(size.width, size.height - 50);
//     path.quadraticBezierTo(
//         controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
