import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/welcome.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:io';

void main() {
  runApp(const announcementPage());
}

class announcementPage extends StatefulWidget {
  const announcementPage({super.key});

  @override
  _announcementPage createState() => _announcementPage();
}

class _announcementPage extends State<announcementPage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  PlatformFile? pickedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  Future<String> _uploadFile(PlatformFile file) async {
    File uploadFile = File(file.path!);
    String fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    Reference storageRef = FirebaseStorage.instance.ref().child('announcements/$fileName');
    UploadTask uploadTask = storageRef.putFile(uploadFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  void _saveAnnouncement() async {
    if (title.text.isEmpty || description.text.isEmpty) {
      _showAlert('Please enter both title and description.');
      return;
    }

    String fileUrl = '';
    if (pickedFile != null) {
      fileUrl = await _uploadFile(pickedFile!);
    }

    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    FirebaseFirestore.instance.collection('announcement').add({
      'title': title.text,
      'description': description.text,
      'dateandtime': formattedDateTime,
      'fileUrl': fileUrl,
    });

    _showAlert('Announcement created successfully.');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const welcomePage()),
    );
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
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
                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400, color: Colors.black),
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
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.plusCircle,
                                size: 50,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Add Announcements',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
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
                              Container(
                                height: 60,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(86, 255, 52, 52),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: title,
                                  style: const TextStyle(fontSize: 22),
                                  decoration: const InputDecoration(
                                    labelText: 'Title:',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              Container(
                                height: 150,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(86, 255, 52, 52),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: description,
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
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              GestureDetector(
                                onTap: _pickFile,
                                child: const Text(
                                  'Attach File',
                                  style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
                                ),
                              ),
                              if (pickedFile != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('Selected File: ${pickedFile!.name}'),
                                ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  child: const Text(
                                    'SAVE',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                  onPressed: _saveAnnouncement,
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
}
