import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/viewmessage.dart';
import 'package:dentalprogapplication/firebaseDBModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class messagesearchPage extends StatefulWidget {
  final String searchtext;
  const messagesearchPage({super.key, required this.searchtext});

  @override
  // ignore: library_private_types_in_public_api
  _messagesearchPage createState() => _messagesearchPage();
}

// ignore: camel_case_types
class _messagesearchPage extends State<messagesearchPage> {
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
                    const backPage(),
                    Container(
                      margin: const EdgeInsets.only(top: 70),
                      padding: const EdgeInsets.all(5),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Search Result',
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
                      margin: const EdgeInsets.all(20),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(86, 255, 52, 52),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: SingleChildScrollView(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where('type', isEqualTo: 'customer')
                                    .where('name', isEqualTo: widget.searchtext)
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                              84, 165, 20, 20),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
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
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50)),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(50),
                                                                        child: doc['image'] ==
                                                                                ''
                                                                            ? const FaIcon(
                                                                                // ignore: deprecated_member_use
                                                                                FontAwesomeIcons.userCircle,
                                                                                size: 40,
                                                                              )
                                                                            : Image.network(
                                                                                doc['image'],
                                                                                width: 40,
                                                                                height: 40,
                                                                              ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          15),
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
                                                                  viewmessagePage(
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
