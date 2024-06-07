// import 'package:dentalprogapplication/authentication/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/recordsview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const recordsPage());
}

// ignore: camel_case_types
class recordsPage extends StatefulWidget {
  const recordsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _recordsPage createState() => _recordsPage();
}

// ignore: camel_case_types
class _recordsPage extends State<recordsPage> {
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
                          width: 150,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const SizedBox(
                            child: Image(
                              width: 150,
                              image: AssetImage('asset/records.png'),
                            ),
                          ),
                        ),

                        const SizedBox(
                            width: 10), // Add some space between the containers

                        const Column(
                          children: [
                            Text(
                              'Records',
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
                            .collection('users')
                            .where('type', isEqualTo: 'customer')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data?.docs ?? [];
                            return Center(
                              child: Column(
                                children: [
                                  for (var doc in data)
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: GestureDetector(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 200,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              color: const Color(0xddD21f3C),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Text(
                                            doc['name'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => recordsviewPage(
                                                uid: doc['uid'],
                                                age: doc['age'],
                                                address: doc['address'],
                                                gender: doc['gender'],
                                                contact: doc['contact'],
                                                name: doc[
                                                    'name']), // Assuming DentistPage is a constant widget
                                          ),
                                        ),
                                      ),
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
            )
          ],
        ),
      ),
    );
  }
}
