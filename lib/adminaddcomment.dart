import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment List' ,style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 52, 52, 52),
                                ),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No chats found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var chat = snapshot.data!.docs[index];
              var chatData = chat.data() as Map<String, dynamic>;

              // Extracting data from Firestore document
              String recipientUid = chatData['recipientUid'] ?? '';
              String text = chatData['text'] ?? '';
 // Default to 'No' if null
              Timestamp timestamp = chatData['timestamp'];

              return Card(
                color: const Color.fromARGB(71, 207, 64, 251),
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  
                  title: Text(text),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recipient UID: $recipientUid'),
                      Text('Timestamp: ${timestamp.toDate()}'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Toggle Adminseen field
                         
                          chat.reference.update({'Adminseen': 'yes'});
                           Fluttertoast.showToast(
        msg: 'Successfully updated',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );
                        },
                        child: const Text('Mark as Seen'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
