import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/announcement.dart';
import 'package:dentalprogapplication/admin/appointment.dart';
import 'package:dentalprogapplication/admin/message.dart';
import 'package:dentalprogapplication/admin/records.dart';
import 'package:dentalprogapplication/admin/top.dart';
import 'package:dentalprogapplication/logout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const welcomePage());
}

class welcomePage extends StatefulWidget {
  const welcomePage({super.key});

  @override
  _welcomePage createState() => _welcomePage();
}

class _welcomePage extends State<welcomePage> {
  int unreadMessagesCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUnreadMessagesCount(); // Load the unread messages count on init
  }

  Future<void> _loadUnreadMessagesCount() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .where('receiver_id', isEqualTo: '0RB7FgoLBoctIJH49Uova6zIhQD3') // Replace with your actual admin ID
        .where('read', isEqualTo: false)
        .get();

    int unreadCount = querySnapshot.docs.length;

    setState(() {
      unreadMessagesCount = unreadCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
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
              child: ListView(
                children: [
                  const topPage(),
                  _buildButtonRow(
                    context,
                    'asset/records.png',
                    'Record',
                    const RecordsPage(),
                    'asset/announcement.png',
                    ' Announcement ',
                    const announcementPage(),
                  ),
                  _buildButtonRowWithMessageBadge(
                    context,
                    'asset/appointment.png',
                    'Appointment',
                    const appointmentPage(),
                    'asset/message.png',
                    ' Message ',
                    const messagePage(),
                  ),
                  _logoutButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, String assetName1, String label1,
      Widget page1, String assetName2, String label2, Widget page2) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15), // Adjusted vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page1)),
              child: Container(
                padding: const EdgeInsets.all(15), // Reduced padding
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xddD21f3C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.3, // Ensures icon maintains its shape
                      child: Image.asset(
                        assetName1,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label1,
                        style: const TextStyle(
                          fontSize: 18,  // Slightly reduced font size
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page2)),
              child: Container(
                padding: const EdgeInsets.all(15), // Reduced padding
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xddD21f3C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.3, // Ensures icon maintains its shape
                      child: Image.asset(
                        assetName2,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label2,
                        style: const TextStyle(
                          fontSize: 18,  // Slightly reduced font size
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRowWithMessageBadge(BuildContext context, String assetName1, String label1,
      Widget page1, String assetName2, String label2, Widget page2) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15), // Adjusted vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page1)),
              child: Container(
                padding: const EdgeInsets.all(15), // Reduced padding
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xddD21f3C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.3, // Ensures icon maintains its shape
                      child: Image.asset(
                        assetName1,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label1,
                        style: const TextStyle(
                          fontSize: 18,  // Slightly reduced font size
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page2)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15), // Reduced padding
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xddD21f3C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.3, // Ensures icon maintains its shape
                          child: Image.asset(
                            assetName2,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 5),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            label2,
                            style: const TextStyle(
                              fontSize: 18,  // Slightly reduced font size
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            '$unreadMessagesCount',
                            style: const TextStyle(
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
    );
  }

  Widget _logoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const logoutPage())),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 130, 130, 130),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Log out',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}