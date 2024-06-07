import 'package:dentalprogapplication/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const logoutPage());
}

// ignore: camel_case_types
class logoutPage extends StatelessWidget {
  const logoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xddD21f3C),
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 2)),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(7),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              onTap: () async {
                await FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const loginPage()),
                          (route) =>
                              false, // Prevents going back to the previous route
                        ));
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: const Text('Are you sure you want to logout?'),
          ),
        ],
      ),
    );
  }
}
