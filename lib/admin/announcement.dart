import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class announcementPage extends StatefulWidget {
  const announcementPage({super.key});

  @override
  _announcementPageState createState() => _announcementPageState();
}

class _announcementPageState extends State<announcementPage> {
  final TextEditingController titleController = TextEditingController(); // Controller for title
  final TextEditingController descriptionController = TextEditingController(); // Controller for description
  PlatformFile? pickedFile;

  @override
  void dispose() {
    // Dispose controllers when not needed to free resources
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text("Create Announcement"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // This will navigate back to the previous screen
            },
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'asset/bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 10),
              child: ListView(
                children: [
                  const SizedBox(height: 50),
                  Container(
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
                              width: 80,
                              image: AssetImage('asset/announcement.png'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          children: [
                            Text(
                              'Announcement',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(122, 210, 31, 61),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.plusCircle,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Add Announcements',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              // Title input field
                              Container(
                                height: 60,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(86, 255, 52, 52),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: titleController, // Reference the controller
                                  style: const TextStyle(fontSize: 22),
                                  decoration: const InputDecoration(
                                    labelText: 'Title:',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Description input field
                              Container(
                                height: 150,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(86, 255, 52, 52),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: descriptionController, // Reference the controller
                                  style: const TextStyle(fontSize: 22),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 3,
                                  decoration: const InputDecoration(
                                    labelText: 'Write a message',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    setState(() {
                                      pickedFile = result.files.first; // Store selected file
                                    });
                                  }
                                },
                                child: const Text(
                                  'Attach File',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Save button
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  child: const Text(
                                    'SAVE',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    DateTime now = DateTime.now();
                                    String formattedDateAndTime =
                                    DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

                                    String? fileUrl;
                                    if (pickedFile != null) {
                                      fileUrl = await uploadFileToFirebase(pickedFile!);
                                    }

                                    await saveAnnouncement(
                                      titleController.text,
                                      descriptionController.text,
                                      formattedDateAndTime,
                                      fileUrl,
                                    );

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
                                                Navigator.pop(context); // Close the dialog
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
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

  // Function to upload file to Firebase
  Future<String> uploadFileToFirebase(PlatformFile file) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String fileName = file.name;
    final File fileToUpload = File(file.path!);

    try {
      TaskSnapshot snapshot = await storage
          .ref('announcements/$fileName')
          .putFile(fileToUpload);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading file: $e");
      return '';
    }
  }

  // Function to save the announcement to Firestore
  Future<void> saveAnnouncement(String title, String description, String dateandtime, String? fileUrl) async {
    FirebaseFirestore.instance.collection('announcement').add({
      'title': title,
      'description': description,
      'dateandtime': dateandtime, // Change dateTime to dateandtime
      'fileUrl': fileUrl,
    });
  }
}

