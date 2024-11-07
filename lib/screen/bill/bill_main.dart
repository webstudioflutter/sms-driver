import 'package:driver_app/screen/emergency/emergency_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bill_method.dart';
import 'history_method.dart';

class BillMain extends StatelessWidget {
  const BillMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background with a curved bottom
              Container(
                height: 110,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff6bccc1),
                        Color(0xff6fcf99)
                      ], // Gradient colors
                      begin: Alignment.topLeft, // Start point of gradient
                      end: Alignment.bottomRight, // End point of gradient
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
              ),
              Positioned(
                top: 20,
                left: 10,
                right: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50, // Height of the container
                        decoration: const BoxDecoration(
                            color: Color(0xffcdeede),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),

                        child: TextFormField(
                          cursorColor: const Color(0xffcdeede),
                          // cursorHeight: 16,
                          decoration: InputDecoration(
                            labelText: "Bill Upload",
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const HomePage()));
                              },
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(Icons.notifications_active_sharp,
                                  color: Colors.red.shade500),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EmergencyMain()));
                              },
                            ),

                            border: InputBorder.none, // Remove the border
                            focusedBorder:
                                InputBorder.none, // Remove the focused border
                            enabledBorder:
                                InputBorder.none, // Remove the enabled border
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: const Color(0xffFAFAFA),
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg_images/bill.svg',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Bill',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg_images/history.svg',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    BillMethod(),
                    HistoryMethod(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
