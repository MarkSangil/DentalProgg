import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/user/user_back.dart';
import 'package:dentalprogapplication/user/user_prescription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const user_prescriptionlistPage());
}

// ignore: camel_case_types
class user_prescriptionlistPage extends StatefulWidget {
  const user_prescriptionlistPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _user_prescriptionlistPage createState() => _user_prescriptionlistPage();
}

// ignore: camel_case_types
class _user_prescriptionlistPage extends State<user_prescriptionlistPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
                          width: 305,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'DENTIST PRESCRIPTION',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                            width: 10), // Add some space between the containers
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('prescription')
                            .where('uid', isEqualTo: user!.uid)
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data?.docs ?? [];

                            return Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  for (int index = 0;
                                      index < data.length;
                                      index++)
                                    Column(
                                      children: [
                                        GestureDetector(
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      96, 210, 31, 61),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Text(
                                                            '${index + 1}', // Display the counter
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          ' ${data[index]['date']}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          user_prescriptionPage(
                                                              uid: user.uid,
                                                              date: data[index]
                                                                  ['date'],
                                                              prescription: data[
                                                                      index][
                                                                  'presciption']))),
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
            )
          ],
        ),
      ),
    );
  }
}
