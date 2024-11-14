import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadedWidget extends StatefulWidget {
  final String? svgname;
  final String? Title;
  const FileUploadedWidget({super.key, this.svgname, this.Title});

  @override
  State<FileUploadedWidget> createState() => _FileUploadedWidgetState();
}

class _FileUploadedWidgetState extends State<FileUploadedWidget> {
  List<Map<String, dynamic>> files = [];

  // Future<void> _pickImage() async {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       alignment: Alignment.center,
  //       actionsAlignment: MainAxisAlignment.center,
  //       actionsPadding:
  //           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () async {
  //             Navigator.pop(context);
  //             final pickedFile =
  //                 await ImagePicker().pickImage(source: ImageSource.camera);
  //             if (pickedFile != null) {
  //               _startFileUpload(File(pickedFile.path), pickedFile.name);
  //             }
  //           },
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               SvgPicture.asset('assets/svg_images/take_photo.svg'),
  //               const SizedBox(width: 8),
  //               const Text('Take Photograph'),
  //             ],
  //           ),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             Navigator.pop(context);
  //             final pickedFile =
  //                 await ImagePicker().pickImage(source: ImageSource.gallery);
  //             if (pickedFile != null) {
  //               _startFileUpload(File(pickedFile.path), pickedFile.name);
  //             }
  //           },
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               SvgPicture.asset('assets/svg_images/select_album.svg'),
  //               const SizedBox(width: 8),
  //               const Text('Select from album'),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // This makes it take up minimal space
            children: [
              ListTile(
                leading: SvgPicture.asset('assets/svg_images/take_photo.svg'),
                title: const Text('Take Photograph'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    _startFileUpload(File(pickedFile.path), pickedFile.name);
                  }
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/svg_images/select_album.svg'),
                title: const Text('Select from album'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    _startFileUpload(File(pickedFile.path), pickedFile.name);
                  }
                },
              ),
            ],
          ),
        );
      },
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
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
                    '${widget.svgname}',
                    height: 48,
                    width: 48,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${widget.Title}',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        if (files.isNotEmpty) _buildUploadingSection(),
      ],
    );
  }

  Widget _buildUploadingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Uploaded Files',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...files.map((file) => _buildFileItem(file)),
      ],
    );
  }

  Widget _buildFileItem(Map<String, dynamic> file) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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

  void _deleteFile(String fileName) {
    setState(() {
      files.removeWhere((file) => file['fileName'] == fileName);
    });
  }

  void _showDeleteConfirmationDialog(Map<String, dynamic> file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.warning, color: Colors.red),
          content: const Text('Are you sure you want to delete this file?'),
          actionsAlignment: MainAxisAlignment.center,
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
}
