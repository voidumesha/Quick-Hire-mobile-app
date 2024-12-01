import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickhire/Login.dart';
import 'package:quickhire/dashboard.dart';


class AuthService {
 


  Future<void> signout({
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signOut();
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => login(),
        ),
      );
       Fluttertoast.showToast(
        msg: 'User successfully Logout',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      // Handle sign out errors if necessary
      print("Error signing out: $e");
    }
  }
}
