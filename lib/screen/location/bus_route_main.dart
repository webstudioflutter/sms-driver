import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:driver_app/screen/location/list-method.dart';
import 'package:driver_app/screen/location/map_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BusRouteMain extends StatefulWidget {
  const BusRouteMain({super.key});

  @override
  State<BusRouteMain> createState() => _BusRouteMainState();
}

class _BusRouteMainState extends State<BusRouteMain> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customBar(
          context: context,
          title: 'Route List',
        ),
        body: Container(
          color: const Color(0xffFAFAFA),
          child: Column(
            children: [
              TabBar(
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg_images/route-list.svg',
                          height: 24,
                          width: 24,
                          color: _selectedIndex == 0
                              ? const Color(0xff60BF8F)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'List',
                          style: TextStyle(
                            fontSize: 16,
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
                          'assets/svg_images/map.svg',
                          height: 24,
                          width: 24,
                          color: _selectedIndex == 1
                              ? const Color(0xff60BF8F)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Map',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                indicatorColor: const Color(0xff60BF8F),
                labelColor: const Color(0xff60BF8F),
                unselectedLabelColor: Colors.grey,
              ),
              Expanded(
                child: TabBarView(
                  children: [AddressList(), const MapMethod()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
