import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TotalBookedBeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Analytics Live Dashboard',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 52, 52, 52),
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('1st_Floor')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  int totalBookedBeds1stFloor = 0;
                  int documentCount1stFloor = snapshot.data!.docs.length;
                  int bedcapacity = snapshot.data!.docs.length * 4;

                  snapshot.data!.docs.forEach((doc) {
                    totalBookedBeds1stFloor += (doc['Booked_beds'] ?? 0) as int;
                  });
                  int avilablebedsist = bedcapacity - totalBookedBeds1stFloor;
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 120, 11, 192)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Hostel Insight - 1st Floor',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 120, 11, 192),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.reduce_capacity,
                                        size: 30,
                                      ),
                                      Text(
                                        'Bed Capacity',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$bedcapacity',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 153, 255)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.mobile_friendly,
                                        size: 30,
                                      ),
                                      Text(
                                        'Reserved Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$totalBookedBeds1stFloor',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 126, 0, 0)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.bedroom_child_outlined,
                                        size: 30,
                                      ),
                                      Text(
                                        'Available Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$avilablebedsist',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 40),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('2nd_Floor')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  int totalBookedBeds2ndFloor = 0;
                  int documentCount2ndFloor = snapshot.data!.docs.length;
                  int ndbedcap = documentCount2ndFloor * 4;

                  snapshot.data!.docs.forEach((doc) =>
                      totalBookedBeds2ndFloor +=
                          (doc['Booked_beds'] ?? 0) as int);
                  int avilablebeds2nd = ndbedcap - totalBookedBeds2ndFloor;
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 120, 11, 192)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Hostel Insight - 2nd Floor',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 120, 11, 192),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.reduce_capacity,
                                        size: 30,
                                      ),
                                      Text(
                                        'Bed Capacity',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$ndbedcap',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 153, 255)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.mobile_friendly,
                                        size: 30,
                                      ),
                                      Text(
                                        'Reserved Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$totalBookedBeds2ndFloor',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 126, 0, 0)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.bedroom_child_outlined,
                                        size: 30,
                                      ),
                                      Text(
                                        'Available Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$avilablebeds2nd',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 40),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('3rd_Floor')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  int totalBookedBeds3rdFloor = 0;
                  int documentCount3rdFloor = snapshot.data!.docs.length;
                  int totalbed3rd = documentCount3rdFloor * 4;

                  snapshot.data!.docs.forEach((doc) {
                    totalBookedBeds3rdFloor += (doc['Booked_beds'] ?? 0) as int;
                  });
                  int avilblebed3 = totalbed3rd - totalBookedBeds3rdFloor;
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 120, 11, 192)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Hostel Insight - 3rd Floor',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 120, 11, 192),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.reduce_capacity,
                                        size: 30,
                                      ),
                                      Text(
                                        'Bed Capacity',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$totalbed3rd',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 153, 255)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.mobile_friendly,
                                        size: 30,
                                      ),
                                      Text(
                                        'Reserved Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$totalBookedBeds3rdFloor',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 126, 0, 0)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.bedroom_child_outlined,
                                        size: 30,
                                      ),
                                      Text(
                                        'Available Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$avilblebed3',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
