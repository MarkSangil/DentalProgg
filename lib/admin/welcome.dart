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
                  _buildButtonRow(context,
                      'asset/records.png', 'Record', const RecordsPage(),
                      'asset/announcement.png', 'Announcement', const announcementPage()),
                  _buildButtonRow(context,
                      'asset/appointment.png', 'Appointment', const appointmentPage(),
                      'asset/message.png', 'Message', const messagePage()),
                  _logoutButton(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context,
      String assetName1, String label1, Widget page1,
      String assetName2, String label2, Widget page2) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),  // Adjust spacing as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _buildButton(context, assetName1, label1, page1),
          ),
          const SizedBox(width: 10),  // Space between the buttons
          Expanded(
            child: _buildButton(context, assetName2, label2, page2),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String assetName, String label, Widget nextPage) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage)),
      child: Container(
        height: 180,  // Fixed height for all buttons
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xddD21f3C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.3,  // Consistent aspect ratio
              child: Image(
                image: AssetImage(assetName),
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const logoutPage())),
      child: Container(
        width: double.infinity,  // Full width button
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
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
