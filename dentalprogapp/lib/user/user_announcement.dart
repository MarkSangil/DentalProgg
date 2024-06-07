// import 'package:dentalprogapplication/authentication/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/user/user_back.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const user_announcementPage());
}

// ignore: camel_case_types
class user_announcementPage extends StatefulWidget {
  const user_announcementPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _user_announcementPage createState() => _user_announcementPage();
}

// ignore: camel_case_types
class _user_announcementPage extends State<user_announcementPage> {
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
                          width: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1.3, // Maintain aspect ratio
                                child: Image(
                                  image: AssetImage('asset/announcement.png'),
                                ),
                              ),
                              Text(
                                'Annoucement',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
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
                    margin: const EdgeInsets.all(10),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const FaIcon(
                                // ignore: deprecated_member_use
                                FontAwesomeIcons.listCheck,
                                size: 40,
                                color: Colors.white,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    'List Of Announcement',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: MediaQuery.of(context).size.height / 3,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(111, 210, 31, 61),
                              borderRadius: BorderRadius.circular(20)),
                          child: SingleChildScrollView(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('announcement')
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
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        86, 255, 52, 52),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Column(
                                                  children: [
                                                    // Container(
                                                    //   alignment:
                                                    //       Alignment.bottomLeft,
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Text(
                                                    //         ' ${data[index]['title']}',
                                                    //         style:
                                                    //             const TextStyle(
                                                    //           color:
                                                    //               Colors.white,
                                                    //           fontWeight:
                                                    //               FontWeight
                                                    //                   .w700,
                                                    //           fontSize: 20,
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        data[index][
                                                                'description'] ??
                                                            '',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
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
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
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
