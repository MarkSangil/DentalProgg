import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/user/user_back.dart';
import 'package:dentalprogapplication/user/user_schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const user_appointmentPage());
}

class user_appointmentPage extends StatefulWidget {
  const user_appointmentPage({super.key});

  @override
  _user_appointmentPage createState() => _user_appointmentPage();
}

class _user_appointmentPage extends State<user_appointmentPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
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
                  const user_backPage(),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20, left: 5),
                    child: const Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.userCircle,
                          size: 40,
                          color: Colors.black,
                        ),
                        Text(
                          ' USER',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1.3,
                                child: Image(
                                  image: AssetImage('asset/appointment.png'),
                                ),
                              ),
                              Text(
                                'Appointment',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) =>
                              const UserSchedulePage()),
                            ),
                          );
                        },
                        child: const Text(
                          'SELECT SCHEDULE',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(100, 210, 31, 61),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.listCheck,
                                size: 40,
                                color: Colors.white,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(5),
                                child: const Text(
                                  'List Of Appointments',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: SingleChildScrollView(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('appointment')
                                  .snapshots(),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data?.docs ?? [];
                                  return Center(
                                    child: Table(
                                      border: TableBorder.all(
                                          color: Colors.white),
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                            color: const Color(0xddD21f3C),
                                          ),
                                          children: [
                                            _buildTableHeader('NAME'),
                                            _buildTableHeader('DATE'),
                                            _buildTableHeader('TIME'),
                                          ],
                                        ),
                                        for (var doc in data)
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                  0.1),
                                            ),
                                            children: [
                                              _buildTableCell(
                                                  doc['name'] ?? ''),
                                              _buildTableCell(
                                                  doc['date'] ?? ''),
                                              _buildTableCell(
                                                  doc['time'] ?? ''),
                                            ],
                                          ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
}
