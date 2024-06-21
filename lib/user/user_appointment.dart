// import 'package:dentalprogapplication/authentication/login.dart';
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
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
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
                        const SizedBox(
                            width: 10),
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
                        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const UserSchedulePage())));
                            },
                            child: const Text(
                              'SELECT SCHEDULE',
                              style: TextStyle(fontSize: 24, color: Colors.white),
                            ))),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(100, 210, 31, 61),
                        borderRadius: BorderRadius.circular(20)),
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
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: SingleChildScrollView(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('appointment').snapshots(),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data?.docs ?? [];
                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        for (int index = 0; index < data.length; index++)
                                          Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(10),
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(96, 210, 31, 61),
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      alignment: Alignment.bottomLeft,
                                                      child: Row(
                                                        children: [
                                                          // Container(
                                                          //   alignment: Alignment
                                                          //       .center,
                                                          //   width: 30,
                                                          //   height: 30,
                                                          //   decoration:
                                                          //       BoxDecoration(
                                                          //     color:
                                                          //         Colors.white,
                                                          //     borderRadius:
                                                          //         BorderRadius
                                                          //             .circular(
                                                          //                 20),
                                                          //   ),
                                                          //   child: Text(
                                                          //     '${index + 1}', // Display the counter
                                                          //     style:
                                                          //         const TextStyle(
                                                          //       color: Colors
                                                          //           .redAccent,
                                                          //       fontSize: 18,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .w700,
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          Text(
                                                            ' ${data[index]['name']}',
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w700, fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        'Date: ${data[index]['date'] ?? ''} - Time: ${data[index]['time'] ?? ''}',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
