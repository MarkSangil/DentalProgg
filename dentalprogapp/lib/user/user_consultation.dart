import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:dentalprogapplication/user/user_emergency.dart';
import 'package:dentalprogapplication/user/user_top.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const user_consultationPage());
}

// ignore: camel_case_types
class user_consultationPage extends StatefulWidget {
  const user_consultationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _user_consultationPage createState() => _user_consultationPage();
}

// ignore: camel_case_types
class _user_consultationPage extends State<user_consultationPage> {
  final TextEditingController description = TextEditingController();

  String name = "";
  String uid = "";

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
              uid = userData['uid'] ?? '';
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
                  const user_topPage(),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Container(
                          width: 250,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(86, 255, 52, 52),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'CONSULTATION',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
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
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(86, 255, 52, 52),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                    height: 300,
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(86, 255, 52, 52),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextField(
                                      controller: description,
                                      style: const TextStyle(fontSize: 22),
                                      keyboardType: TextInputType.multiline,
                                      maxLines:
                                          null, // Set to null for unlimited lines, or a specific number
                                      minLines: 3,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                    )),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: TextButton(
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Controller().Consultation(
                                            uid, name, description.text);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Create Consultation Successful'),
                                              content: const Text(
                                                  'Created! Consultation was successful.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                const user_emergencyPage())));
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    )),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
