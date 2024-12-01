import 'package:flutter/material.dart';

class lodingindicator extends StatefulWidget {
  const lodingindicator({super.key});

  @override
  State<lodingindicator> createState() => _lodingindicatorState();
}

class _lodingindicatorState extends State<lodingindicator> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}