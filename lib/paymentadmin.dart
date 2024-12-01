import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart'; // For PDF handling
import 'package:fluttertoast/fluttertoast.dart'; // For displaying toasts

class UserImagesScreen extends StatelessWidget {
  const UserImagesScreen({super.key});

  Future<void> _downloadFile(String url) async {
    // Your download logic here (similar to previous implementation)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CV Overview',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(255, 52, 52, 52),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var user = snapshot.data!.docs[index];
              var userData = user.data() as Map<String, dynamic>;

              // Extracting data from Firestore document
              String userName = userData['name'] ?? '';
              String userEmail = userData['email'] ?? '';

              dynamic pdfData = userData['pdfUrl'];

              // Prepare lists for image URLs and PDF URLs
              List<String> imageUrls = [];
              List<String> pdfUrls = [];

              // Separate image URLs and PDF URLs from pdfData
              if (pdfData is String) {
                if (pdfData.toLowerCase().endsWith('.pdf')) {
                  pdfUrls.add(pdfData);
                } else {
                  imageUrls.add(pdfData); // Assume it's an image URL
                }
              } else if (pdfData is List) {
                for (var item in pdfData) {
                  if (item is String) {
                    if (item.toLowerCase().endsWith('.pdf')) {
                      pdfUrls.add(item);
                    } else {
                      imageUrls.add(item); // Assume it's an image URL
                    }
                  }
                }
              }

              return Card(
                color: const Color.fromARGB(73, 182, 64, 251),
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(userName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: $userEmail'),
                      const SizedBox(height: 8),
                      if (imageUrls.isNotEmpty || pdfUrls.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...imageUrls.map((imageUrl) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to full-screen image view
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: const Text('CV Preview'),
                                        ),
                                        body: Center(
                                          child: Image.network(imageUrl),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  imageUrl,
                                  width: double.infinity,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                            ...pdfUrls.map((pdfUrl) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () => _downloadFile(pdfUrl),
                                    icon: const Icon(Icons.download),
                                    label: const Text('Download PDF'),
                                  ),
                                  const SizedBox(height: 8),
                                  // Display PDF icon
                                  Container(
                                    width: double.infinity,
                                    height: 200.0,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(
                                        Icons.picture_as_pdf,
                                        size: 64,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
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
