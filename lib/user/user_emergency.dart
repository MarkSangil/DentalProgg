// import 'package:dentalprogapplication/authentication/login.dart';
import 'package:dentalprogapplication/user/user_back.dart';
import 'package:dentalprogapplication/user/user_prescriptionlist.dart';
import 'package:dentalprogapplication/user/user_top.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const user_emergencyPage());
}

// ignore: camel_case_types
class user_emergencyPage extends StatefulWidget {
  const user_emergencyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _user_emergencyPage createState() => _user_emergencyPage();
}

// ignore: camel_case_types
class _user_emergencyPage extends State<user_emergencyPage> {
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
                  const user_backPage(),
                  const user_topPage(),
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
                          width: 180,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                ' EMERGENCY',
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
                    margin: const EdgeInsets.all(20),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dentist Prescription',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const user_prescriptionlistPage())),
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
