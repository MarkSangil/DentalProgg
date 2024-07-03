import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/welcome.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
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
                                onTap: () async {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    PlatformFile file = result.files.first;
                                    print(file.name);
                                    print(file.bytes);
                                    print(file.size);
                                    print(file.extension);
                                    print(file.path);
                                  } else {
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
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    DateTime now = DateTime.now();
                                    String formattedDateTime =
                                    DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                                    Controller().Announcement(
                                      title.text,
                                      description.text,
                                      formattedDateTime,
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                      const welcomePage())),
                                                );
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
}
