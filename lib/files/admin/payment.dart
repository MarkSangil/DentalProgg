// import 'package:dentalprogapplication/authentication/login.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/welcome.dart';
import 'package:dentalprogapplication/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class paymentPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String appointment_id;
  final String name;
  // ignore: non_constant_identifier_names
  final String user_id;
  // ignore: non_constant_identifier_names
  const paymentPage(
      {super.key,
      // ignore: non_constant_identifier_names
      required this.appointment_id,
      required this.name,
      // ignore: non_constant_identifier_names
      required this.user_id});

  @override
  // ignore: library_private_types_in_public_api
  _paymentPage createState() => _paymentPage();
}

// ignore: camel_case_types
class _paymentPage extends State<paymentPage> {
  final TextEditingController amount = TextEditingController();

  String selectedPaymentMethod = 'Gcash'; // Default value
  String selectedDentalServices = 'BRACES';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin: const EdgeInsets.only(top: 10),
              child: ListView(
                children: [
                  const backPage(),
                  Container(
                    margin: const EdgeInsets.all(20),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(122, 210, 31, 61),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xddD21f3C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const FaIcon(
                                // ignore: deprecated_member_use
                                FontAwesomeIcons.moneyBill,
                                size: 50,
                                color: Colors.white,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  child: const Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'Payment Page',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: const Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(86, 255, 52, 52),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextField(
                                      controller: amount,
                                      style: const TextStyle(fontSize: 22),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                    )),
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: const Text(
                                    'Payment Method',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(86, 255, 52, 52),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectedPaymentMethod,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedPaymentMethod = newValue!;
                                      });
                                    },
                                    items: <String>['Gcash', 'Paymaya', 'Cash']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: const Text(
                                    'Dental Services',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(86, 255, 52, 52),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectedDentalServices,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedDentalServices = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'BRACES',
                                      'CLEANING',
                                      'SURGERY'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: TextButton(
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Controller().Payment(
                                          widget.appointment_id,
                                          widget.user_id,
                                          widget.name,
                                          amount.text,
                                          selectedPaymentMethod,
                                          selectedDentalServices,
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Create Payment Successful'),
                                              content: const Text(
                                                  'Created! Payment was successful.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                const welcomePage())));
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    )),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
