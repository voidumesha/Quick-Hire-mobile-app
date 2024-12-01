import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickhire/adminDashboard.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool showpassword = true;

  void _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both username and password.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
        Fluttertoast.showToast(
          msg: "User successfully logged in",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Color.fromARGB(255, 185, 27, 27),
          textColor: Colors.white,
          fontSize: 14.0,
        );
      } else {
        _showErrorDialog('Invalid username or password.');
      }
    } catch (e) {
      _showErrorDialog('Error logging in: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Color.fromARGB(255, 185, 27, 27),
      textColor: Colors.white,
      fontSize: 14.0,
    );
    setState(() {
      _isLoading = false;
    });
  }

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
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/mainimg.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Compnay Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 49, 49, 49),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 70),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 242, 242, 242),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: TextField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _usernameController,
                    cursorColor: Color.fromARGB(255, 120, 11, 192),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline_outlined,
                        color: Color.fromARGB(255, 53, 53, 53),
                      ),
                      hintText: 'Admin',
                      labelText: "User Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 120, 11, 192),
                        fontWeight: FontWeight.w800,
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 188, 188, 188),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 242, 242, 242),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
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
                    color: Color.fromARGB(255, 242, 242, 242),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: TextField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _passwordController,
                    obscureText: showpassword,
                    cursorColor: Color.fromARGB(255, 120, 11, 192),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Color.fromARGB(255, 53, 53, 53),
                      ),
                      hintText: 'Password',
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showpassword = !showpassword;
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 120, 11, 192),
                        fontWeight: FontWeight.w800,
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 188, 188, 188),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 242, 242, 242),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 50,
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 120, 11, 192),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 120, 11, 192),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                padding: EdgeInsets.only(top: 55),
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "By continuing I agree to ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Terms of conditions ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 120, 11, 192),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "and ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Privacy of Policy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 120, 11, 192),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
