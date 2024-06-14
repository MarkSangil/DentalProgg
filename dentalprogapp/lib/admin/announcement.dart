// import 'package:dentalprogapplication/authentication/login.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/welcome.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const announcementPage());
}

// ignore: camel_case_types
class announcementPage extends StatefulWidget {
  const announcementPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _announcementPage createState() => _announcementPage();
}

// ignore: camel_case_types
class _announcementPage extends State<announcementPage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
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
                    margin: const EdgeInsets.only(top: 100),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 130,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const SizedBox(
                            child: Image(
                              width: 130,
                              image: AssetImage('asset/announcement.png'),
                            ),
                          ),
                        ),

                        const SizedBox(
                            width: 10), // Add some space between the containers

                        const Column(
                          children: [
                            Text(
                              'Announcement',
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
                    margin: const EdgeInsets.all(10),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(122, 210, 31, 61),
                        borderRadius: BorderRadius.circular(20)),
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
                                FontAwesomeIcons.plusCircle,
                                size: 50,
                                color: Colors.white,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  child: const Text(
                                    'Add Announcements.',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                // Container(
                                //   alignment: Alignment.bottomLeft,
                                //   child: const Text(
                                //     'Title',
                                //     style: TextStyle(
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.w600,
                                //         color: Colors.white),
                                //   ),
                                // ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                      height: 60,
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            86, 255, 52, 52),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextField(
                                        controller: title,
                                        style: const TextStyle(fontSize: 22),
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                      )),
                                )
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                // Container(
                                //   alignment: Alignment.bottomLeft,
                                //   child: const Text(
                                //     'Description',
                                //     style: TextStyle(
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.w600,
                                //         color: Colors.white),
                                //   ),
                                // ),
                                Container(
                                    height: 150,
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
                                          null,
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
                                        String timestamp = DateTime.now().toString();
                                        Controller().Announcement(title.text, description.text, timestamp);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Create Announcement Successful'),
                                              content: const Text(
                                                  'Created! Announcement was successful.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                const welcomePage())));
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
