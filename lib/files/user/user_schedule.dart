import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/user/user_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const user_schedulePage());
}

// ignore: camel_case_types
class user_schedulePage extends StatefulWidget {
  const user_schedulePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _user_schedulePage createState() => _user_schedulePage();
}

// ignore: camel_case_types
class _user_schedulePage extends State<user_schedulePage> {
  final user = FirebaseAuth.instance.currentUser;

  String name = "";

  @override
  void initState() {
    super.initState();
    // Fetch data based on the provided UID when the widget initializes
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>?;

          if (userData != null) {
            setState(() {
              name = userData['name'] ?? '';
            });
          } else {}
        } else {}
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const user_backPage(),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20, left: 5),
                      child: const Row(
                        children: [
                          FaIcon(
                            // ignore: deprecated_member_use
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
                                  aspectRatio: 1.3, // Maintain aspect ratio
                                  child: Image(
                                    image: AssetImage('asset/appointment.png'),
                                  ),
                                ),
                                Text(
                                  'Schedule',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),

                          const SizedBox(
                              width:
                                  10), // Add some space between the containers
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(105, 255, 52, 52),
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
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      child: Text(
                                                        doc['date'] ?? '',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ),
                                                TableCell(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      child: Text(
                                                        doc['time'] ?? '',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ),
                                                TableCell(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'You Want Set This Schedule?'),
                                                              actions: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'Close'),
                                                                    ),
                                                                    TextButton(
                                                                      style: const ButtonStyle(
                                                                          backgroundColor:
                                                                              WidgetStatePropertyAll(Colors.redAccent)),
                                                                      onPressed:
                                                                          () async {
                                                                        QuerySnapshot querySnapshot = await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'appointment')
                                                                            .where('schedule_uid',
                                                                                isEqualTo: doc.id)
                                                                            .get();

                                                                        if (querySnapshot
                                                                            .docs
                                                                            .isNotEmpty) {
                                                                          // ignore: use_build_context_synchronously
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Already Exist'),
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
                                                                        } else {
                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection('appointment')
                                                                              .doc()
                                                                              .set({
                                                                            'schedule_uid':
                                                                                doc.id,
                                                                            'date':
                                                                                doc['date'],
                                                                            'time':
                                                                                doc['time'],
                                                                            'user_id':
                                                                                user!.uid,
                                                                            'name':
                                                                                name,
                                                                            'status':
                                                                                'Pending'
                                                                          }).then((value) {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Successfully Set Schedule'),
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
                                                                          });
                                                                        }
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Save',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const FaIcon(
                                                          FontAwesomeIcons.eye),
                                                    ),
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
}
