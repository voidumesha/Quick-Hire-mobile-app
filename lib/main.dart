import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickhire/AuthCheck.dart';
import 'package:quickhire/Login.dart';
import 'package:quickhire/RegisterPage.dart';
import 'package:quickhire/RegisterRoom.dart';
import 'package:quickhire/adminAnnounce.dart';
import 'package:quickhire/adminDashboard.dart';
import 'package:quickhire/adminlog.dart';
import 'package:quickhire/annuncement.dart';
import 'package:quickhire/booking.dart';
import 'package:quickhire/commentscreen.dart';
import 'package:quickhire/dashboard.dart';
import 'package:quickhire/firebase_options.dart';
import 'package:quickhire/onbording.dart';
import 'package:quickhire/payment.dart';
import 'package:quickhire/paymentadmin.dart';
import 'package:quickhire/splash_screen.dart';
import 'package:quickhire/sucsessfull.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashActivity(),
    );
  }
}
