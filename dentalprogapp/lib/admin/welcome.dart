import 'package:dentalprogapplication/admin/announcement.dart';
import 'package:dentalprogapplication/admin/appointment.dart';
import 'package:dentalprogapplication/admin/dashboard.dart';
import 'package:dentalprogapplication/admin/message.dart';
import 'package:dentalprogapplication/admin/records.dart';
import 'package:dentalprogapplication/admin/top.dart';
import 'package:dentalprogapplication/admin/transaction.dart';
import 'package:dentalprogapplication/logout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const welcomePage());
}

// ignore: camel_case_types
class welcomePage extends StatefulWidget {
  const welcomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _welcomePage createState() => _welcomePage();
}

// ignore: camel_case_types
class _welcomePage extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
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
              child: ListView(
                children: [
                  const topPage(),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.3, // Maintain aspect ratio
                                    child: Image(
                                      image: AssetImage('asset/dashboard.png'),
                                    ),
                                  ),
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const dashboardPage()))),
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Add some space between the containers
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.3, // Maintain aspect ratio
                                    child: Image(
                                      image:
                                          AssetImage('asset/transactions.png'),
                                    ),
                                  ),
                                  Text(
                                    'Transaction',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const transactionPage()))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.3, // Maintain aspect ratio
                                    child: Image(
                                      image: AssetImage('asset/records.png'),
                                    ),
                                  ),
                                  Text(
                                    'Record',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const recordsPage())),
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Add some space between the containers
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.3, // Maintain aspect ratio
                                    child: Image(
                                      image:
                                          AssetImage('asset/announcement.png'),
                                    ),
                                  ),
                                  Text(
                                    'Announcement',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
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
                                        const announcementPage())),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.3, // Maintain aspect ratio
                                    child: Image(
                                      image:
                                          AssetImage('asset/appointment.png'),
                                    ),
                                  ),
                                  Text(
                                    'Appointment',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
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
                                        const appointmentPage())),
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Add some space between the containers
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.3, // Maintain aspect ratio
                                    child: Image(
                                      image: AssetImage('asset/message.png'),
                                    ),
                                  ),
                                  Text(
                                    'Message',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const messagePage())),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  GestureDetector(
                    child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 130, 130, 130),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'Log out',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const logoutPage()),
                      );
                    },
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
