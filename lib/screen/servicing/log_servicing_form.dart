import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class LogServicingForm extends StatefulWidget {
  const LogServicingForm({super.key});

  @override
  _LogServicingFormState createState() => _LogServicingFormState();
}

class _LogServicingFormState extends State<LogServicingForm> {
  String _selectedDate = 'Select Date';
  List<Map<String, dynamic>> files = [];
  File? _selectedImage;
  String? _fileName;
  List<String> checkboxLabels = [
    "Brake Pads",
    "Battery",
    "Starter Motor",
    "Spark Plugs",
    "Tires",
    "Wiper Blades",
    "Air Filter",
    "Others",
  ];
  List<bool> checkboxValues = List.filled(8, false);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // Method to choose between taking a photo or selecting from the gallery
  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                _startFileUpload(File(pickedFile.path), pickedFile.name);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg_images/take_photo.svg'),
                const SizedBox(width: 8),
                const Text('Take Photograph'),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                _startFileUpload(File(pickedFile.path), pickedFile.name);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg_images/select_album.svg'),
                const SizedBox(width: 8),
                const Text('Select from album'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startFileUpload(File file, String fileName) {
    setState(() {
      files.add({
        'fileName': fileName,
        'file': file,
        'progress': 0.0,
        'isUploaded': false,
      });
    });

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        int index = files.indexWhere((f) => f['fileName'] == fileName);
        if (index != -1) {
          if (files[index]['progress'] < 1.0) {
            files[index]['progress'] += 0.1;
          } else {
            files[index]['progress'] = 1.0;
            files[index]['isUploaded'] = true;
            timer.cancel();
          }
        }
      });
    });
  }

  // Method to delete a file from the list
  void _deleteFile(String fileName) {
    setState(() {
      files.removeWhere((file) => file['fileName'] == fileName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: 30,
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
                            labelText: "Servicing",
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
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                height: 5,
                                width: 5,
                                child: SvgPicture.asset(
                                  'assets/svg_images/notification.svg',
                                ),
                              ),
                            ),
                            // suffixIcon: IconButton(
                            //   icon: Icon(Icons.notifications_active_sharp,
                            //       color: Colors.red.shade500),
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const EmergencyMain()));
                            //   },
                            // ),

                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
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
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildServiceDateSection(),
            const SizedBox(height: 15),
            _buildCheckboxSection(),
            const SizedBox(height: 25),
            _buildTotalAmountSection(),
            const SizedBox(height: 15),
            _buildFileUploadSection(),
            const SizedBox(height: 20),
            _buildUploadingSection(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const SizedBox(
                    width: 150,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showSubmitDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: const Color(0xff60BF8F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const SizedBox(
                    width: 150,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  // Bill Date section
  Widget _buildServiceDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Servicing Date',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/svg_images/bill_date.svg'),
          ],
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: const Icon(Icons.calendar_month_outlined),
            ),
            child: Text(_selectedDate),
          ),
        ),
      ],
    );
  }

  // Widget _buildCheckboxSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           const Text(
  //             'Parts Replaced',
  //             style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w500),
  //           ),
  //           const SizedBox(width: 8),
  //           SvgPicture.asset('assets/svg_images/part_replacement.svg'),
  //         ],
  //       ),
  //       const SizedBox(height: 5),
  //       GridView.builder(
  //         shrinkWrap: true,
  //         itemCount: checkboxLabels.length,
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2,
  //           childAspectRatio: 3.5,
  //         ),
  //         itemBuilder: (context, index) {
  //           return CheckboxListTile(
  //             title: Text(checkboxLabels[index]),
  //             value: checkboxValues[index],
  //             onChanged: (value) {
  //               setState(() {
  //                 checkboxValues[index] = value!;
  //               });
  //             },
  //           );
  //         },
  //       )
  //     ],
  //   );
  // }

  // Total Amount section
  Widget _buildTotalAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Total Amount',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset('assets/svg_images/total_amt.svg'),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter Total Amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // Checkbox Section
  Widget _buildCheckboxSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Parts Replaced',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/svg_images/part_replacement.svg'),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 6,
          ),
          itemCount: checkboxLabels.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(checkboxLabels[index]),
              value: checkboxValues[index],
              onChanged: (value) {
                setState(() {
                  checkboxValues[index] = value!;
                });
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildFileUploadSection() {
    return DottedBorder(
      color: Theme.of(context).primaryColor,
      strokeWidth: 1,
      dashPattern: const [8, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: InkWell(
        onTap: _pickImage,
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg_images/upload_image_receipt.svg',
                height: 48,
                width: 48,
              ),
              const SizedBox(height: 10),
              const Text(
                'Tap to Upload Image of Reciept',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Display the progress of each uploaded file
  Widget _buildUploadingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Uploaded Files',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 10),
        ...files.map((file) => _buildFileItem(file)),
      ],
    );
  }

  // Display each file with its progress indicator and delete button
  Widget _buildFileItem(Map<String, dynamic> file) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(file['fileName']),
              ),
              file['isUploaded']
                  ? Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0x33dddddd),
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _showDeleteConfirmationDialog(file),
                          ),
                        ),
                      ],
                    )
                  : Expanded(
                      child: LinearProgressIndicator(
                        value: file['progress'],
                        minHeight: 5.0,
                      ),
                    ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Confirm deletion of file
  void _showDeleteConfirmationDialog(Map<String, dynamic> file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.warning, color: Colors.red),
          content: const Text('Are you sure you want to delete this file?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: const Color(0xffdddddd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: const Color(0xffff3333),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:
                  const Text('Delete', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _deleteFile(file['fileName']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show submit confirmation dialog
  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: CircleAvatar(
              radius: 30,
              backgroundColor: Color(0x33008000),
              child: Icon(
                Icons.check_outlined,
                color: Colors.green,
                size: 30,
              )),
          content: Text('Your bill has been sucessfully upload!'),
        );
      },
    );
  }
}
