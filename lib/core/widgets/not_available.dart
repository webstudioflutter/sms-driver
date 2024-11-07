import 'package:flutter/material.dart';

class NotAvailable extends StatelessWidget {
  const NotAvailable({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/notavailable.png",
                width: 300,
                height: 300,
              ),
              const Center(
                child: Text("This feature is not available right now",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ],
          ),
        ));
  }
}
