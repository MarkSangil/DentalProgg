import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/message.dart';
import 'package:dentalprogapplication/firebaseDBModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class viewmessagePage extends StatefulWidget {
  final firebaseDBModel data;
  const viewmessagePage({Key? key, required this.data}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _viewmessagePage createState() => _viewmessagePage();
}

// ignore: camel_case_types
class _viewmessagePage extends State<viewmessagePage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _messageController = TextEditingController();

  // Function to send the message to Firestore
  Future<void> sendMessage(String messageText) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Example data to be added
      Map<String, dynamic> messageData = {
        'sender_id': user!.uid,
        'code': widget.data.uid,
        'message': messageText,
        'receiver_id': widget.data.uid,
        'timestamp': Timestamp.now(), // Add a timestamp for sorting
      };

      // Add message to Firestore collection named 'messages'
      await firestore.collection('messages').add(messageData);
      // ignore: empty_catches
    } catch (error) {}
  }

  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 85, 85),
          title: Row(
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.arrow_left,
                  size: 40,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const messagePage(),
                      ));
                },
              ),
              const Text(
                'Messages',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('messages')
                          .where('code', isEqualTo: widget.data.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        final messages = snapshot.data!.docs;

                        messages.sort((a, b) {
                          DateTime timestampA = a['timestamp'].toDate();
                          DateTime timestampB = b['timestamp'].toDate();
                          return timestampA.compareTo(timestampB);
                        });

                        return ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final senderId = message['sender_id'];
                            DateTime messageTimestamp =
                                message['timestamp'].toDate();

                            bool sender = user!.uid == senderId;

                            final colors = user.uid == senderId
                                ? Colors.blue
                                : Colors.black;

                            return Column(
                              children: [
                                DateChip(date: messageTimestamp),
                                BubbleSpecialThree(
                                  text: message['message'],
                                  color: colors,
                                  tail: true,
                                  isSender: sender,
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ),
                Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                controller: _messageController,
                                decoration: const InputDecoration(
                                  hintText: 'Type a message...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                sendMessage(_messageController.text);
                                _messageController.clear();
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
