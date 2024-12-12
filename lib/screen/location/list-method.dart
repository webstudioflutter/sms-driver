// import 'package:driver_app/core/utils/util.dart';
// import 'package:driver_app/screen/location/Navigate_location.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class AddressList extends StatefulWidget {
//   AddressList({super.key});

//   final List<Address> addresses = [
//     Address("32-B, Balaju Heights, Balaju Bypass", "Rohit Thapa - 6B", "8:34am",
//         contactNumber: "+977 9876766005"),
//     Address(
//         "House No. 15, Bungamati, Lalitpur", "Niraj Maharjan - 2C", "8:34am",
//         contactNumber: "+977 9876766005"),
//     Address("Building 7, Sunrise Apartments", "Pratina Tamang - 4A", "8:34am",
//         contactNumber: "+977 9876766005"),
//     Address("Building 4, Sunrise Apartments", "Aashika Basnet - 4A", "8:34am",
//         contactNumber: "+977 9876766005"),
//     Address("14B, Shantinagar Marg, Koteshwor", "Prakash Karki - 6B", "8:34am",
//         contactNumber: "+977 9876766005"),
//     Address("Unit 11, Shree Apartments", "Puja Bajracharya - 9B", "8:34am",
//         contactNumber: "+977 9876766005"),
//     Address("House 10, Green Valley Housing", "Krishna Shrestha - 3A", "8:34am",
//         contactNumber: "+977 9876766005"),
//   ];

//   @override
//   _AddressListState createState() => _AddressListState();
// }

// class _AddressListState extends State<AddressList> {
//   List<bool> expandedStates = [];

//   @override
//   void initState() {
//     super.initState();

//     expandedStates = List.filled(widget.addresses.length, false);
//   }

//   void _toggleExpand(int index) {
//     setState(() {
//       expandedStates[index] = !expandedStates[index];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         SizedBox(height: getHeight(context) * 0.02),
//         Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//           Image.asset('assets/images/bus_route.png'),
//           // SizedBox(width: getWidth(context) * 0.1),
//           const Column(children: [
//             Text(
//               'Route No: 33450',
//               style: TextStyle(color: Colors.grey),
//             ),
//             Text('Total: 36 students'),
//             Text('Completed: 3/36'),
//             Text('Started: 8:03am, 10/21/2024'),
//           ]),
//         ]),
//         SizedBox(height: getHeight(context) * 0.02),
//         Expanded(
//           child: ListView.builder(
//             itemCount: widget.addresses.length,
//             itemBuilder: (context, index) {
//               final address = widget.addresses[index];
//               final isExpanded = expandedStates[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                 child: InkWell(
//                   onTap: () => _toggleExpand(index),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: const Color(0x77adadad),
//                               radius: 25,
//                               child: CircleAvatar(
//                                 backgroundColor: const Color(0xffadadad),
//                                 radius: 15,
//                                 child: Text(
//                                   "${index + 1}",
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     address.addressLine,
//                                     style: const TextStyle(),
//                                   ),
//                                   Text(
//                                     address.unitDetails,
//                                     style: const TextStyle(
//                                         color: Color(0xff676767)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                   address.time,
//                                   style: const TextStyle(color: Colors.grey),
//                                 ),
//                                 SvgPicture.asset(
//                                   'assets/svg_images/tick.svg',
//                                   width: 30,
//                                   height: 25,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: getHeight(context) * 0.01),
//                         if (isExpanded)
//                           Center(
//                             child: Column(
//                               children: [
//                                 const Text(
//                                   textAlign: TextAlign.center,
//                                   "Contact Number",
//                                   style: TextStyle(
//                                       color: Color(0xffadadad), fontSize: 14),
//                                 ),
//                                 Text(
//                                   address.contactNumber!,
//                                   style: const TextStyle(
//                                       color: Color(0xff363636), fontSize: 16),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const RouteMapScreen()));
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xff60bf8f),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                   child: SizedBox(
//                                     width: getWidth(context) * 0.45,
//                                     child: const Text(
//                                       textAlign: TextAlign.center,
//                                       "Navigate",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 16),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Address {
//   final String addressLine;
//   final String unitDetails;
//   final String time;
//   final String? contactNumber;

//   Address(this.addressLine, this.unitDetails, this.time, {this.contactNumber});
// }

import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/location/Navigate_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddressList extends StatefulWidget {
  AddressList({super.key});

  final List<Address> addresses = [
    Address("32-B, Balaju Heights, Balaju Bypass", "Rohit Thapa - 6B", "8:34am",
        contactNumber: "+977 9876766005"),
    Address(
        "House No. 15, Bungamati, Lalitpur", "Niraj Maharjan - 2C", "8:34am",
        contactNumber: "+977 9876766005"),
    Address("Building 7, Sunrise Apartments", "Pratina Tamang - 4A", "8:34am",
        contactNumber: "+977 9876766005"),
    Address("Building 4, Sunrise Apartments", "Aashika Basnet - 4A", "8:34am",
        contactNumber: "+977 9876766005"),
    Address("14B, Shantinagar Marg, Koteshwor", "Prakash Karki - 6B", "8:34am",
        contactNumber: "+977 9876766005"),
    Address("Unit 11, Shree Apartments", "Puja Bajracharya - 9B", "8:34am",
        contactNumber: "+977 9876766005"),
    Address("House 10, Green Valley Housing", "Krishna Shrestha - 3A", "8:34am",
        contactNumber: "+977 9876766005"),
  ];

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  List<bool> expandedStates = [];

  @override
  void initState() {
    super.initState();
    expandedStates = List.filled(widget.addresses.length, false);
  }

  void _toggleExpand(int index) {
    setState(() {
      expandedStates[index] = !expandedStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: getHeight(context) * 0.02),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Image.asset('assets/images/bus_route.png'),
          const Column(children: [
            Text(
              'Route No: 33450',
              style: TextStyle(color: Colors.grey),
            ),
            Text('Total: 36 students'),
            Text('Completed: 3/36'),
            Text('Started: 8:03am, 10/21/2024'),
          ]),
        ]),
        SizedBox(height: getHeight(context) * 0.02),
        Expanded(
          child: ListView.builder(
            itemCount: widget.addresses.length,
            itemBuilder: (context, index) {
              final address = widget.addresses[index];
              final isExpanded = expandedStates[index];
              return Container(
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
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: InkWell(
                  onTap: () => _toggleExpand(index),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0x77adadad),
                              radius: 25,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xffadadad),
                                radius: 15,
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address.addressLine,
                                    style: const TextStyle(),
                                  ),
                                  Text(
                                    address.unitDetails,
                                    style: const TextStyle(
                                        color: Color(0xff676767)),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  address.time,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                SvgPicture.asset(
                                  'assets/svg_images/tick.svg',
                                  width: 30,
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight(context) * 0.01),
                        if (isExpanded)
                          Center(
                            child: Column(
                              children: [
                                const Text(
                                  textAlign: TextAlign.center,
                                  "Contact Number",
                                  style: TextStyle(
                                      color: Color(0xffadadad), fontSize: 14),
                                ),
                                Text(
                                  address.contactNumber!,
                                  style: const TextStyle(
                                      color: Color(0xff363636), fontSize: 16),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NavigateLocation()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff60bf8f),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: getWidth(context) * 0.45,
                                    child: const Text(
                                      textAlign: TextAlign.center,
                                      "Navigate",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
              );
            },
          ),
        ),
      ],
    );
  }
}

class Address {
  final String addressLine;
  final String unitDetails;
  final String time;
  final String? contactNumber;

  Address(this.addressLine, this.unitDetails, this.time, {this.contactNumber});
}
