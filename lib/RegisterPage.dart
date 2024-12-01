import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickhire/Login.dart';
import 'package:quickhire/RegisterRoom.dart';
import 'package:quickhire/dashboard.dart';
import 'package:quickhire/firebaseauthservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

bool showpassword = true;
bool regloding = false;

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          height: 90,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/mainimg.png'),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 5,
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: 50,
                      height: 50,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: const Color.fromARGB(255, 53, 53, 53),
                          )),
                    )),
              ],
            ),
          ),
          Text(
            "Register",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 49, 49, 49)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _nameController,
              cursorColor: Color.fromARGB(255, 120, 11, 192),
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(color: Color.fromARGB(255, 188, 188, 188)),
                filled: true,
                fillColor: Color.fromARGB(255, 242, 242, 242),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _usernameController,
              cursorColor: Color.fromARGB(255, 120, 11, 192),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Color.fromARGB(255, 188, 188, 188)),
                filled: true,
                fillColor: Color.fromARGB(255, 242, 242, 242),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _passwordController,
              obscureText: showpassword,
              cursorColor: Color.fromARGB(255, 120, 11, 192),
              decoration: InputDecoration(
                focusColor: Color.fromARGB(255, 120, 11, 192),
                hintText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      if (showpassword == true) {
                        showpassword = false;
                      } else {
                        showpassword = true;
                      }
                    });
                  },
                  icon: showpassword
                      ? Icon(
                          Icons.visibility_off,
                          color: Color.fromARGB(255, 56, 56, 56),
                        )
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color.fromARGB(255, 120, 11, 192),
                        ),
                ),
                hintStyle: TextStyle(color: Color.fromARGB(255, 188, 188, 188)),
                filled: true,
                fillColor: Color.fromARGB(255, 242, 242, 242),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 50,
                child: regloding == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            regloding = true;
                          });
                          await signup(
                              email: _usernameController.text,
                              password: _passwordController.text,
                              name: _nameController.text,
                              regNo: _regNoController.text,
                              faculty: _facultyController.text,
                              batch: _batchController.text,
                              context: context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                              255, 120, 11, 192), // Background color
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 18),
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 30,
              right: 30,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 238, 238, 238),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('or',
                      style: TextStyle(color: Color.fromARGB(255, 59, 59, 59))),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 240, 240, 240),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Already have a account?",
                  style: TextStyle(color: Color.fromARGB(255, 59, 59, 59)),
                ),
                SizedBox(
                  width: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const login()));
                  },
                  radius: 20,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Color.fromARGB(255, 120, 11, 192),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    )));
  }

  Future<void> signup(
      {required String email,
      required String password,
      required String name, // Add other user details as required
      required String regNo,
      required String faculty,
      required String batch,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'name': name,
          'regNo': regNo,
          'faculty': faculty,
          'batch': batch,
          'profpic':
              'https://firebasestorage.googleapis.com/v0/b/quickhire.appspot.com/o/profile%20(1).png?alt=media&token=cfd921c2-2460-4292-9c8c-090b14ba2254',
          'payment': 'No',
          'booked_room': 'No',
          // Add other user details as required
        });
      }
      setState(() {
        regloding = false;
      });

      Fluttertoast.showToast(
        msg: 'User successfully registered',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('firstLaunch', false);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const dashboard()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      } else {
        setState(() {
          print('gfffffffffffffffffffff');
          regloding = false;
        });
        message = e.toString();
      }
      setState(() {
        regloding = false;
      });
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Color.fromARGB(134, 161, 0, 0),
        textColor: Color.fromARGB(255, 255, 255, 255),
        fontSize: 14.0,
      );
    } catch (e) {}
  }
}
