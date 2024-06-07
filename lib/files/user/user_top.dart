import 'package:flutter/material.dart';

void main() {
  runApp(const user_topPage());
}

// ignore: camel_case_types
class user_topPage extends StatelessWidget {
  const user_topPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: const SizedBox(
              width: 130, child: Image(image: AssetImage('asset/logo.png'))),
        )
      ],
    );
  }
}
