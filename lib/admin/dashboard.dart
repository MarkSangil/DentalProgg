import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/dentistPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const dashboardPage());
}

// ignore: camel_case_types
class dashboardPage extends StatefulWidget {
  const dashboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _dashboardPage createState() => _dashboardPage();
}

// ignore: camel_case_types
class _dashboardPage extends State<dashboardPage> {
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Text(
                                'DENTIST',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const dentistPage()))),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                        ),
                        // GestureDetector(
                        //   child: Container(
                        //       alignment: Alignment.center,
                        //       width: 200,
                        //       padding: const EdgeInsets.all(15),
                        //       decoration: BoxDecoration(
                        //           color: const Color(0xddD21f3C),
                        //           borderRadius: BorderRadius.circular(30)),
                        //       child: const Text(
                        //         'PRESCRIPTION',
                        //         style: TextStyle(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.w600,
                        //           color: Colors.white,
                        //         ),
                        //       )),
                        //   // onTap: () => Navigator.push(
                        //   //     context,
                        //   //     MaterialPageRoute(
                        //   //         builder: ((context) =>
                        //   //             const prescriptionPage()))),
                        // ),
                        Container(
                          margin: const EdgeInsets.all(20),
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
