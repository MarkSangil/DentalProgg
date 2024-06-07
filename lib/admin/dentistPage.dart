// ignore_for_file: file_names

import 'package:dentalprogapplication/admin/back.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const dentistPage());
}

// ignore: camel_case_types
class dentistPage extends StatefulWidget {
  const dentistPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _dentistPage createState() => _dentistPage();
}

// ignore: camel_case_types
class _dentistPage extends State<dentistPage> {
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
                    margin: const EdgeInsets.only(top: 50),
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
                              image: AssetImage('asset/dashboard.png'),
                            ),
                          ),
                        ),

                        const SizedBox(
                            width: 10), // Add some space between the containers

                        const Column(
                          children: [
                            Text(
                              'Dashboard',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.grey.shade400,
                          child: const Column(
                            children: [
                              Text(
                                'DENTIST',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 3), // Add some space between the containers
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.grey.shade400,
                          child: const Column(
                            children: [
                              Text(
                                'CONTACT #',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(1.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 14),
                          color: Colors.grey.shade600,
                          child: const Column(
                            children: [
                              Text(
                                'DRA. M.L. KALALO -  PATULO',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 3), // Add some space between the containers
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.grey.shade600,
                          child: const Column(
                            children: [
                              Text(
                                '0917 586 8226',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                '0909 138 2293',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(1.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 14),
                          color: Colors.grey.shade600,
                          child: const Column(
                            children: [
                              Text(
                                'DRA. B. DE CASTRO - SANTOS',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 3), // Add some space between the containers
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.grey.shade600,
                          child: const Column(
                            children: [
                              Text(
                                '0945 167  6286',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                '0909 138  2293',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(1.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 14),
                          color: Colors.grey.shade600,
                          child: const Column(
                            children: [
                              Text(
                                'DRA. J.JARAMILLO  -TOLENTINO',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 3), // Add some space between the containers
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.grey.shade600,
                          child: const Column(
                            children: [
                              Text(
                                '0921 501 4594',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                '0909 138 2293',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
            )
          ],
        ),
      ),
    );
  }
}
