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
        appBar: AppBar(
          title: const Text("Bill Upload"),
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
