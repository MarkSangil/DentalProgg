import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/recordsview.dart';

void main() {
  runApp(const RecordsPage());
}

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const backPage(),
                      const SizedBox(width: 10),
                      Image.asset('asset/records.png', width: 30),
                      const SizedBox(width: 10),
                      const Text(
                        'Records',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('type', isEqualTo: 'customer')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!.docs;
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(), // Disable scroll within ListView
                          shrinkWrap: true, // Allow ListView to size itself according to its children
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var doc = data[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: index % 2 == 0 ? Colors.pink.shade50 : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                title: Text(
                                  doc['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => recordsviewPage(
                                          uid: doc['uid'],
                                          age: doc['age'],
                                          address: doc['address'],
                                          gender: doc['gender'],
                                          contact: doc['contact'],
                                          name: doc['name']
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
