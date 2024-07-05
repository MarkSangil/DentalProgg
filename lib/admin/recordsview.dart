import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/download.dart';
import 'package:dentalprogapplication/admin/history.dart';
import 'package:dentalprogapplication/admin/prescription.dart';

class RecordsViewPage extends StatefulWidget {
  final String uid;
  final String age;
  final String address;
  final String gender;
  final String contact;
  final String name;

  const RecordsViewPage({
    Key? key,
    required this.uid,
    required this.age,
    required this.address,
    required this.gender,
    required this.contact,
    required this.name,
  }) : super(key: key);

  @override
  _RecordsViewPageState createState() => _RecordsViewPageState();
}

class _RecordsViewPageState extends State<RecordsViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'asset/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xddD21f3C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Image(
                        width: 60,
                        image: AssetImage('asset/records.png'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Records',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xddD21f3C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            child: const FaIcon(
                              FontAwesomeIcons.fileArrowDown,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DownloadPage(uid: widget.uid),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black),
                      Table(
                        border: TableBorder.all(color: Colors.white),
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(4),
                        },
                        children: [
                          _buildTableRow('AGE', widget.age),
                          _buildTableRow('GENDER', widget.gender),
                          _buildTableRow('ADDRESS', widget.address),
                          _buildTableRow('CONTACT NO.', widget.contact),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildActionButton('HISTORY', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => historyPage(uid: widget.uid),
                    ),
                  );
                }),
                _buildActionButton('PRESCRIPTION', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => prescriptionPage(
                        uid: widget.uid,
                        age: widget.age,
                        address: widget.address,
                        gender: widget.gender,
                        contact: widget.contact,
                        name: widget.name,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xddD21f3C),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
