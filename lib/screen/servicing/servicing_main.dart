import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:driver_app/screen/servicing/log_servicing_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServicingMain extends StatefulWidget {
  const ServicingMain({super.key});

  @override
  _ServicingMainState createState() => _ServicingMainState();
}

class _ServicingMainState extends State<ServicingMain> {
  final List<Map<String, String>> servicehistory = [
    {
      'date': '07 August, 2024',
      'items': 'Brake Pads, Wiper Blades,Air Filler',
      'price': 'Rs.25000'
    },
    {
      'date': '07 August, 2024',
      'items': 'Brake Pads, Wiper Blades,Air Filler',
      'price': 'Rs.25000'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customBar(
        context: context,
        title: 'Servicing',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _servicingDateContent(),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Servicing History',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff363636),
                    ),
                  ),
                  const SizedBox(width: 15),
                  SvgPicture.asset(
                    'assets/svg_images/history.svg',
                    height: 25,
                    width: 25,
                  ),
                ],
              ),
            ),
            _servingHistoryContent(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogServicingForm()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const SizedBox(
                  width: 350,
                  child: Text(
                    "LOG SERVICING",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  Widget _servicingDateContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Next Servicing Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff363636),
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                'assets/svg_images/scheduled-maintenance.svg',
                height: 25,
                width: 25,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(width: 5),
              const Text(
                '5th November',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff221f1f),
                ),
              ),
              SizedBox(width: MediaQuery.sizeOf(context).width * 0.04),
              const Text(
                '13 days from today',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _servingHistoryContent() {
    return Expanded(
      child: ListView.builder(
        itemCount: servicehistory.length,
        itemBuilder: (context, index) {
          final item = servicehistory[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined,
                            color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          item['date'] ?? '',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff787878)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${item['items']}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${item['price']}',
                      style: const TextStyle(
                          color: Color(0xff787878),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
