// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const transactionPage());
}

// ignore: camel_case_types
class transactionPage extends StatefulWidget {
  const transactionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _transactionPage createState() => _transactionPage();
}

// ignore: camel_case_types
class _transactionPage extends State<transactionPage> {
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
                    margin: const EdgeInsets.only(top: 150),
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
                              image: AssetImage('asset/transactions.png'),
                            ),
                          ),
                        ),

                        const SizedBox(
                            width: 10), // Add some space between the containers

                        const Column(
                          children: [
                            Text(
                              'Transaction',
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
                    margin: const EdgeInsets.all(50),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('transactions')
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
                                          padding: const EdgeInsets.all(5),
                                          color: const Color.fromARGB(
                                              255, 83, 83, 83),
                                          child: const Column(
                                            children: [
                                              Text(
                                                'PATIENT NAME',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          padding: const EdgeInsets.all(5),
                                          color: const Color.fromARGB(
                                              255, 83, 83, 83),
                                          child: const Column(
                                            children: [
                                              Text(
                                                'DENTAL SERVICE',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          color: const Color.fromARGB(
                                              255, 83, 83, 83),
                                          child: const Column(
                                            children: [
                                              Text(
                                                'PAYMENT METHOD',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (var doc in data)
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 3),
                                            padding: const EdgeInsets.all(5),
                                            color: Colors.black,
                                            child: Column(
                                              children: [
                                                Text(
                                                  doc['name'],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 3, right: 3, top: 3),
                                            padding: const EdgeInsets.all(5),
                                            color: Colors.black,
                                            child: Column(
                                              children: [
                                                Text(
                                                  doc['selectedDentalServices'],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 3),
                                            padding: const EdgeInsets.all(5),
                                            color: Colors.black,
                                            child: Column(
                                              children: [
                                                Text(
                                                  doc['paymentmethod'],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                )
                                              ],
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
