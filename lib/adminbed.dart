import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TotalBookedBeds extends StatelessWidget {
  const TotalBookedBeds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hostel Analytics Live Dashboard',
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
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('1st_Floor')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  int totalBookedBeds1stFloor = 0;
                  int documentCount1stFloor = snapshot.data!.docs.length;
                  int bedcapacity = snapshot.data!.docs.length * 4;

                  for (var doc in snapshot.data!.docs) {
                    totalBookedBeds1stFloor += (doc['Booked_beds'] ?? 0) as int;
                  }
                  int avilablebedsist = bedcapacity - totalBookedBeds1stFloor;
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 120, 11, 192)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
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
                                      const Icon(
                                        Icons.reduce_capacity,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Bed Capacity',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$bedcapacity',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 153, 255)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.mobile_friendly,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Reserved Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$totalBookedBeds1stFloor',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 126, 0, 0)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.bedroom_child_outlined,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Available Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$avilablebedsist',
                                        style: const TextStyle(
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
              const SizedBox(height: 40),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('2nd_Floor')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  int totalBookedBeds2ndFloor = 0;
                  int documentCount2ndFloor = snapshot.data!.docs.length;
                  int ndbedcap = documentCount2ndFloor * 4;

                  for (var doc in snapshot.data!.docs) {
                    totalBookedBeds2ndFloor +=
                          (doc['Booked_beds'] ?? 0) as int;
                  }
                  int avilablebeds2nd = ndbedcap - totalBookedBeds2ndFloor;
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 120, 11, 192)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
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
                                      const Icon(
                                        Icons.reduce_capacity,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Bed Capacity',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$ndbedcap',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 153, 255)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.mobile_friendly,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Reserved Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$totalBookedBeds2ndFloor',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 126, 0, 0)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.bedroom_child_outlined,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Available Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$avilablebeds2nd',
                                        style: const TextStyle(
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
              const SizedBox(height: 40),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('3rd_Floor')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  int totalBookedBeds3rdFloor = 0;
                  int documentCount3rdFloor = snapshot.data!.docs.length;
                  int totalbed3rd = documentCount3rdFloor * 4;

                  for (var doc in snapshot.data!.docs) {
                    totalBookedBeds3rdFloor += (doc['Booked_beds'] ?? 0) as int;
                  }
                  int avilblebed3 = totalbed3rd - totalBookedBeds3rdFloor;
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 120, 11, 192)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
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
                                      const Icon(
                                        Icons.reduce_capacity,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Bed Capacity',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$totalbed3rd',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 153, 255)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.mobile_friendly,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Reserved Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$totalBookedBeds3rdFloor',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 126, 0, 0)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.bedroom_child_outlined,
                                        size: 30,
                                      ),
                                      const Text(
                                        'Available Beds',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        '$avilblebed3',
                                        style: const TextStyle(
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
                      const SizedBox(
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
