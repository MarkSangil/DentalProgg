import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/firebaseDBModel.dart';
import 'package:dentalprogapplication/user/user_viewmessage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const user_messagePage());
}

// ignore: camel_case_types
class user_messagePage extends StatefulWidget {
  const user_messagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _user_messagePage createState() => _user_messagePage();
}

// ignore: camel_case_types
class _user_messagePage extends State<user_messagePage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 100),
                            child: const Row(
                              children: [],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            child: Image.asset(
                              'asset/logo.png',
                            ),
                          ),
                        )
                      ],
                    ),
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
                                  FontAwesomeIcons.envelope,
                                  size: 70,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                              width:
                                  10), // Add some space between the containers

                          const Column(
                            children: [
                              Text(
                                'MESSAGE',
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
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(86, 255, 52, 52),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(86, 255, 52, 52),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const FaIcon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.message,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                ),
                                Expanded(
                                  child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              84, 165, 20, 20),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                ),
                                const FaIcon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.search,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('type', isEqualTo: 'customer')
                                .snapshots(),
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data?.docs ?? [];
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Table(
                                    children: [
                                      for (var doc in data)
                                        TableRow(
                                          children: [
                                            GestureDetector(
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  color: const Color.fromARGB(
                                                      84, 165, 20, 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      86,
                                                                      255,
                                                                      52,
                                                                      52),
                                                            ),
                                                            child: const FaIcon(
                                                              // ignore: deprecated_member_use
                                                              FontAwesomeIcons
                                                                  // ignore: deprecated_member_use
                                                                  .userCircle,
                                                              size: 30,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(15),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        86,
                                                                        255,
                                                                        52,
                                                                        52),
                                                              ),
                                                              child: Text(
                                                                doc['name'] ??
                                                                    '',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              user_viewmessagePage(
                                                                  data: firebaseDBModel(
                                                                      uid: doc[
                                                                          'uid'])))),
                                                    ))
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
