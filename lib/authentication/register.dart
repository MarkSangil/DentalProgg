import 'package:dentalprogapplication/authentication/login.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const registerPage());
}

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  _registerPage createState() => _registerPage();
}

class _registerPage extends State<registerPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
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
              padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.1),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.03),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.asset(
                        'asset/logo.png',
                        width: mediaQuery.size.width * 0.3,
                        height: mediaQuery.size.width * 0.3,
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
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: mediaQuery.size.height * 0.02),
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
                              image: AssetImage('asset/input1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: TextField(
                            controller: name,
                            decoration: const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: mediaQuery.size.height * 0.02),
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
                              image: AssetImage('asset/input1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: TextField(
                            controller: email,
                            decoration: const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: mediaQuery.size.height * 0.02),
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
                              image: AssetImage('asset/input1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: TextField(
                            controller: password,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQuery.size.height * 0.02),
                        Container(
                          height: mediaQuery.size.height * 0.06,
                          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 15, 5, 93),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: TextButton(
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                              onPressed: () {
                                if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text('Please fill in all fields.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Registration'),
                                        content: const Text('Are you sure you want to register with the provided details?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Controller().Register(
                                                name.text,
                                                email.text,
                                                password.text,
                                              );
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Registration Successful'),
                                                    content: const Text('Congratulations! Your registration was successful.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: ((context) => const loginPage()),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text('Confirm'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQuery.size.height * 0.02),
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
