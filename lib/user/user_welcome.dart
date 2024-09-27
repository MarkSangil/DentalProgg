import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/firebaseDBModel.dart';
import 'package:dentalprogapplication/logout.dart';
import 'package:dentalprogapplication/user/user_announcement.dart';
import 'package:dentalprogapplication/user/user_appointment.dart';
import 'package:dentalprogapplication/user/user_profile.dart';
import 'package:dentalprogapplication/user/user_viewmessage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class user_welcomePage extends StatefulWidget {
  const user_welcomePage({Key? key}) : super(key: key);

  @override
  _user_welcomePageState createState() => _user_welcomePageState();
}

class _user_welcomePageState extends State<user_welcomePage> {
  Set<String> clickedAnnouncements = Set<String>();
  Set<String> hiddenAnnouncements = Set<String>();
  bool hasUnreadAnnouncements = false;
  String unreadAnnouncementTitle = '';
  int unreadMessagesCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadAnnouncementData();
    _loadUnreadMessagesCount();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> _loadAnnouncementData() async {
    clickedAnnouncements = await AnnouncementHelper.loadClickedAnnouncements();
    hiddenAnnouncements = await AnnouncementHelper.loadHiddenAnnouncements();
    _checkUnreadAnnouncements();
  }

  void _refreshAnnouncements() {
    _checkUnreadAnnouncements();
  }

  Future<void> _checkUnreadAnnouncements() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('announcement').get();
    bool unread = false;
    String title = '';
    int unreadCount = 0;

    for (var doc in querySnapshot.docs) {
      if (!clickedAnnouncements.contains(doc.id) && !hiddenAnnouncements.contains(doc.id)) {
        unread = true;
        title = doc['title'];
        unreadCount++;
      }
    }

    setState(() {
      hasUnreadAnnouncements = unread;
      unreadAnnouncementTitle = title;
    });

    if (unread) {
      _showNotification(title);
    }
  }

  Future<void> _saveClickedAnnouncements() async {
    await AnnouncementHelper.saveClickedAnnouncements(clickedAnnouncements);
  }

  Future<void> _saveHiddenAnnouncements() async {
    await AnnouncementHelper.saveHiddenAnnouncements(hiddenAnnouncements);
  }

  NotificationDetails getDefaultNotificationDetails(String title) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    return platformChannelSpecifics;
  }

  Future<void> _showNotification(String title) async {
    NotificationDetails defaultNotificationDetails = getDefaultNotificationDetails(title);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Announcement',
      title,
      defaultNotificationDetails,
      payload: 'item x',
    );
  }

  void _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    if (notificationResponse.payload != null) {
    }
  }

  Future<void> _loadUnreadMessagesCount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('messages')
          .where('receiver_id', isEqualTo: user.uid)
          .get();

      int unreadCount = 0;
      for (var doc in querySnapshot.docs) {
        if (doc.data().containsKey('read') && !doc['read']) {
          unreadCount++;
        } else if (!doc.data().containsKey('read')) {
          unreadCount++;
        }
      }

      setState(() {
        unreadMessagesCount = unreadCount;
      });
    }
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.userCircle,
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
                      Image.asset(
                        'asset/logo.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => user_profilePage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.solidUser,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => user_announcementPage(
                                  markAsRead: (id) {
                                    setState(() {
                                      clickedAnnouncements.add(id);
                                      AnnouncementHelper.saveClickedAnnouncements(clickedAnnouncements);
                                      _checkUnreadAnnouncements();
                                    });
                                  },
                                  onAnnouncementRead: _refreshAnnouncements,
                                  onAnnouncementsHidden: () {
                                    setState(() {
                                      _loadAnnouncementData();
                                    });
                                  },
                                ),
                              ),
                            ).then((_) => _refreshAnnouncements());
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'asset/announcement.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      ' Announcement ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (hasUnreadAnnouncements)
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 20,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => user_appointmentPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/appointment.png',
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Appointment',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => user_viewmessagePage(
                                  data: firebaseDBModel(
                                      uid: '0RB7FgoLBoctIJH49Uova6zIhQD3'),
                                )),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xddD21f3C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'asset/message.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '      Message       ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (unreadMessagesCount > 0)
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 20,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$unreadMessagesCount',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => logoutPage(),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 191, 191, 191),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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