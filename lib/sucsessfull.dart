import 'package:flutter/material.dart';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:quickhire/dashboard.dart';

class sucsess extends StatefulWidget {
  const sucsess({
    super.key,
  });

  @override
  State<sucsess> createState() => _sucsessState();
}

class _sucsessState extends State<sucsess> {
  late ConfettiController _controllerCenter;
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: Duration(seconds: 5));
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirection: -1.0, // Change to change the direction
              emissionFrequency: 0.05, // Adjust as per your preference
              numberOfParticles: 20, // Number of confetti particles
              gravity: 0.05, // Gravity - higher means faster falling
            ),
            SizedBox(height: 20),
            Text(
              'Booking Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Thank you for booking a room with us.', // Display actual room number
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'We look forward to hosting you!', // Display actual room number
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 120, 11, 192)),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const dashboard()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 120, 11, 192), // Background color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
