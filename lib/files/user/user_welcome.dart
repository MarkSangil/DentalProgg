import 'package:dentalprogapplication/firebaseDBModel.dart';
import 'package:dentalprogapplication/logout.dart';
import 'package:dentalprogapplication/user/user_announcement.dart';
import 'package:dentalprogapplication/user/user_appointment.dart';
import 'package:dentalprogapplication/user/user_emergency.dart';
import 'package:dentalprogapplication/user/user_profile.dart';
import 'package:dentalprogapplication/user/user_top.dart';
import 'package:dentalprogapplication/user/user_viewmessage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const user_welcomePage());
}

// ignore: camel_case_types
class user_welcomePage extends StatefulWidget {
  const user_welcomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _user_welcomePage createState() => _user_welcomePage();
}

// ignore: camel_case_types
class _user_welcomePage extends State<user_welcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
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
                              child: Column(
                                children: [
                                  AspectRatio(
                                      aspectRatio: 1.3, // Maintain aspect ratio
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: const FaIcon(
                                          // ignore: deprecated_member_use
                                          FontAwesomeIcons.solidUser,
                                          size: 100,
                                          color: Colors.white,
                                        ),
                                      )),
                                  const Text(
                                    'Profile',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const user_profilePage())),
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
                                    'Annoucement',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const user_announcementPage())),
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
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const user_appointmentPage())),
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
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => user_viewmessagePage(
                                            data: firebaseDBModel(
                                                uid:
                                                    '0RB7FgoLBoctIJH49Uova6zIhQD3')))),
                                  )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
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
                                  FaIcon(
                                    // ignore: deprecated_member_use
                                    FontAwesomeIcons.phone,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    ' EMERGENCY',
                                    style: TextStyle(
                                      fontSize: 30,
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
                                        const user_emergencyPage())),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  GestureDetector(
                    child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 20),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 191, 191, 191),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'Log out',
                            style: TextStyle(
                                color: Colors.white,
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
