import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AnnouncementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Announcements', style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w800,
                                                  color: Color.fromARGB(
                                                      255, 52, 52, 52),
                                                ),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('announcements').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No announcements found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var announcement = snapshot.data!.docs[index];
              var announcementData = announcement.data() as Map<String, dynamic>;

              // Extracting data from Firestore document
              String announcementText = announcementData['announcement'] ?? '';
              String imageLink = announcementData['imageLink'] ?? '';
              Timestamp timestamp = announcementData['timestamp'] ?? Timestamp.now();
              DateTime dateTime = timestamp.toDate();
              String formattedDateTime = DateFormat.yMd().add_jm().format(dateTime);

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(announcementText),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageLink.isNotEmpty) Image.network(imageLink),
                      Text('Date & Time: $formattedDateTime'),
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

