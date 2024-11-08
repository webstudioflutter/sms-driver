import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bill_method.dart';
import 'history_method.dart';

class BillMain extends StatefulWidget {
  const BillMain({super.key});

  @override
  _BillMainState createState() => _BillMainState();
}

class _BillMainState extends State<BillMain> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customBar(
          context: context,
          title: 'Bill Upload',
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
                          'assets/svg_images/bill.svg',
                          height: 24,
                          width: 24,
                          color: _selectedIndex == 0
                              ? const Color(0xff60BF8F)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Bill',
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
                          'assets/svg_images/history.svg',
                          height: 24,
                          width: 24,
                          color: _selectedIndex == 1
                              ? const Color(0xff60BF8F)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'History',
                          style: TextStyle(
                            fontSize: 1,
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
