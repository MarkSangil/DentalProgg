import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/download.dart';
import 'package:dentalprogapplication/admin/history.dart';
import 'package:dentalprogapplication/admin/prescription.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class recordsviewPage extends StatefulWidget {
  final String uid;
  final String age;
  final String address;
  final String gender;
  final String contact;
  final String name;
  const recordsviewPage({
    super.key,
    required this.uid,
    required this.age,
    required this.address,
    required this.gender,
    required this.contact,
    required this.name,
  });

  @override
  _recordsviewPage createState() => _recordsviewPage();
}

class _recordsviewPage extends State<recordsviewPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
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
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            width: 10),
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
                  Row(
                    children: [
                      Text(
                        '${widget.name} ',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        child: const FaIcon(
                          FontAwesomeIcons.fileArrowDown,
                          color: Color(0xddD21f3C),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) => DownloadPage(uid: widget.uid))));
                        },
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                widget.age,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 10),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'HISTORY',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: ((context) => historyPage(uid: widget.uid)))),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                widget.gender,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 10),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                widget.contact,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: ((context) => historyPage(uid: widget.uid)))),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                widget.address,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xddD21f3C),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'PRESCRIPTION',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => prescriptionPage(
                                      uid: widget.uid,
                                      age: widget.age,
                                      address: widget.address,
                                      gender: widget.gender,
                                      contact: widget.contact,
                                      name: widget.name)))),
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
