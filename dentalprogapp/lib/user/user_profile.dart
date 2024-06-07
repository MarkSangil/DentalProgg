import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/message.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:dentalprogapplication/user/user_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const user_profilePage());
}

// ignore: camel_case_types
class user_profilePage extends StatefulWidget {
  const user_profilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _user_profilePage createState() => _user_profilePage();
}

// ignore: camel_case_types
class _user_profilePage extends State<user_profilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _ec_nameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _ec_contact_noController =
      TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _relationship_to_patientController =
      TextEditingController();

  String images = "";

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
              _idController.text = querySnapshot.docs.first.id;
              _uidController.text = userData['uid'] ?? '';
              _nameController.text = userData['name'] ?? '';
              _emailController.text = userData['email'] ?? '';
              _ageController.text = userData['age'] ?? '';
              _contactController.text = userData['contact'] ?? '';
              _genderController.text = userData['gender'] ?? '';
              _birthdayController.text = userData['birthday'] ?? '';
              _addressController.text = userData['address'] ?? '';
              _typeController.text = userData['type'] ?? '';
              _ec_nameController.text = userData['ec_name'] ?? '';
              _ec_contact_noController.text = userData['ec_contact_no'] ?? '';
              _relationship_to_patientController.text =
                  userData['relationship_to_patient'] ?? '';
              images = userData['image'] ?? '';

              // Update other controllers for other fields accordingly
            });
          } else {}
        } else {}
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  XFile? image;

  String downloadURL = "";

  Future showImage(ImageSource source) async {
    final img = await ImagePicker().pickImage(source: source);
    setState(() {
      image = img;
    });
  }

  uploadFirebase() async {
    var path = 'images';
    var file = File(image!.path);
    final ref = FirebaseStorage.instance.ref().child(path).child(image!.name);
    await ref.putFile(file);
    downloadURL = await ref.getDownloadURL();
  }

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
                  Visibility(
                    visible: false,
                    child: TextField(
                      controller: _typeController,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'NAME',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          showImage(ImageSource.gallery).then((value) {
                            uploadFirebase();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              images == ''
                                  ? const FaIcon(
                                      // ignore: deprecated_member_use
                                      FontAwesomeIcons.userCircle,
                                      size: 70,
                                    )
                                  : Image.network(
                                      images,
                                      width: 70,
                                      height: 70,
                                    ),
                              const Text(
                                'Profile',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'AGE',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _ageController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Add some space between the containers
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: const Text(
                                    'CONTACT',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xddD21f3C),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextField(
                                    controller: _contactController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'GENDER',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _genderController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Add some space between the containers
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'EMAIL ADDRESS',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'BIRTHDAY',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _birthdayController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Add some space between the containers
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'ADDRESS',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _addressController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            ' EC NAME',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: _ec_nameController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            ' EC CONTACT NO',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: _ec_contact_noController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'RELATIONSHIP TO PATIENT',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _relationship_to_patientController,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        child: TextButton(
                          onPressed: () {
                            Controller().Profile(
                                _uidController.text,
                                _nameController.text,
                                _emailController.text,
                                _ageController.text,
                                _contactController.text,
                                _genderController.text,
                                _birthdayController.text,
                                _addressController.text,
                                _ec_nameController.text,
                                _ec_contact_noController.text,
                                _relationship_to_patientController.text,
                                downloadURL);
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )),
                  Container(margin: const EdgeInsets.only(bottom: 20))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
