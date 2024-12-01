import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;

class AddAnnouncementPage extends StatefulWidget {
  const AddAnnouncementPage({super.key});

  @override
  _AddAnnouncementPageState createState() => _AddAnnouncementPageState();
}

class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
  final TextEditingController _textEditingController = TextEditingController();
  File? _image;
  String _imageUrl = '';
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    setState(() {
      _isLoading = true;
    });

    if (_image != null) {
      try {
        // Upload image to Firebase Storage
        Reference ref = FirebaseStorage.instance.ref().child('announcements').child(path.basename(_image!.path));
        UploadTask uploadTask = ref.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          _imageUrl = downloadUrl;
          _isLoading = false;
        });

      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('Error uploading image: $e');
        // Handle error
      }
    }
  }

  Future<void> _addAnnouncement() async {
    if (_textEditingController.text.isNotEmpty && _imageUrl.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('announcements').add({
          'announcement': _textEditingController.text.trim(),
          'imageLink': _imageUrl,
          'timestamp': Timestamp.now(),
        });

        // Clear fields after submission
        _textEditingController.clear();
        setState(() {
          _image = null;
          _imageUrl = '';
        });

        // Show success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Announcement added successfully!'),
        ));

      } catch (e) {
        print('Error adding announcement: $e');
        // Handle error
      }
    } else {
      // Show validation error or required fields message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please add both text and an image.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Announcement',style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w800,
                                                  color: Color.fromARGB(
                                                      255, 52, 52, 52),
                                                ),),
        centerTitle: true,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _image == null
                ? Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Text(
                      'No image selected.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.red,
                      ),
                    ),
                  )
                : Image.file(_image!, height: 200.0, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Pick Image'),
                  onPressed: _pickImage,
                ),
                const SizedBox(width: 20),
                _image != null
                    ? _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton.icon(
                            icon: const Icon(Icons.cloud_upload),
                            label: const Text('Upload Image'),
                            onPressed: _uploadImage,
                          )
                    : Container(),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Enter announcement text',
                border: OutlineInputBorder(),
              ),
              maxLines: null, // Allow multiple lines
            ),
            const SizedBox(height: 16.0),
            Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Send Announcement'),
                onPressed: _addAnnouncement,
              ),
            ],
          ),
        ),
          ],
        ),
      ),
      
    );
  }
}
