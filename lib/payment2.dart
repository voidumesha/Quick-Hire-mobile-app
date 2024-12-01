import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickhire/sucsessfull.dart';

class Payment2 extends StatefulWidget {
  const Payment2({super.key});

  @override
  State<Payment2> createState() => _Payment2State();
}

bool _isLoading = false;

class _Payment2State extends State<Payment2> {
  @override
  File? _selectedFile;
  String? _fileName = "not selected";
  bool? isChecked = false;
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _fileName = result.files.single.name;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    try {
      setState(() {
        _isLoading = true;
      });

      String fileName = _fileName!;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('pdfs/$fileName');
      UploadTask uploadTask = storageRef.putFile(_selectedFile!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});

      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
            {'pdfUrl': downloadURL, 'payment': 'yes', 'booked_room': 'yes'},
            SetOptions(merge: true));

        print('ffffffffffffffffffffffffffffffffffffff');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully')),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const sucsess()));
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: ' Error: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: const Color.fromARGB(134, 161, 0, 0),
        textColor: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 14.0,
      );

      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
        _selectedFile = null;
        _fileName = "not selected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back))
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/cloud-computing (1).png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        const Text(
                          "Upoload Payment Slip",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 52, 52, 52)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: _fileName == 'not selected'
                              ? InkWell(
                                  onTap: isChecked != true ? _pickFile : null,
                                  borderRadius: BorderRadius.circular(10),
                                  splashColor:
                                      const Color.fromARGB(255, 199, 199, 199),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: isChecked == true
                                                ? Colors.grey
                                                : const Color.fromARGB(
                                                    255, 120, 11, 192),
                                            width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 40,
                                      color: isChecked == true
                                          ? Colors.grey
                                          : const Color.fromARGB(255, 120, 11, 192),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: _pickFile,
                                  borderRadius: BorderRadius.circular(10),
                                  splashColor:
                                      const Color.fromARGB(255, 199, 199, 199),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: const Color.fromARGB(
                                                255, 120, 11, 192))),
                                    height: 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.document_scanner_outlined,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 120, 11, 192),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: 200,
                                          height: 80,
                                          child: Text(
                                            'Selected file: $_fileName',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Color.fromARGB(
                                                    255, 52, 52, 52)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: ElevatedButton(
                            onPressed: _uploadFile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 120, 11, 192), // Background color
                              foregroundColor: Colors.white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text(
                              'Conform',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
    );
  }
}
