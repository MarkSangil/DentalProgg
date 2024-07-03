import 'package:dentalprogapplication/user/user_welcome.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const user_backPage());
}

// ignore: camel_case_types
class user_backPage extends StatelessWidget {
  const user_backPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        title: GestureDetector(
          child: const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.black,
              ),
              Text(
                ' Back',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: ((context) => user_welcomePage())),
          ),
        ));
  }
}
