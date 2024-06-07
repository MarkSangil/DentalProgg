import 'package:dentalprogapplication/admin/welcome.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const backPage());
}

// ignore: camel_case_types
class backPage extends StatelessWidget {
  const backPage({super.key});

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
            MaterialPageRoute(builder: ((context) => const welcomePage())),
          ),
        ));
  }
}
