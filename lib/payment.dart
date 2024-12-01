import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickhire/sucsessfull.dart';

class Payment extends StatefulWidget {
  final String roomid;
  final int avlbed;
  final String faculty;
  final String Baj;
  final String floor;
  const Payment(
      {super.key,
      required this.floor,
      required this.roomid,
      required this.avlbed,
      required this.Baj,
      required this.faculty});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool _isLoading = false;

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
        print('dddddddddddddddddddddddddddddddddd');
        final x = widget.avlbed.toString();
        await FirebaseFirestore.instance
            .collection(widget.floor)
            .doc(widget.roomid)
            .set({
          'Booked_beds': widget.avlbed + 1,
          'Faculty': widget.faculty,
          'student$x': user.uid,
          'Batch': widget.Baj
        }, SetOptions(merge: true));
      }
      print(widget.faculty);
      print('ffffffffffffffffffffffffffffffffffffff');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully')),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const sucsess()));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: ' Error: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Color.fromARGB(134, 161, 0, 0),
        textColor: Color.fromARGB(255, 255, 255, 255),
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

  Future<void> _uploadwithotFile() async {
    try {
      setState(() {
        _isLoading = true;
      });

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
            {'payment': 'No', 'booked_room': 'yes'}, SetOptions(merge: true));
        print('dddddddddddddddddddddddddddddddddd');
        final x = widget.avlbed.toString();
        await FirebaseFirestore.instance
            .collection(widget.floor)
            .doc(widget.roomid)
            .set({
          'Booked_beds': widget.avlbed + 1,
          'Faculty': widget.faculty,
          'student$x': user.uid,
          'Batch': widget.Baj
        }, SetOptions(merge: true));
      }
      print('ffffffffffffffffffffffffffffffffffffff');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully')),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const sucsess()));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: ' Error: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Color.fromARGB(134, 161, 0, 0),
        textColor: Color.fromARGB(255, 255, 255, 255),
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
              ? CircularProgressIndicator()
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
                                  icon: Icon(Icons.arrow_back))
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/cloud-computing (1).png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        Text(
                          "Upoload Payment Slip",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 52, 52, 52)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: _fileName == 'not selected'
                              ? InkWell(
                                  onTap: isChecked != true ? _pickFile : null,
                                  borderRadius: BorderRadius.circular(10),
                                  splashColor:
                                      Color.fromARGB(255, 199, 199, 199),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: isChecked == true
                                                ? Colors.grey
                                                : Color.fromARGB(
                                                    255, 120, 11, 192),
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 40,
                                      color: isChecked == true
                                          ? Colors.grey
                                          : Color.fromARGB(255, 120, 11, 192),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: _pickFile,
                                  borderRadius: BorderRadius.circular(10),
                                  splashColor:
                                      Color.fromARGB(255, 199, 199, 199),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 120, 11, 192))),
                                    height: 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
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
                                            style: TextStyle(
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
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              Checkbox(
                                tristate: false,
                                value: isChecked,
                                activeColor: Color.fromARGB(255, 120, 11, 192),
                                onChanged: (values) {
                                  setState(() {
                                    isChecked = values;
                                  });
                                },
                              ),
                              Container(
                                  child: Text(
                                "Skip",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 120, 11, 192)),
                              )),
                            ],
                          ),
                        ),
                        isChecked == true
                            ? ElevatedButton(
                                onPressed: _uploadwithotFile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                      255, 120, 11, 192), // Background color
                                  foregroundColor: Colors.white, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: Text(
                                  'Conform',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedFile = null;
                                        _fileName = 'not selected';
                                      });
                                    },
                                    child: Text('Remove File'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: ElevatedButton(
                                      onPressed: _selectedFile != null
                                          ? _uploadFile
                                          : null,
                                      child: Text(
                                        'Submit',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ],
                    ),
                  ],
                )),
    );
  }
}
