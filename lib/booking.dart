import 'dart:ffi';
import 'package:quickhire/RegisterRoom.dart';
import 'package:quickhire/payment.dart';

import 'firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class booking extends StatefulWidget {
  final String floor;
  final String faculty;
  final String baj;
  const booking(
      {super.key,
      required this.floor,
      required this.faculty,
      required this.baj});

  @override
  State<booking> createState() => _bookingState();
}

int index = 0;
String floor = "1st_Floor";
int selectroom = 100;
String myfaculty = "tech";
String mybatch = "19/20";
String roomid = 'sasa';
String avilablebed = '0';
String selectbatch = '18/19';
String selectedfaculty = 'tech';

class _bookingState extends State<booking> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    String fac = widget.faculty;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(255, 120, 11, 192),
                                  width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          width: 240,
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              widget.faculty,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 120, 11, 192),
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(255, 120, 11, 192),
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            height: 40,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                widget.baj,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 120, 11, 192),
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      index = 0;
                      floor = "1st_Floor";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: index == 0
                        ? const Color.fromARGB(255, 68, 5, 110)
                        : const Color.fromARGB(255, 120, 11, 192), // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Floor 01',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      index = 1;
                      floor = "2nd_Floor";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: index == 1
                        ? const Color.fromARGB(255, 68, 5, 110)
                        : const Color.fromARGB(255, 120, 11, 192), // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Floor 02',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      index = 2;
                      floor = "3rd_Floor";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: index == 2
                        ? const Color.fromARGB(255, 68, 5, 110)
                        : const Color.fromARGB(255, 120, 11, 192), // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Floor 03',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Select bed",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Poppins'),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: _firestoreService.getDocuments(
                  floor,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Data Found'));
                  } else {
                    final documents = snapshot.data!;
                    print(snapshot.data!);
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        childAspectRatio: 4 / 2, // Adjust as needed
                      ),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final fieldValue = document['Booked_beds'].toString();
                        final roomnum = document['Room_num'].toString();
                        final faculty = document['Faculty'].toString();
                        final Batch = document['Batch'].toString();

                        // Replace 'fieldName' with your field name

                        return (faculty == widget.faculty ||
                                    faculty == 'none') &&
                                (Batch == widget.baj || Batch == 'none') &&
                                fieldValue != '4'
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectroom = index;
                                      roomid = documents[index].id;
                                      avilablebed =
                                          document['Booked_beds'].toString();
                                      selectbatch = document['Batch'];
                                      selectedfaculty = document['Faculty'];
                                      print(fac);
                                      print(widget.baj);
                                      print(selectedfaculty);
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                          color: selectroom == index
                                              ? const Color.fromARGB(
                                                  255, 120, 11, 192)
                                              : Colors.transparent,
                                        )),
                                    height: 50,
                                    width: 200,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 40,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: selectroom != index
                                                  ? const Color.fromARGB(
                                                      255, 120, 11, 192)
                                                  : Colors.green,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                            child: Text(
                                              roomnum,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        fieldValue == '0'
                                            ? const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Icon(
                                                    Icons.bed,
                                                    size: 35,
                                                    color: Color.fromARGB(
                                                        255, 120, 11, 192),
                                                  ),
                                                  Icon(
                                                    Icons.bed,
                                                    size: 35,
                                                    color: Color.fromARGB(
                                                        255, 120, 11, 192),
                                                  ),
                                                  Icon(
                                                    Icons.bed,
                                                    size: 35,
                                                    color: Color.fromARGB(
                                                        255, 120, 11, 192),
                                                  ),
                                                  Icon(
                                                    Icons.bed,
                                                    size: 35,
                                                    color: Color.fromARGB(
                                                        255, 120, 11, 192),
                                                  )
                                                ],
                                              )
                                            : fieldValue == '1'
                                                ? const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                        Icons.bed_rounded,
                                                        size: 35,
                                                        color: Color
                                                            .fromARGB(
                                                            255, 243, 33, 33),
                                                      ),
                                                      Icon(
                                                        Icons.bed,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 120, 11, 192),
                                                      ),
                                                      Icon(
                                                        Icons.bed,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 120, 11, 192),
                                                      ),
                                                      Icon(
                                                        Icons.bed,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 120, 11, 192),
                                                      )
                                                    ],
                                                  )
                                                : fieldValue == '2'
                                                    ? const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Icon(
                                                            Icons.bed_rounded,
                                                            size: 35,
                                                            color: Color
                                                                .fromARGB(255,
                                                                243, 33, 33),
                                                          ),
                                                          Icon(
                                                            Icons.bed_rounded,
                                                            size: 35,
                                                            color: Color
                                                                .fromARGB(255,
                                                                243, 33, 33),
                                                          ),
                                                          Icon(
                                                            Icons.bed,
                                                            size: 35,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    120,
                                                                    11,
                                                                    192),
                                                          ),
                                                          Icon(
                                                            Icons.bed,
                                                            size: 35,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    120,
                                                                    11,
                                                                    192),
                                                          )
                                                        ],
                                                      )
                                                    : fieldValue == '3'
                                                        ? const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .bed_rounded,
                                                                size: 35,
                                                                color: Color
                                                                    .fromARGB(
                                                                    255,
                                                                    243,
                                                                    33,
                                                                    33),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .bed_rounded,
                                                                size: 35,
                                                                color: Color
                                                                    .fromARGB(
                                                                    255,
                                                                    243,
                                                                    33,
                                                                    33),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .bed_rounded,
                                                                size: 35,
                                                                color: Color
                                                                    .fromARGB(
                                                                    255,
                                                                    243,
                                                                    33,
                                                                    33),
                                                              ),
                                                              Icon(
                                                                Icons.bed,
                                                                size: 35,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        120,
                                                                        11,
                                                                        192),
                                                              )
                                                            ],
                                                          )
                                                        : fieldValue == '4'
                                                            ? const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .bed_rounded,
                                                                    size: 35,
                                                                    color: Color
                                                                        .fromARGB(
                                                                        255,
                                                                        243,
                                                                        33,
                                                                        33),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .bed_rounded,
                                                                    size: 35,
                                                                    color: Color
                                                                        .fromARGB(
                                                                        255,
                                                                        243,
                                                                        33,
                                                                        33),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .bed_rounded,
                                                                    size: 35,
                                                                    color: Color
                                                                        .fromARGB(
                                                                        255,
                                                                        243,
                                                                        33,
                                                                        33),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .bed_rounded,
                                                                    size: 35,
                                                                    color: Color
                                                                        .fromARGB(
                                                                        255,
                                                                        243,
                                                                        33,
                                                                        33),
                                                                  )
                                                                ],
                                                              )
                                                            : const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .bed_rounded,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            77,
                                                                            77,
                                                                            77),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .bed_rounded,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            56,
                                                                            56,
                                                                            56),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .bed_rounded,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            66,
                                                                            66,
                                                                            66),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .bed_rounded,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            68,
                                                                            68,
                                                                            68),
                                                                  )
                                                                ],
                                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                          color: selectroom == index
                                              ? const Color.fromARGB(255, 77, 77, 77)
                                              : Colors.transparent,
                                        )),
                                    height: 50,
                                    width: 200,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 40,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                            child: Text(
                                              roomnum,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Icons.bed,
                                              size: 35,
                                              color: Colors.grey,
                                            ),
                                            Icon(
                                              Icons.bed,
                                              size: 35,
                                              color: Colors.grey,
                                            ),
                                            Icon(
                                              Icons.bed,
                                              size: 35,
                                              color: Colors.grey,
                                            ),
                                            Icon(
                                              Icons.bed,
                                              size: 35,
                                              color: Colors.grey,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 242, 242, 242), // Background color
                  foregroundColor:
                      const Color.fromARGB(255, 120, 11, 192), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  selectroom != 100
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Payment(
                                    roomid: roomid,
                                    Baj: widget.baj,
                                    avlbed: int.parse(avilablebed),
                                    faculty: fac,
                                    floor: floor,
                                  )),
                        )
                      : null;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 120, 11, 192), // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Conform',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
