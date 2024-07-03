import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class prescriptionPage extends StatefulWidget {
  final String uid;
  final String age;
  final String address;
  final String gender;
  final String contact;
  final String name;
  const prescriptionPage({
    super.key,
    required this.uid,
    required this.age,
    required this.address,
    required this.gender,
    required this.contact,
    required this.name,
  });

  @override
  _prescriptionPage createState() => _prescriptionPage();
}

class _prescriptionPage extends State<prescriptionPage> {
  late TextEditingController nameController = TextEditingController(text: widget.name);
  late TextEditingController addressController = TextEditingController(text: widget.address);
  late TextEditingController ageController = TextEditingController(text: widget.age);
  late TextEditingController genderController = TextEditingController(text: widget.gender);
  late TextEditingController prescriptionController = TextEditingController();
  late TextEditingController dateCtl;

  File? _image;
  bool _hasUploadedImage = false;

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController(text: _formatDate(DateTime.now()));
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _hasUploadedImage = true;
      } else {
        _hasUploadedImage = false;
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    String fileName = path.basename(_image!.path);
    try {
      Reference storageRef = FirebaseStorage.instance.ref().child('signatures/$fileName');
      UploadTask uploadTask = storageRef.putFile(_image!);
      await uploadTask.whenComplete(() => print('File Uploaded'));

      String fileURL = await storageRef.getDownloadURL();
      print('File URL: $fileURL');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'asset/bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 10),
              child: ListView(
                children: [
                  const backPage(),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 130,
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const SizedBox(
                            child: Image(
                              width: 130,
                              image: AssetImage('asset/dashboard.png'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          children: [
                            Text(
                              'Prescription',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(margin: const EdgeInsets.all(10)),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Batangas State University',
                          style: TextStyle(color: Color(0xddD21f3C), fontSize: 20),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text('Golden Country Homes, Alangilan Batangas City'),
                        ),
                        const Text('Tel No: 123456789'),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: double.infinity,
                          child: CustomPaint(
                            painter: DashedBorderPainter(),
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Column(
                              children: [
                                Text(
                                  'Name:',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                      isDense: true,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(margin: const EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Column(
                              children: [
                                Text(
                                  'Address:',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: addressController,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                      isDense: true,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(margin: const EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Age:',
                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: ageController,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                            isDense: true,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sex:',
                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: genderController,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                            isDense: true,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date:',
                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: dateCtl,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                            isDense: true,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 150,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: prescriptionController,
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: 'Type something...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _hasUploadedImage && _image != null
                                  ? Image.file(_image!, width: 200)
                                  : const SizedBox(
                                child: Image(
                                  width: 200,
                                  image: AssetImage('asset/signature.png'),
                                ),
                              ),
                              Container(
                                width: 200,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                              const Text('Signature')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: _pickImage,
                            child: const Text(
                              'Upload',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              await _uploadImage();
                              Controller().Prescription(widget.uid, prescriptionController.text, dateCtl.text);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Successfully Inserted'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              'Send',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(margin: const EdgeInsets.all(1.5)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 5;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      final space = startX + dashWidth + dashSpace;
      startX = space < size.width ? space : size.width;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
