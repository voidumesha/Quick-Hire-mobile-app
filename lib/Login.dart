import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickhire/ForgotPasswordPage.dart';
import 'package:quickhire/RegisterPage.dart';
import 'package:quickhire/adminlog.dart';
import 'package:quickhire/dashboard.dart';
import 'package:quickhire/firebaseauthservice.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

bool? isChecked = false;
bool showpassword = true;
bool isloging = false;

class _loginState extends State<login> {
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
                SizedBox(
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
              ],
            ),
          ),
          const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 49, 49, 49)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 70),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 242, 242, 242),
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: TextField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: _usernameController,
                cursorColor: const Color.fromARGB(255, 120, 11, 192),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail_outline_outlined,
                    color: Color.fromARGB(255, 53, 53, 53),
                  ),
                  hintText: 'voidumesha@gmail.com',
                  labelText: "User Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 120, 11, 192),
                      fontWeight: FontWeight.w800),
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 188, 188, 188)),
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 242, 242, 242),
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: TextField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: _passwordController,
                obscureText: showpassword,
                cursorColor: const Color.fromARGB(255, 120, 11, 192),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color.fromARGB(255, 53, 53, 53),
                  ),
                  hintText: 'Password',
                  labelText: "Password",
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
                        ? const Icon(
                            Icons.visibility_off,
                            color: Color.fromARGB(255, 56, 56, 56),
                          )
                        : const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color.fromARGB(255, 120, 11, 192),
                          ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 120, 11, 192),
                      fontWeight: FontWeight.w800),
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 188, 188, 188)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 242, 242, 242),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Checkbox(
                      tristate: false,
                      value: isChecked,
                      activeColor: const Color.fromARGB(255, 120, 11, 192),
                      onChanged: (values) {
                        setState(() {
                          isChecked = values;
                        });
                      },
                    ),
                    Container(child: const Text("Remember Me")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()),
                    );
                  },
                  child: const Text(
                    "Froget password?",
                    style: TextStyle(
                        color: Color.fromARGB(255, 120, 11, 192),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: 50,
                child: isloging == true
                    ? Container(
                        width: 10,
                        height: 20,
                        color: const Color.fromARGB(0, 244, 67, 54),
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 120, 11, 192),
                        )),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isloging = true;
                          });
                          await signin(
                              email: _usernameController.text,
                              password: _passwordController.text,
                              context: context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 120, 11, 192), // Background color
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 18),
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Not Registed?",
                    style: TextStyle(color: Color.fromARGB(255, 59, 59, 59)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Register()),
                      );
                    },
                    radius: 20,
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                          color: Color.fromARGB(255, 120, 11, 192),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Logged in as an'),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminLoginPage()),
                      );
                    },
                    child: const Text(
                      " Company?",
                      style: TextStyle(
                          color: Color.fromARGB(255, 120, 11, 192),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 60,
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                      text: "By continuing I agree to ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: "Terms of conditions ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 120, 11, 192),
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "and ", style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "Privacy of Policy",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 120, 11, 192))),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    )));
  }

  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
        msg: 'User successfully logged in',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      setState(() {
        isloging = false;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('firstLaunch', false);
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const dashboard()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      } else {
        message = e.toString();
      }
      setState(() {
        isloging = false;
      });
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: const Color.fromARGB(134, 161, 0, 0),
        textColor: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 14.0,
      );
    }
  }
}
