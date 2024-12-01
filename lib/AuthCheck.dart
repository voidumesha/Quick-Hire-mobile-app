import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickhire/Login.dart';
import 'package:quickhire/RegisterPage.dart';
import 'package:quickhire/dashboard.dart';
import 'package:quickhire/onbording.dart';
// Assuming you have an Onboarding screen

import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatefulWidget {
  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool _isFirstLaunch = true; // Assume first launch by default

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
    setState(() {
      _isFirstLaunch = isFirstLaunch;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    if (_isFirstLaunch) {
      return OnboardingScreen(); // Replace with your Onboarding screen widget
    } else {
      return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return dashboard();
        } else {
          return login();
        }
      },
    );
    }
  }
}
