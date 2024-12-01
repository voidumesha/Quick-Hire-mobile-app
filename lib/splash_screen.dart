import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quickhire/AuthCheck.dart';
import 'package:quickhire/Login.dart';

class SplashActivity extends StatefulWidget {
  const SplashActivity({super.key});

  @override
  _SplashActivityState createState() => _SplashActivityState();
}

class _SplashActivityState extends State<SplashActivity> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AuthCheck()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 203, 128, 238),
              Color.fromARGB(255, 98, 23, 133)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/mainimg.png',
                width: 370,
                height: 330,
              ),
              const SizedBox(height: 50),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                  children: <TextSpan>[
                    TextSpan(text: 'Welcome to Quick Hire \n'),
                    TextSpan(text: 'Platform'),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
