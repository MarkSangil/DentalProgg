// ignore_for_file: file_names

import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
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
  // ignore: library_private_types_in_public_api
  _prescriptionPage createState() => _prescriptionPage();
}

// ignore: camel_case_types
class _prescriptionPage extends State<prescriptionPage> {
  late TextEditingController nameController =
      TextEditingController(text: widget.name);
  late TextEditingController addressController =
      TextEditingController(text: widget.address);
  late TextEditingController ageController =
      TextEditingController(text: widget.age);
  late TextEditingController genderController =
      TextEditingController(text: widget.gender);
  late TextEditingController prescriptionController = TextEditingController();

  late TextEditingController dateCtl;

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController(text: _formatDate(DateTime.now()));
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              'asset/bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
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

                        const SizedBox(
                            width: 10), // Add some space between the containers

                        const Column(
                          children: [
                            Text(
                              'Prescription',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                  ),
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
                          style:
                              TextStyle(color: Color(0xddD21f3C), fontSize: 20),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text(
                              'Golden Country Homes, Alangilan Batangas City'),
                        ),
                        const Text('Tel No: 123456789'),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: double.infinity,
                          child: CustomPaint(
                            painter: DashedBorderPainter(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                        ),
                        Row(
                          children: [
                            const Column(
                              children: [
                                Text(
                                  'Name:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller:
                                        nameController, // Provide your controller here
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          12,
                                          0,
                                          12,
                                          0), // Adjust the values to move the text closer to the top
                                      isDense:
                                          true, // Reduces the vertical padding
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                        ),
                        Row(
                          children: [
                            const Column(
                              children: [
                                Text(
                                  'Address:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller:
                                        addressController, // Provide your controller here
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          12,
                                          0,
                                          12,
                                          0), // Adjust the values to move the text closer to the top
                                      isDense:
                                          true, // Reduces the vertical padding
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Age:',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller:
                                              ageController, // Provide your controller here
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12,
                                                0,
                                                12,
                                                0), // Adjust the values to move the text closer to the top
                                            isDense:
                                                true, // Reduces the vertical padding
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sex:',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller:
                                              genderController, // Provide your controller here
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12,
                                                0,
                                                12,
                                                0), // Adjust the values to move the text closer to the top
                                            isDense:
                                                true, // Reduces the vertical padding
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date:',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: dateCtl,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12,
                                                0,
                                                12,
                                                0), // Adjust the values to move the text closer to the top
                                            isDense:
                                                true, // Reduces the vertical padding
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
                              maxLines: null, // Allow multiline input

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
                              const SizedBox(
                                child: Image(
                                    width: 200,
                                    image: AssetImage('asset/sinature.png')),
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
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            Controller().Prescription(widget.uid,
                                prescriptionController.text, dateCtl.text);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Successfuly Insert'),
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
                      )),
                  Container(
                    margin: const EdgeInsets.all(1.5),
                  ),
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
