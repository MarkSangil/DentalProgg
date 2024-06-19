import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Records',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('type', isEqualTo: 'customer')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.pink.shade200),
                    dataRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    columns: const [
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Details',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: snapshot.data!.docs
                        .map<DataRow>((DocumentSnapshot document) {
                      return DataRow(cells: [
                        DataCell(Text(document['name'])),
                        DataCell(IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => recordsviewPage(
                                  uid: document['uid'],
                                  age: document['age'],
                                  address: document['address'],
                                  gender: document['gender'],
                                  contact: document['contact'],
                                  name: document['name'],
                                ),
                              ),
                            );
                          },
                        )),
                      ]);
                    }).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
