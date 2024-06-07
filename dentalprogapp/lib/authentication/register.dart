import 'package:dentalprogapplication/authentication/login.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const registerPage());
}

// ignore: camel_case_types
class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _registerPage createState() => _registerPage();
}

// ignore: camel_case_types
class _registerPage extends State<registerPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              'asset/bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Other widgets on top of the background image
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: ListView(
                children: [
                  // Your existing widgets here
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset(
                        'asset/logo.png',
                        // You can add additional properties like width, height, fit, etc.
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(130, 143, 143, 143),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'CREATE NEW ACCOUNT',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'NAME',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'asset/input1.png'), // Replace 'your_image_path_here.jpg' with your image asset path
                              fit: BoxFit.cover, // Adjust the fit as needed
                            ),
                          ),
                          child: TextField(
                            controller: name,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'EMAIL',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'asset/input1.png'), // Replace 'your_image_path_here.jpg' with your image asset path
                              fit: BoxFit.cover, // Adjust the fit as needed
                            ),
                          ),
                          child: TextField(
                            controller: email,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'PASSWORD',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'asset/input1.png'), // Replace 'your_image_path_here.jpg' with your image asset path
                              fit: BoxFit.cover, // Adjust the fit as needed
                            ),
                          ),
                          child: TextField(
                            controller: password,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 15, 5, 93),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                              child: const Text(
                                'REGISTER',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Controller().Register(
                                  name.text,
                                  email.text,
                                  password.text,
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Registration Successful'),
                                      content: const Text(
                                          'Congratulations! Your registration was successful.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const loginPage())));
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already Have An Account? '),
                            GestureDetector(
                              child: const Text(
                                'Log In',
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const loginPage()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
