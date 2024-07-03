import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementHelper {
  static Future<Set<String>> loadClickedAnnouncements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList('clickedAnnouncements') ?? []).toSet();
  }

  static Future<void> saveClickedAnnouncements(Set<String> clickedAnnouncements) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('clickedAnnouncements', clickedAnnouncements.toList());
  }

  static Future<bool> checkUnreadAnnouncements(Set<String> clickedAnnouncements) async {
    final snapshot = await FirebaseFirestore.instance.collection('announcement').get();
    final data = snapshot.docs;
    return data.any((doc) => !clickedAnnouncements.contains(doc.id));
  }
}

class user_announcementPage extends StatefulWidget {
  final Function(String) markAsRead;
  final Function() onAnnouncementRead; // New callback

  const user_announcementPage({
    Key? key,
    required this.markAsRead,
    required this.onAnnouncementRead, // Initialize callback
  }) : super(key: key);

  @override
  _user_announcementPageState createState() => _user_announcementPageState();
}

class _user_announcementPageState extends State<user_announcementPage> {
  Set<String> clickedAnnouncements = Set<String>();
  bool hasUnreadAnnouncements = false;

  @override
  void initState() {
    super.initState();
    _loadClickedAnnouncements();
  }

  Future<void> _loadClickedAnnouncements() async {
    clickedAnnouncements = await AnnouncementHelper.loadClickedAnnouncements();
    _checkUnreadAnnouncements();
  }

  Future<void> _checkUnreadAnnouncements() async {
    bool unread = await AnnouncementHelper.checkUnreadAnnouncements(clickedAnnouncements);
    setState(() {
      hasUnreadAnnouncements = unread;
    });
  }

  void _showAnnouncementDialog(BuildContext context, String id, String title, String description) {
    setState(() {
      clickedAnnouncements.add(id);
      AnnouncementHelper.saveClickedAnnouncements(clickedAnnouncements);
    });

    widget.markAsRead(id);
    widget.onAnnouncementRead(); // Notify parent to refresh state

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  padding: const EdgeInsets.only(bottom: 10, left: 5),
                  child: const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.userCircle,
                        size: 40,
                        color: Colors.black,
                      ),
                      Text(
                        ' USER',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 150, // Adjust the width as needed
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xddD21f3C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Center align content vertically
                        children: [
                          Container(
                            height: 70, // Adjust height for the AspectRatio container
                            child: AspectRatio(
                              aspectRatio: 1.3,
                              child: Image(
                                image: AssetImage('asset/announcement.png'),
                                fit: BoxFit.contain, // Ensure the image fits within the AspectRatio
                              ),
                            ),
                          ),
                          SizedBox(height: 5), // Add some spacing between image and text
                          Text(
                            'Announcement',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16, // Adjust font size as needed
                              fontWeight: FontWeight.bold, // Adjust font weight as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: MediaQuery.of(context).size.height / 3,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(111, 210, 31, 61),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('announcement')
                              .orderBy('dateandtime', descending: true)
                              .snapshots(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data?.docs ?? [];
                              return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  String id = data[index].id;
                                  bool isClicked = clickedAnnouncements.contains(id);
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isClicked ? Colors.grey : Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        data[index]['title'] ?? '',
                                        style: TextStyle(
                                          color: isClicked ? Colors.grey : Colors.white,
                                          fontWeight: isClicked ? FontWeight.normal : FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        _showAnnouncementDialog(
                                          context,
                                          id,
                                          data[index]['title'] ?? '',
                                          data[index]['description'] ?? '',
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Text('NO DATA');
                            }
                          }),
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
          ),
        ],
      ),
    );
  }
}
