import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/admin/message.dart';
import 'package:dentalprogapplication/firebaseDBModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class viewmessagePage extends StatefulWidget {
  final firebaseDBModel data;
  const viewmessagePage({Key? key, required this.data}) : super(key: key);

  @override
  _viewmessagePage createState() => _viewmessagePage();
}

class _viewmessagePage extends State<viewmessagePage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _messageController = TextEditingController();

  Future<void> sendMessage(String messageText) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      Map<String, dynamic> messageData = {
        'sender_id': user!.uid,
        'code': widget.data.uid,
        'message': messageText,
        'receiver_id': widget.data.uid,
        'timestamp': Timestamp.now(),
      };

      await firestore.collection('messages').add(messageData);
    } catch (error) {
      print('Error sending message: $error');
    }
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
                  Navigator.push(context,
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
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('No messages found');
                    }

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
                        DateTime messageTimestamp = message['timestamp'].toDate();
                        bool sender = user!.uid == senderId;
                        final colors = sender ? Colors.blue : Colors.black;
                        return Column(
                          children: [
                            DateChip(date: messageTimestamp),
                            BubbleSpecialThree(
                              text: message['message'],
                              color: colors,
                              tail: true,
                              isSender: sender,
                              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd – kk:mm').format(messageTimestamp), // Display timestamp
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
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
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                            if (_messageController.text.trim().isNotEmpty) {
                              sendMessage(_messageController.text.trim());
                              _messageController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
