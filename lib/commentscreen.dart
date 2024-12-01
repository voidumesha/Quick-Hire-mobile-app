import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String recipientUid;

  const ChatScreen({super.key, required this.recipientUid});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  void sendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      await FirebaseFirestore.instance.collection('chats').add({
        'text': messageText,
        'senderUid': FirebaseAuth.instance.currentUser!.uid,
        'recipientUid': widget.recipientUid,
        'Adminseen':'No',
        'timestamp': Timestamp.now(),
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Comment', style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w800,
                                                  color: Color.fromARGB(
                                                      255, 52, 52, 52),
                                                ),),
      ),
      body: Column(
        children: [
          // Display messages
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .where('senderUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where('recipientUid', isEqualTo: widget.recipientUid)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (chatSnapshot.hasError) {
                  return Center(child: Text('Error fetching messages: ${chatSnapshot.error}'));
                }

                if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No comment yet'));
                }

                final chatDocs = chatSnapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) {
                    Timestamp timestamp = chatDocs[index]['timestamp'];
                    DateTime dateTime = timestamp.toDate();
                    String formattedTime = DateFormat.yMd().add_jms().format(dateTime);

                    return Column(
                      crossAxisAlignment: chatDocs[index]['senderUid'] == FirebaseAuth.instance.currentUser!.uid
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: chatDocs[index]['senderUid'] == FirebaseAuth.instance.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            
                                decoration: const BoxDecoration(
                                  color:  Color.fromARGB(43, 233, 68, 255),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                            child: Text(chatDocs[index]['text']),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            formattedTime,
                            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child:chatDocs[index][ 'Adminseen']=='No'? const Text(
                            'Pending',
                            style: TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 255, 1, 1)),
                          ):const Text(
                            'Seen',
                            style: TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 1, 153, 255)),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          // Bottom text input area
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(labelText: 'Type your message...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
