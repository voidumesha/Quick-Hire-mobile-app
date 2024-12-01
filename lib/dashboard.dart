import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickhire/RegisterRoom.dart';
import 'package:quickhire/annuncement.dart';
import 'package:quickhire/booking.dart';
import 'package:quickhire/commentscreen.dart';
import 'package:quickhire/firebaseauthservice.dart';
import 'package:quickhire/payment.dart';
import 'package:quickhire/payment2.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDataStream() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots();
    } else {
      return Stream.empty(); // Return an empty stream when no user is signed in
    }
  }

  @override
  String paymenta = 'null';
  String bookedroom = 'No';
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: getUserDataStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.hasData && snapshot.data!.exists) {
                        Map<String, dynamic>? data = snapshot.data!.data();
                        return Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/User.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: 200,
                                              height: 50,
                                              child: Text(
                                                "Hello, ${data?['name']}! ",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w800,
                                                  color: Color.fromARGB(
                                                      255, 52, 52, 52),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Stack(
                                          children: [
                                            IconButton(
                                              alignment: Alignment.topCenter,
                                              icon:
                                                  Icon(Icons.logout, size: 25),
                                              onPressed: () async {
                                                await AuthService()
                                                    .signout(context: context);
                                              },
                                            ), // this is the icon
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 250,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/mainimg.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Student dashboard",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(255, 49, 49, 49)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 70),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AnnouncementPage()),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        splashColor:
                                            Color.fromARGB(255, 199, 199, 199),
                                        child: Column(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/megaphone.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            Container(
                                              width: 100,
                                              child: Text(
                                                "View              Jobs in Pure",
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Color.fromARGB(
                                                        255, 52, 52, 52)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatScreen(
                                                      recipientUid:
                                                          data!['uid'],
                                                    )),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        splashColor:
                                            Color.fromARGB(255, 199, 199, 199),
                                        child: Column(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/chat (1).png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            Container(
                                                width: 100,
                                                child: Text(
                                                  "Add Comment",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.fade,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Color.fromARGB(
                                                          255, 52, 52, 52)),
                                                ))
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Payment2()),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        splashColor:
                                            Color.fromARGB(255, 199, 199, 199),
                                        child: Column(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/cloud-computing (1).png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            Container(
                                                width: 100,
                                                child: Text(
                                                  "Upoload your CV",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.fade,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Color.fromARGB(
                                                          255, 52, 52, 52)),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            if (data?['booked_room'] == 'yes')
                              if (data?['payment'] == 'No')
                                Positioned(
                                  top: 220,
                                  left: 50,
                                  right: 50,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 55,
                                    color:
                                        const Color.fromARGB(48, 244, 67, 54),
                                    child: const Text(
                                      "Please upload your CV.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.red),
                                    ),
                                  ),
                                ),
                          ],
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Hello, Student! ",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 52, 52, 52),
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
