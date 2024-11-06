import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class BillMethod extends StatefulWidget {
  const BillMethod({super.key});

  @override
  _BillMethodState createState() => _BillMethodState();
}

class _BillMethodState extends State<BillMethod> {
  String _selectedDate = 'Select Date';
  File? _selectedImage;
  String? _fileName;

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _fileName = pickedFile.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            const Text(
              'Bill Type',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/svg_images/bill_type.svg',
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Select Bill Type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(children: [
          const Text(
            'Bill Date',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            'assets/svg_images/bill_date.svg',
          ),
        ]),
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
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              'Total Amount',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(
              'assets/svg_images/total_amt.svg',
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter Total Amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 15),
        DottedBorder(
          color: Theme.of(context).primaryColor,
          strokeWidth: 1,
          dashPattern: const [8, 4],
          borderType: BorderType.RRect,
          radius: const Radius.circular(8),
          child: InkWell(
            onTap: _pickImage,
            child: Container(
              height: 150,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _selectedImage == null
                      ? SvgPicture.asset(
                          'assets/svg_images/upload_icon.svg',
                          height: 48,
                          width: 48,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _selectedImage!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                  const SizedBox(height: 10),
                  Text(
                    _selectedImage == null
                        ? 'Tap to upload your bill'
                        : _fileName ?? 'File Uploaded',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
