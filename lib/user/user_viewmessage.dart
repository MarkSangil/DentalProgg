import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/firebaseDBModel.dart';
import 'package:dentalprogapplication/user/user_welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class user_viewmessagePage extends StatefulWidget {
  final firebaseDBModel data;
  const user_viewmessagePage({Key? key, required this.data}) : super(key: key);

  @override
  _user_viewmessagePage createState() => _user_viewmessagePage();
}

class _user_viewmessagePage extends State<user_viewmessagePage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // Scroll controller added

  // Function to send the message to Firestore
  Future<void> sendMessage(String messageText) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Example data to be added
      Map<String, dynamic> messageData = {
        'sender_id': user!.uid,
        'code': user!.uid,
        'message': messageText,
        'receiver_id': widget.data.uid,
        'timestamp': Timestamp.now(), // Add a timestamp for sorting
        'read': false,
      };

      // Add message to Firestore collection named 'messages'
      await firestore.collection('messages').add(messageData);

      // Scroll to the bottom after sending the message
      _scrollToBottom();
    } catch (error) {
      // Handle error here
    }
  }

  // Function to scroll to the bottom of the ListView
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  // Function to delete all messages in the conversation
  Future<void> deleteConversation() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query to get all messages with the current user's UID as the code
      QuerySnapshot querySnapshot = await firestore
          .collection('messages')
          .where('code', isEqualTo: user!.uid)
          .get();

      // Delete each message document
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      // Navigate back to the welcome page after deletion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const user_welcomePage(),
        ),
      );
    } catch (error) {
      // Handle error here
    }
  }

  @override
  void initState() {
    super.initState();
    // Scroll to bottom after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xddD21f3C),
          title: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const user_welcomePage(),
                      ));
                },
              ),
              const Text(
                'Messages',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () async {
                // Show a confirmation dialog before deleting
                bool confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Conversation"),
                      content: const Text(
                          "Are you sure you want to delete the entire conversation?"),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: const Text("Delete"),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                );

                if (confirm) {
                  deleteConversation();
                }
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .where('code', isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No messages found.'));
                    }

                    final messages = snapshot.data!.docs;
                    messages.sort((a, b) {
                      DateTime timestampA = a['timestamp'].toDate();
                      DateTime timestampB = b['timestamp'].toDate();
                      return timestampA.compareTo(timestampB);
                    });

                    // Mark all displayed messages as read
                    for (var message in messages) {
                      final messageData = message.data() as Map<String, dynamic>;
                      if (messageData.containsKey('read') && !messageData['read'] && messageData['receiver_id'] == user.uid) {
                        message.reference.update({'read': true});
                      } else if (!messageData.containsKey('read') && messageData['receiver_id'] == user.uid) {
                        message.reference.update({'read': true});
                      }
                    }

                    // Scroll to bottom after messages load
                    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

                    return ListView.builder(
                      controller: _scrollController, // Attach the scroll controller here
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final messageData = message.data() as Map<String, dynamic>;
                        final senderId = messageData['sender_id'];
                        DateTime messageTimestamp = messageData['timestamp'].toDate();
                        bool sender = user.uid == senderId;

                        return Column(
                          crossAxisAlignment: sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: DateChip(date: messageTimestamp),
                            ),
                            BubbleSpecialThree(
                              text: messageData['message'],
                              color: sender ? const Color(0xddD21f3C) : Colors.grey,
                              tail: true,
                              isSender: sender,
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                DateFormat('hh:mm a').format(messageTimestamp),
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
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
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        if (_messageController.text.isNotEmpty) {
                          sendMessage(_messageController.text);
                          _messageController.clear();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xddD21f3C),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
