import 'package:driver_app/core/widgets/FileUploadedWidget.dart';
import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FuelTrackingMain extends StatefulWidget {
  const FuelTrackingMain({super.key});

  @override
  _FuelTrackingMainState createState() => _FuelTrackingMainState();
}

class _FuelTrackingMainState extends State<FuelTrackingMain> {
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar(
        context: context,
        title: 'Fuel Tracking',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Quantity',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/svg_images/quantity_fuel.svg',
                      height: 20),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: const Color(0xff6fcf99),
                      inactiveTrackColor: Colors.grey.shade300,
                      trackHeight: 10.0,
                      thumbColor: const Color(0xff6bccc1),
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 10.0),
                      valueIndicatorTextStyle:
                          const TextStyle(color: Colors.white),
                    ),
                    child: Slider(
                      value: _currentSliderValue,
                      min: 1,
                      max: 50,
                      divisions: 50,
                      label: '${_currentSliderValue.toInt()}L',
                      onChanged: (value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1L'),
                  Text('10L'),
                  Text('20L'),
                  Text('30L'),
                  Text('40L'),
                  Text('50L'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Odometer Reading',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/svg_images/ep_odometer.svg'),
                ],
              ),
              const SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Reading on Odometer',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Petrol Pump Reading',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/svg_images/fuel_reading.svg'),
                ],
              ),
              const SizedBox(height: 15),
              const FileUploadedWidget(
                svgname: "assets/svg_images/upload_icon.svg",
                Title: "Tap to Upload Image of Pump Reading",
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Fuel Receipt',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/svg_images/bill_receipt.svg'),
                ],
              ),
              const SizedBox(height: 15),
              const FileUploadedWidget(
                svgname: "assets/svg_images/upload_icon.svg",
                Title: "Tap to Upload Image of Fuel Receipt",
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff60BF8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ADD FUEL RECORD',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset('assets/svg_images/fuel_reading.svg',
                        color: Colors.white),
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
