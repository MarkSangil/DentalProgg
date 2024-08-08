import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementHelper {
  static Future<Set<String>> loadClickedAnnouncements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('clickedAnnouncements')?.toSet() ?? {};
  }

  static Future<void> saveClickedAnnouncements(Set<String> clickedAnnouncements) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('clickedAnnouncements', clickedAnnouncements.toList());
  }

  static Future<Set<String>> loadHiddenAnnouncements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList('hiddenAnnouncements') ?? []).toSet();
  }

  static Future<void> saveHiddenAnnouncements(Set<String> hiddenAnnouncements) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('hiddenAnnouncements', hiddenAnnouncements.toList());
  }

  static Future<bool> checkUnreadAnnouncements(Set<String> clickedAnnouncements) async {
    var querySnapshot = await FirebaseFirestore.instance.collection('announcement').get();
    for (var doc in querySnapshot.docs) {
      if (!clickedAnnouncements.contains(doc.id)) {
        return true;
      }
    }
    return false;
  }
}

class UserAnnouncementPage extends StatefulWidget {
  final Function(String) markAsRead;
  final Function() onAnnouncementRead;
  final Function() onAnnouncementsHidden;

  const UserAnnouncementPage({
    Key? key,
    required this.markAsRead,
    required this.onAnnouncementRead,
    required this.onAnnouncementsHidden,
  }) : super(key: key);

  @override
  _UserAnnouncementPageState createState() => _UserAnnouncementPageState();
}

class _UserAnnouncementPageState extends State<UserAnnouncementPage> {
  Set<String> clickedAnnouncements = Set<String>();
  Set<String> hiddenAnnouncements = Set<String>();
  bool hasUnreadAnnouncements = false;

  @override
  void initState() {
    super.initState();
    _loadAnnouncementsData();
  }

  Future<void> _loadAnnouncementsData() async {
    clickedAnnouncements = await AnnouncementHelper.loadClickedAnnouncements();
    hiddenAnnouncements = await AnnouncementHelper.loadHiddenAnnouncements();
    _checkUnreadAnnouncements();
  }

  Future<void> _checkUnreadAnnouncements() async {
    bool unread = await AnnouncementHelper.checkUnreadAnnouncements(clickedAnnouncements);
    setState(() {
      hasUnreadAnnouncements = unread;
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch the file URL')),
      );
    }
  }

  void _showAnnouncementDialog(BuildContext context, String id, String title, String description, DateTime dateAndTime, String? fileUrl) {
    setState(() {
      clickedAnnouncements.add(id);
      AnnouncementHelper.saveClickedAnnouncements(clickedAnnouncements);
    });

    widget.markAsRead(id);
    widget.onAnnouncementRead();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(dateAndTime)}'),
              SizedBox(height: 10),
              Text(description),
              if (fileUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    onTap: () => _launchURL(fileUrl),
                    child: Text(
                      'Download Attachment',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
            ],
          ),
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

  Future<void> _deleteAllAnnouncements() async {
    final snapshot = await FirebaseFirestore.instance.collection('announcement').get();
    for (var doc in snapshot.docs) {
      hiddenAnnouncements.add(doc.id);
      clickedAnnouncements.add(doc.id);
    }
    await AnnouncementHelper.saveHiddenAnnouncements(hiddenAnnouncements);
    await AnnouncementHelper.saveClickedAnnouncements(clickedAnnouncements);
    setState(() {
      _checkUnreadAnnouncements();
    });

    widget.onAnnouncementsHidden();
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
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
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
                Column(
                  children: [
                    Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xddD21f3C),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            child: AspectRatio(
                              aspectRatio: 1.3,
                              child: Image(
                                image: AssetImage('asset/announcement.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Announcement',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0xddD21f3C),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () async {
                                bool confirm = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Delete All Announcements"),
                                      content: const Text(
                                          "Are you sure you want to delete all announcements?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("Delete"),
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm) {
                                  _deleteAllAnnouncements();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: MediaQuery.of(context).size.height / 2.5,
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
                              final visibleData = data.where((doc) => !hiddenAnnouncements.contains(doc.id)).toList();
                              return ListView.builder(
                                itemCount: visibleData.length,
                                itemBuilder: (context, index) {
                                  String id = visibleData[index].id;
                                  bool isClicked = clickedAnnouncements.contains(id);
                                  var dateAndTimeRaw = visibleData[index]['dateandtime'];
                                  DateTime dateAndTime;
                                  String? fileUrl = (visibleData[index].data() as Map<String, dynamic>).containsKey('fileUrl') ? visibleData[index]['fileUrl'] as String? : null;

                                  if (dateAndTimeRaw is Timestamp) {
                                    dateAndTime = dateAndTimeRaw.toDate();
                                  } else if (dateAndTimeRaw is String) {
                                    dateAndTime = DateTime.parse(dateAndTimeRaw);
                                  } else {
                                    dateAndTime = DateTime.now();
                                  }

                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isClicked ? Colors.grey[200] : Colors.white,
                                      border: Border.all(
                                        color: isClicked ? Colors.grey : Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        visibleData[index]['title'] ?? '',
                                        style: TextStyle(
                                          color: isClicked ? Colors.grey : Colors.black,
                                          fontWeight: isClicked ? FontWeight.normal : FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(dateAndTime)}',
                                        style: TextStyle(
                                          color: isClicked ? Colors.grey : Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        _showAnnouncementDialog(
                                          context,
                                          id,
                                          visibleData[index]['title'] ?? '',
                                          visibleData[index]['description'] ?? '',
                                          dateAndTime,
                                          fileUrl,
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(child: CircularProgressIndicator());
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
