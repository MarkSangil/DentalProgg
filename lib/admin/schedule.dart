import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const schedulePage());
}

// ignore: camel_case_types
class schedulePage extends StatefulWidget {
  const schedulePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _schedulePage createState() => _schedulePage();
}

// ignore: camel_case_types
class _schedulePage extends State<schedulePage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  late TimeOfDay _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _selectedTime.format(context);
      });
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
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(86, 255, 52, 52),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Column(
                            children: [
                              FaIcon(
                                // ignore: deprecated_member_use
                                FontAwesomeIcons.calendarDay,
                                size: 70,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                            width: 10), // Add some space between the containers

                        const Column(
                          children: [
                            Text(
                              'SCHEDULE',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Create Schedule'),
                                  actions: [
                                    Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            86, 255, 52, 52),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: DateTimePicker(
                                        type: DateTimePickerType
                                            .date, // Use DateTimePickerType.date to remove time picker
                                        dateMask: 'yyyy-MM-dd',
                                        controller: dateController,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                        icon: const Icon(Icons.event),
                                        dateLabelText: 'Date',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (val) {
                                          // Update the controller when the value changes
                                          dateController.text = val;
                                        },
                                        validator: (val) {
                                          return null;
                                        },
                                        // ignore: avoid_print
                                        onSaved: (val) => print(val),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                    ),
                                    Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            86, 255, 52, 52),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextField(
                                        controller: _timeController,
                                        readOnly: true,
                                        onTap: () {
                                          _selectTime(context);
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Select Time',
                                          suffixIcon: Icon(Icons.access_time),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Close'),
                                        ),
                                        TextButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.redAccent)),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('schedule')
                                                .doc()
                                                .set({
                                              'date': dateController.text,
                                              'time':
                                                  _selectedTime.format(context),
                                            }).then((value) =>
                                                    Navigator.pop(context));
                                            dateController.clear();
                                            _timeController.clear();
                                          },
                                          child: const Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'ADD SCHEDULE',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ))),
                  Container(
                    margin: const EdgeInsets.all(10),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(86, 255, 52, 52),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(86, 255, 52, 52),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const FaIcon(
                                // ignore: deprecated_member_use
                                FontAwesomeIcons.listCheck,
                                size: 50,
                                color: Colors.white,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  child: const Text(
                                    'LIST OF SCHEDULE',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: SingleChildScrollView(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('schedule')
                                  .snapshots(),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data?.docs ?? [];

                                  return Center(
                                    child: Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: const Text(
                                                    'Date',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  )),
                                            ),
                                            TableCell(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: const Text(
                                                    'Time',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        for (var doc in data)
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Text(
                                                      doc['date'] ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ),
                                              TableCell(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Text(
                                                      doc['time'] ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const Text('NO DATA');
                                }
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
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
