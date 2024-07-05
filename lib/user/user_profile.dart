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

class user_profilePage extends StatefulWidget {
  const user_profilePage({super.key});

  @override
  _user_profilePage createState() => _user_profilePage();
}

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
  final TextEditingController _ec_nameController = TextEditingController();
  final TextEditingController _ec_contact_noController = TextEditingController();
  final TextEditingController _relationship_to_patientController = TextEditingController();

  String images = "";
  XFile? image;
  String downloadURL = "";

  @override
  void initState() {
    super.initState();
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
          var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
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
            _relationship_to_patientController.text = userData['relationship_to_patient'] ?? '';
            images = userData['image'] ?? '';
          });
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> showImage(ImageSource source) async {
    final img = await ImagePicker().pickImage(source: source);
    setState(() {
      image = img;
    });
    if (img != null) {
      await uploadFirebase(File(img.path));
    }
  }

  Future<void> uploadFirebase(File imageFile) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });
        return const AlertDialog(
          title: Text('Waiting...'),
          content: Text("Waiting to Upload Image to Firebase"),
        );
      },
    );

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toIso8601String()}.png');
      final uploadTask = storageRef.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        String downloadURLTemp = await storageRef.getDownloadURL();
        setState(() {
          images = downloadURLTemp;
          downloadURL = downloadURLTemp; // Update downloadURL here
        });
        print("Image uploaded successfully, URL: $downloadURL");
        await updateUserProfileImage(downloadURL);
      });
    } catch (e) {
      print("Error during upload: $e");
    }
  }

  Future<void> updateUserProfileImage(String imageUrl) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'image': imageUrl,
        });
      }
    } catch (e) {
      print("Error updating Firestore: $e");
    }
  }

  Future<void> showSuccessDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text('Success'),
            ],
          ),
          content: const Text('Successfully updated profile'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
            Image.asset(
              'asset/bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const user_backPage(),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20, left: 5),
                    child: const Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.circleUser,
                          size: 40,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'USER',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xddD21f3C),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'NAME',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.person),
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
                          showImage(ImageSource.gallery).then((value) {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              ClipOval(
                                child: image != null
                                    ? Image.file(
                                  File(image!.path),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                                    : images.isNotEmpty
                                    ? Image.network(
                                  images,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                                    : const FaIcon(
                                  FontAwesomeIcons.circleUser,
                                  size: 70,
                                ),
                              ),
                              const Text(
                                'Profile',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildProfileRow(
                    title: 'AGE',
                    controller: _ageController,
                    icon: Icons.cake,
                  ),
                  _buildProfileRow(
                    title: 'CONTACT',
                    controller: _contactController,
                    icon: Icons.phone,
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const messagePage())),
                  ),
                  _buildProfileRow(
                    title: 'GENDER',
                    controller: _genderController,
                    icon: Icons.wc,
                  ),
                  _buildProfileRow(
                    title: 'EMAIL ADDRESS',
                    controller: _emailController,
                    icon: Icons.email,
                  ),
                  _buildProfileRow(
                    title: 'BIRTHDAY',
                    controller: _birthdayController,
                    icon: Icons.calendar_today,
                  ),
                  _buildProfileRow(
                    title: 'ADDRESS',
                    controller: _addressController,
                    icon: Icons.home,
                  ),
                  _buildProfileRow(
                    title: 'EC NAME',
                    controller: _ec_nameController,
                    icon: Icons.person,
                  ),
                  _buildProfileRow(
                    title: 'EC CONTACT NO',
                    controller: _ec_contact_noController,
                    icon: Icons.phone,
                  ),
                  _buildProfileRow(
                    title: 'RELATIONSHIP TO PATIENT',
                    controller: _relationship_to_patientController,
                    icon: Icons.group,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // Make sure downloadURL is up-to-date before saving
                        if (image != null && downloadURL.isNotEmpty) {
                          await updateUserProfileImage(downloadURL);
                        }
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
                            downloadURL); // Pass the updated downloadURL
                        await showSuccessDialog();
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow({
    required String title,
    required TextEditingController controller,
    IconData? icon,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xddD21f3C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(icon),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
