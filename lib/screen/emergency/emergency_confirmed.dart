import 'package:driver_app/screen/dashboard/home_page.dart';
import 'package:flutter/material.dart';

class EmergencyConfirmedPage extends StatelessWidget {
  const EmergencyConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Custom height
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 20,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text(
                            "Emergency",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                          ),
                        ],
                      ),
                      // child: TextFormField(
                      //   cursorColor: const Color(0xffcdeede),
                      //   decoration: InputDecoration(
                      //     hintText: "Emergency",
                      //     labelStyle: const TextStyle(color: Colors.white),
                      //     prefixIcon: IconButton(
                      //       icon: const Icon(Icons.arrow_back,
                      //           color: Colors.white),
                      //       onPressed: () {
                      //         Navigator.of(context).pop();
                      //       },
                      //     ),
                      //     border: InputBorder.none,
                      //     focusedBorder: InputBorder.none,
                      //     enabledBorder: InputBorder.none,
                      //     suffixIcon: IconButton(
                      //       icon: const Icon(Icons.close, color: Colors.white),
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => const HomePage()));
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ),

                    //   child: Container(
                    //     height: 50,
                    //     decoration: const BoxDecoration(
                    //       color: Color(0xffff3333),
                    //       borderRadius: BorderRadius.all(Radius.circular(25)),
                    //     ),
                    //     child: TextFormField(
                    //       cursorColor: const Color(0xffcdeede),
                    //       decoration: InputDecoration(
                    //         labelText: "Emergency",
                    //         labelStyle: const TextStyle(color: Colors.white),
                    //         prefixIcon: IconButton(
                    //           icon: const Icon(Icons.arrow_back,
                    //               color: Colors.white),
                    //           onPressed: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => const HomePage()));
                    //           },
                    //         ),
                    //         border: InputBorder.none,
                    //         focusedBorder: InputBorder.none,
                    //         enabledBorder: InputBorder.none,
                    //         suffixIcon: IconButton(
                    //           icon: const Icon(Icons.close, color: Colors.white),
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmergencyConfirmedPage()));
              },
              child: const CircleAvatar(
                radius: 110,
                backgroundColor: Color(0x33FFFFFF),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'SOS alert activated.Help is on the way.Stay calm and safe.',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
