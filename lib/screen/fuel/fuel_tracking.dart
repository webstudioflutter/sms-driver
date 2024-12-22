import 'package:driver_app/controller/Home/FuelTrackingController.dart';
import 'package:driver_app/core/constants/string_constants.dart';
import 'package:driver_app/core/widgets/FileUploadedWidget.dart';
import 'package:driver_app/core/widgets/custom_app_bar.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FuelTrackingMain extends StatefulWidget {
  @override
  State<FuelTrackingMain> createState() => _FuelTrackingMainState();
}

class _FuelTrackingMainState extends State<FuelTrackingMain> {
  final FuelTrackingController _controller = Get.put(FuelTrackingController());

  final List<Map<String, dynamic>> petrolPumpReadingFiles = [];
  final List<String> base64petrolPumpImage = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar(
        context: context,
        title: kFuelTracking,
      ),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuantitySlider(),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'odo_reading'.tr,
                  icon: Icons.speed,
                  controller: _controller.odometerController,
                  hint: 'odo_reading_hint'.tr,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'fuel_rate'.tr,
                  icon: Icons.attach_money,
                  controller: _controller.fuelRateController,
                  hint: 'fuel_rate_hint'.tr,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Petrol_reading'.tr,
                      style: TextStyle(
                        color: Color(0xff545454),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.local_gas_station,
                        color: Color(0xff545454), size: 20),
                  ],
                ),
                const SizedBox(height: 15),
                // FileUploadedWidget(
                //   svgname: "assets/svg_images/upload_icon.svg",
                //   title: "Tap to Upload Image of Pump Reading",
                //   files: _controller.petrolPumpReadingReceipt,
                //   onFileUpload: (file) {
                //     _controller.addFile(file);
                //   },
                // ),

                FileUploadedWidget(
                  svgname: "assets/svg_images/upload_image_receipt.svg",
                  title: 'Petrol_reading_hint'.tr,
                  files: petrolPumpReadingFiles,
                  // onFileUpload: (file) {
                  //   setState(() {
                  //     petrolPumpReadingFiles.add(file);
                  //   });
                  // },
                  onSubmitImages: (base64ImagesList) {
                    setState(() {
                      _controller.petrolPumpReadingImage.clear();
                      // base64petrolPumpImage.clear();
                      // base64petrolPumpImage.addAll(base64ImagesList);
                      // _controller.petrolPumpReadingImage.clear();
                      _controller.petrolPumpReadingImage
                          .addAll(base64ImagesList);
                    });
                  },
                ),
                const SizedBox(height: 45),
                ElevatedButton(
                  onPressed: _controller.isLoading.value
                      ? null
                      : () {
                          _controller.submitFuelTrackingData();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainNavbar(),
                            ),
                            (route) => false,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffff6448),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: _controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'add_fuel_record'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(
                              'assets/svg_images/fuel_reading.svg',
                              color: Colors.white,
                            ),
                          ],
                        ),
                  // const Text(
                  //   'ADD FUEL RECORD',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildQuantitySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     const Text(
        //       'Quantity',
        //       style: TextStyle(
        //         color: Color(0xff545454),
        //         fontSize: 16,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //     const SizedBox(width: 8),
        //     Icon(Icons.local_gas_station),
        //   ],
        // ),
        Row(
          children: [
            Text(
              'quantity'.tr,
              style: TextStyle(
                color: Color(0xff545454),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/svg_images/quantity_fuel.svg',
              height: 20,
              color: Color(0xff545454),
            ),
          ],
        ),
        Obx(() => Slider(
              value: _controller.fuelQuantity.value,
              min: 1,
              max: 100,
              divisions: 50,
              label: '${_controller.fuelQuantity.value.toInt()}L',
              onChanged: (value) {
                _controller.fuelQuantity.value = value;
              },
            )),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String hint,
    Color? iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xff545454),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, color: iconColor),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xffc8c8c8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xffd1d1d1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xffd1d1d1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
