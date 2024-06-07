import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const topPage());
}

// ignore: camel_case_types
class topPage extends StatelessWidget {
  const topPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: const Row(
            children: [
              FaIcon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.userCircle,
                size: 40,
                color: Colors.black,
              ),
              Text(
                ' Admin',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: const SizedBox(
              width: 130, child: Image(image: AssetImage('asset/logo.png'))),
        )
      ],
    );
  }
}
