import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/back.dart';
import 'package:dentalprogapplication/admin/messagesearch.dart';
import 'package:dentalprogapplication/admin/viewmessage.dart';
import 'package:dentalprogapplication/firebaseDBModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const messagePage());
}

class messagePage extends StatefulWidget {
  const messagePage({super.key});

  @override
  _messagePage createState() => _messagePage();
}

class _messagePage extends State<messagePage> {
  final TextEditingController searchController = TextEditingController();

  Future<List<Map<String, dynamic>>> _getUsersWithUnreadStatus(List<QueryDocumentSnapshot> docs) async {
    List<Map<String, dynamic>> usersWithStatus = await Future.wait(docs.map((doc) async {
      bool hasUnreadMessages = await _hasUnreadMessages(doc['uid']);
      DateTime? lastMessageTime = await _getLastMessageTime(doc['uid']);
      return {
        'doc': doc,
        'hasUnreadMessages': hasUnreadMessages,
        'lastMessageTime': lastMessageTime
      };
    }).toList());

    // Sort by lastMessageTime (descending)
    usersWithStatus.sort((a, b) {
      if (a['lastMessageTime'] == null && b['lastMessageTime'] == null) {
        return 0;
      } else if (a['lastMessageTime'] == null) {
        return 1;
      } else if (b['lastMessageTime'] == null) {
        return -1;
      } else {
        return b['lastMessageTime'].compareTo(a['lastMessageTime']);
      }
    });

    return usersWithStatus;
  }

  Future<bool> _hasUnreadMessages(String userId) async {
    var unreadMessagesQuery = FirebaseFirestore.instance
        .collection('messages')
        .where('receiver_id', isEqualTo: '0RB7FgoLBoctIJH49Uova6zIhQD3')
        .where('sender_id', isEqualTo: userId)
        .where('read', isEqualTo: false);

    var unreadMessagesSnapshot = await unreadMessagesQuery.get();
    var unreadMessages = unreadMessagesSnapshot.docs;
    return unreadMessages.isNotEmpty;
  }

  Future<DateTime?> _getLastMessageTime(String userId) async {
    var lastMessageQuery = await FirebaseFirestore.instance
        .collection('messages')
        .where('sender_id', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (lastMessageQuery.docs.isNotEmpty) {
      return (lastMessageQuery.docs.first['timestamp'] as Timestamp).toDate();
    }

    return null;
  }

  Widget _buildUserRow(QueryDocumentSnapshot doc, bool hasUnreadMessages) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: hasUnreadMessages
              ? Colors.yellow[200]
              : const Color.fromARGB(84, 165, 20, 20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: doc['image'] == ''
                              ? const FaIcon(
                            FontAwesomeIcons.circleUser,
                            size: 40,
                          )
                              : Image.network(
                            doc['image'],
                            width: 40,
                            height: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          doc['name'] ?? '',
                          style: TextStyle(
                            color: hasUnreadMessages ? Colors.black : Colors.white,
                            fontWeight: hasUnreadMessages
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontStyle: hasUnreadMessages
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                        ),
                        if (hasUnreadMessages)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.markunread,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        markMessagesAsRead(doc['uid']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => viewmessagePage(
              data: firebaseDBModel(uid: doc['uid']),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const backPage(),
                    Container(
                      margin: const EdgeInsets.only(top: 70),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 130,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 18),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const SizedBox(
                              child: Image(
                                width: 130,
                                image: AssetImage('asset/message.png'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            children: [
                              Text(
                                'Message',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(86, 255, 52, 52),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(86, 255, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Image(
                                    width: 50,
                                    image: AssetImage('asset/logo.png')),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xddD21f3C),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller: searchController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            bottom: 7, left: 10),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                ),
                                GestureDetector(
                                  child: const FaIcon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      size: 30,
                                      color: Colors.white),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              messagesearchPage(
                                                  searchtext: searchController
                                                      .text))),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where('type', isEqualTo: 'customer')
                                  .snapshots(),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data?.docs ?? [];
                                  return FutureBuilder<List<Map<String, dynamic>>>(
                                    future: _getUsersWithUnreadStatus(data),
                                    builder: (context, futureSnapshot) {
                                      if (futureSnapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else if (futureSnapshot.hasError) {
                                        return const Center(child: Text('Error loading messages'));
                                      } else {
                                        var sortedData = futureSnapshot.data!;
                                        return ListView.builder(
                                          itemCount: sortedData.length,
                                          itemBuilder: (context, index) {
                                            var item = sortedData[index];
                                            return _buildUserRow(item['doc'], item['hasUnreadMessages']);
                                          },
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  return const Text('NO DATA');
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void markMessagesAsRead(String userId) async {
    var unreadMessages = await FirebaseFirestore.instance
        .collection('messages')
        .where('receiver_id', isEqualTo: '0RB7FgoLBoctIJH49Uova6zIhQD3')
        .where('sender_id', isEqualTo: userId)
        .where('read', isEqualTo: false)
        .get();

    for (var doc in unreadMessages.docs) {
      await doc.reference.update({'read': true});
    }
  }
}
