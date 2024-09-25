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
  final ScrollController _scrollController = ScrollController(); // ScrollController added
  int unreadMessagesCount = 0;

  Future<void> sendMessage(String messageText) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      Map<String, dynamic> messageData = {
        'sender_id': user!.uid,
        'code': widget.data.uid,
        'message': messageText,
        'receiver_id': widget.data.uid,
        'timestamp': Timestamp.now(),
        'read': false,
      };

      await firestore.collection('messages').add(messageData);
      _scrollToBottom(); // Scroll to bottom after sending the message
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  Future<void> _getUnreadMessagesCount() async {
    var unreadMessagesSnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .where('receiver_id', isEqualTo: user!.uid)
        .where('read', isEqualTo: false)
        .get();

    setState(() {
      unreadMessagesCount = unreadMessagesSnapshot.docs.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUnreadMessagesCount(); // Fetch the unread messages count on initialization

    // Ensure scrolling to the bottom after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  // Scroll to bottom function
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

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
                  Icons.arrow_back,
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
                'Messagessss',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Stack(
                children: [
                  Icon(Icons.message, size: 40, color: Colors.white),
                  if (unreadMessagesCount > 0) // Display the count if there are unread messages
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                        child: Text(
                          '$unreadMessagesCount', // Unread messages count
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
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
                      return const Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No messages found'));
                    }

                    final messages = snapshot.data!.docs;

                    messages.sort((a, b) {
                      DateTime timestampA = a['timestamp'].toDate();
                      DateTime timestampB = b['timestamp'].toDate();
                      return timestampA.compareTo(timestampB); // Sort in ascending order
                    });

                    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom()); // Scroll after messages load

                    return ListView.builder(
                      controller: _scrollController, // Attach ScrollController
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
