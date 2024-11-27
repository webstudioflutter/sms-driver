import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

// class FileUploadedWidget extends StatefulWidget {
//   final String? svgname;
//   final String? title;
//   final List<Map<String, dynamic>> files; // File state passed from parent
//   final void Function(Map<String, dynamic>) onFileUpload; // Callback for parent

//   const FileUploadedWidget({
//     super.key,
//     this.svgname,
//     this.title,
//     required this.files,
//     required this.onFileUpload,
//   });

//   @override
//   State<FileUploadedWidget> createState() => _FileUploadedWidgetState();
// }

// class _FileUploadedWidgetState extends State<FileUploadedWidget> {
//   Future<void> _pickImage() async {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: SvgPicture.asset('assets/svg_images/take_photo.svg'),
//                 title: const Text('Take Photograph'),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   final pickedFile =
//                       await ImagePicker().pickImage(source: ImageSource.camera);
//                   if (pickedFile != null) {
//                     final fileData = {
//                       'fileName': pickedFile.name,
//                       'file': File(pickedFile.path),
//                       'progress': 0.0,
//                       'isUploaded': false,
//                     };
//                     widget.onFileUpload(fileData);
//                     _simulateUpload(fileData);
//                   }
//                 },
//               ),
//               ListTile(
//                 leading: SvgPicture.asset('assets/svg_images/select_album.svg'),
//                 title: const Text('Select from album'),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   final pickedFile = await ImagePicker()
//                       .pickImage(source: ImageSource.gallery);
//                   if (pickedFile != null) {
//                     final fileData = {
//                       'fileName': pickedFile.name,
//                       'file': File(pickedFile.path),
//                       'progress': 0.0,
//                       'isUploaded': false,
//                     };
//                     widget.onFileUpload(fileData);
//                     _simulateUpload(fileData);
//                   }
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _simulateUpload(Map<String, dynamic> fileData) {
//     Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       setState(() {
//         int index = widget.files
//             .indexWhere((f) => f['fileName'] == fileData['fileName']);
//         if (index != -1) {
//           if (widget.files[index]['progress'] < 1.0) {
//             widget.files[index]['progress'] += 0.1;
//           } else {
//             widget.files[index]['progress'] = 1.0;
//             widget.files[index]['isUploaded'] = true;
//             timer.cancel();
//           }
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DottedBorder(
//           color: Theme.of(context).primaryColor,
//           strokeWidth: 1,
//           dashPattern: const [8, 4],
//           borderType: BorderType.RRect,
//           radius: const Radius.circular(8),
//           child: InkWell(
//             onTap: _pickImage,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               alignment: Alignment.center,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                     '${widget.svgname}',
//                     height: 48,
//                     width: 48,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     '${widget.title}',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 15),
//         if (widget.files.isNotEmpty) _buildUploadingSection(),
//       ],
//     );
//   }

//   Widget _buildUploadingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             'Uploaded Files',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         ...widget.files.map((file) => _buildFileItem(file)),
//       ],
//     );
//   }

//   Widget _buildFileItem(Map<String, dynamic> file) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.green),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(file['fileName']),
//               ),
//               file['isUploaded']
//                   ? Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 20,
//                           backgroundColor: const Color(0x33dddddd),
//                           child: IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () =>
//                                 _showDeleteConfirmationDialog(file),
//                           ),
//                         ),
//                       ],
//                     )
//                   : Expanded(
//                       child: LinearProgressIndicator(
//                         value: file['progress'],
//                         minHeight: 5.0,
//                       ),
//                     ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   void _showDeleteConfirmationDialog(Map<String, dynamic> file) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           actionsAlignment: MainAxisAlignment.center,
//           title: SvgPicture.asset('assets/svg_images/delete_confirm.svg'),
//           content: const Text(
//             'Are you sure you want to delete this file?',
//             style: TextStyle(
//               color: Color(0xff2b2b2b),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.all(10),
//                     backgroundColor: const Color(0xffdddddd),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.close, color: Color(0xff545454)),
//                       const Text('Cancel',
//                           style: TextStyle(color: Color(0xff545454))),
//                     ],
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.all(10),
//                     backgroundColor: const Color(0xffff3333),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.delete, color: Colors.white),
//                       const Text('Delete',
//                           style: TextStyle(color: Colors.white)),
//                     ],
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       widget.files.removeWhere(
//                           (f) => f['fileName'] == file['fileName']);
//                     });
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }

// }

class FileUploadedWidget extends StatefulWidget {
  final String? svgname;
  final String? title;
  final List<Map<String, dynamic>> files; // File state passed from parent
  final void Function(List<String>)
      onSubmitImages; // Callback for Base64 list submission

  const FileUploadedWidget({
    super.key,
    this.svgname,
    this.title,
    required this.files,
    required this.onSubmitImages,
  });

  @override
  State<FileUploadedWidget> createState() => _FileUploadedWidgetState();
}

class _FileUploadedWidgetState extends State<FileUploadedWidget> {
  final List<String> _base64Images = [];

  // void _addFile(Map<String, dynamic> file) {
  //   setState(() {
  //     widget.files.add(file);

  //     // Convert file to Base64
  //     final fileBytes = (file['file'] as File).readAsBytesSync();
  //     final base64String = base64Encode(fileBytes);
  //     _base64Images.add(base64String);

  //     // Notify parent widget
  //     widget.onFileUpload(file);
  //     widget.onSubmitImages(_base64Images);
  //   });
  // }
  void _addFile(Map<String, dynamic> file) {
    // Check if file already exists in the list
    if (widget.files.any((f) => f['fileName'] == file['fileName'])) {
      return; // Avoid duplication
    }

    setState(() {
      widget.files.add(file);

      // Convert file to Base64
      try {
        final fileBytes = (file['file'] as File).readAsBytesSync();
        final base64String = base64Encode(fileBytes);

        // Add Base64 string to list
        _base64Images.add("data:image/jpeg;base64,${base64String}");

        // Notify parent widget with the updated list
        widget.onSubmitImages(List<String>.from(_base64Images));
      } catch (e) {
        debugPrint("Error encoding file to Base64: $e");
      }
    });
  }

  void _removeFile(Map<String, dynamic> file) {
    setState(() {
      widget.files.removeWhere((f) => f['fileName'] == file['fileName']);

      // Convert file to Base64 and remove it
      final fileBytes = (file['file'] as File).readAsBytesSync();
      final base64String = base64Encode(fileBytes);
      _base64Images.remove(base64String);

      // Notify parent widget
      widget.onSubmitImages(_base64Images);
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
                    '${widget.title}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        if (widget.files.isNotEmpty) _buildUploadingSection(),
      ],
    );
  }

  // void _pickImage() async {
  //   // Code for picking an image
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final fileData = {
  //       'fileName': pickedFile.name,
  //       'file': File(pickedFile.path),
  //       'progress': 0.0,
  //       'isUploaded': false,
  //     };
  //     _addFile(fileData);
  //   }
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
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SvgPicture.asset('assets/svg_images/take_photo.svg'),
                title: const Text('Take Photograph'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    final fileData = {
                      'fileName': pickedFile.name,
                      'file': File(pickedFile.path),
                      'progress': 0.0,
                      'isUploaded': false,
                    };
                    _addFile(fileData);
                    _simulateUpload(fileData);
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
                    final fileData = {
                      'fileName': pickedFile.name,
                      'file': File(pickedFile.path),
                      'progress': 0.0,
                      'isUploaded': false,
                    };
                    _addFile(fileData);

                    // widget.onFileUpload(fileData);
                    _simulateUpload(fileData);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _simulateUpload(Map<String, dynamic> fileData) {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        int index = widget.files
            .indexWhere((f) => f['fileName'] == fileData['fileName']);
        if (index != -1) {
          if (widget.files[index]['progress'] < 1.0) {
            widget.files[index]['progress'] += 0.1;
          } else {
            widget.files[index]['progress'] = 1.0;
            widget.files[index]['isUploaded'] = true;
            timer.cancel();
          }
        }
      });
    });
  }

  void _showDeleteConfirmationDialog(Map<String, dynamic> file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: SvgPicture.asset('assets/svg_images/delete_confirm.svg'),
          content: const Text(
            'Are you sure you want to delete this file?',
            style: TextStyle(
              color: Color(0xff2b2b2b),
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: const Color(0xffdddddd),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.close, color: Color(0xff545454)),
                      const Text('Cancel',
                          style: TextStyle(color: Color(0xff545454))),
                    ],
                  ),
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
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      const Text('Delete',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                    // setState(() {
                    //   widget.files.removeWhere(
                    //       (f) => f['fileName'] == file['fileName']);
                    // });

                    setState(() {
                      widget.files.removeWhere(
                          (f) => f['fileName'] == file['fileName']);

                      // Convert file to Base64 and remove it
                      final fileBytes =
                          (file['file'] as File).readAsBytesSync();
                      final base64String = base64Encode(fileBytes);
                      _base64Images.remove(base64String);

                      // Notify parent widget
                      widget.onSubmitImages(_base64Images);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
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
        ...widget.files.map((file) => _buildFileItem(file)),
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
            borderRadius: BorderRadius.circular(8),
          ),
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
}
