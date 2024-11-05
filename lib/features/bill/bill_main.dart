import 'package:flutter/material.dart';

class BillMain extends StatelessWidget {
  const BillMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          color: const Color(0xffFAFAFA),
          child: const TabBarView(
            children: [
              BillMethod(),
              HistoryMethod(),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryMethod extends StatelessWidget {
  const HistoryMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}

class BillMethod extends StatelessWidget {
  const BillMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
