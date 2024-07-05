import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/payment.dart';
import 'package:dentalprogapplication/admin/schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const appointmentPage());
}

class appointmentPage extends StatefulWidget {
  const appointmentPage({super.key});

  @override
  _appointmentPage createState() => _appointmentPage();
}

class _appointmentPage extends State<appointmentPage> {
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
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const backPage(),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const SizedBox(
                              child: Image(
                                width: 130,
                                image: AssetImage('asset/appointment.png'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            children: [
                              Text(
                                'Appointments',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.black),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SchedulePage()),
                          );
                        },
                        child: const Text(
                          'ADD SCHEDULE',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(86, 255, 52, 52),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.listCheck,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  child: const Text(
                                    'List of Appointments',
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: SingleChildScrollView(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('appointment').snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final data = snapshot.data?.docs ?? [];
                                    return Center(
                                      child: Table(
                                        border: TableBorder.all(color: Colors.white),
                                        children: [
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color: const Color(0xddD21f3C),
                                            ),
                                            children: [
                                              _buildTableHeader('NAME'),
                                              _buildTableHeader('DATE'),
                                              _buildTableHeader('TIME'),
                                              _buildTableHeader('ACTION'),
                                            ],
                                          ),
                                          for (var doc in data)
                                            TableRow(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.1),
                                              ),
                                              children: [
                                                _buildTableCell(doc['name'] ?? ''),
                                                _buildTableCell(doc['date'] ?? ''),
                                                _buildTableCell(doc['time'] ?? ''),
                                                _buildTableCellAction(doc['status'], doc),
                                              ],
                                            ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const Text('NO DATA');
                                  }
                                },
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTableCell(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTableCellAction(String status, DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: status == 'Pending'
            ? TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => paymentPage(
                  appointment_id: doc.id,
                  name: doc['name'],
                  user_id: doc['user_id'],
                ),
              ),
            );
          },
          child: const Text(
            'Payment',
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ),
        )
            : const Text(
          'Completed',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}