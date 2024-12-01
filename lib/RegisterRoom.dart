import 'package:flutter/material.dart';
import 'package:quickhire/booking.dart';

class regroom extends StatefulWidget {
  const regroom({super.key});

  @override
  State<regroom> createState() => _regroomState();
}

bool menue1 = false;
bool menue2 = false;
bool menue3 = false;
String faculty = 'Faculty';
String batch = 'Batch';
String floor = "Floor";
bool isfaculty = false;
bool isbatch = false;
bool isfloor = false;

class _regroomState extends State<regroom> {
  @override
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
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications_none_sharp,
                              size: 30,
                            ), // this is the icon
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 120, 11, 192),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
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
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                          alignment: Alignment.center,
                          width: 180,
                          height: 130,
                          decoration: BoxDecoration(
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
          Text(
            "Register Room",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 23,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 49, 49, 49)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  menue1 = !menue1;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: isfaculty == false
                          ? Color.fromARGB(255, 120, 11, 192)
                          : Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          faculty,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              color: isfaculty == false
                                  ? Color.fromARGB(255, 49, 49, 49)
                                  : Colors.red),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        menue1
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down_circle_outlined,
                        color: isfaculty == false
                            ? Color.fromARGB(255, 120, 11, 192)
                            : Colors.red,
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
          menue1
              ? Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Faculty of Technology"),
                        onTap: () {
                          setState(() {
                            faculty = "Faculty of Technology";
                            menue1 = false;
                            isfaculty = false;
                          });
                        },
                      ),
                      ListTile(
                        title:
                            Text("Faculty of Social Sciences and Humanities"),
                        onTap: () {
                          setState(() {
                            faculty =
                                "Faculty of Social Sciences and Humanities";
                            menue1 = false;
                            isfaculty = false;
                          });
                        },
                      ),
                      ListTile(
                        title: Text(" Faculty of Management Studies"),
                        onTap: () {
                          setState(() {
                            faculty = " Faculty of Management Studies";
                            menue1 = false;
                            isfaculty = false;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Faculty of Agriculture "),
                        onTap: () {
                          setState(() {
                            faculty = "Faculty of Agriculture ";
                            menue1 = false;
                            isfaculty = false;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Faculty of Applied Sciences"),
                        onTap: () {
                          setState(() {
                            faculty = "Faculty of Applied Sciences";
                            menue1 = false;
                            isfaculty = false;
                          });
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  menue2 = !menue2;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: isbatch == false
                          ? Color.fromARGB(255, 120, 11, 192)
                          : Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        batch,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            color: isbatch == false
                                ? Color.fromARGB(255, 49, 49, 49)
                                : Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        menue2
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down_circle_outlined,
                        color: isbatch == false
                            ? Color.fromARGB(255, 120, 11, 192)
                            : Colors.red,
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
          menue2
              ? Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("18/19"),
                        onTap: () {
                          setState(() {
                            batch = "18/19";
                            menue2 = false;
                            isbatch = false;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("19/20"),
                        onTap: () {
                          setState(() {
                            batch = "19/20";
                            menue2 = false;
                            isbatch = false;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("20/21"),
                        onTap: () {
                          setState(() {
                            batch = "20/21";
                            menue2 = false;
                            isbatch = false;
                          });
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  menue3 = !menue3;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: isfloor == false
                          ? Color.fromARGB(255, 120, 11, 192)
                          : Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        floor,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            color: isfloor == false
                                ? Color.fromARGB(255, 49, 49, 49)
                                : Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        menue3
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down_circle_outlined,
                        color: isfloor == false
                            ? Color.fromARGB(255, 120, 11, 192)
                            : Colors.red,
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
          menue3
              ? Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("1st Floor"),
                        onTap: () {
                          setState(() {
                            floor = "1st Floor";
                            menue3 = false;
                            isfloor = false;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("2nd Floor"),
                        onTap: () {
                          setState(() {
                            floor = "2nd Floor";
                            menue3 = false;
                            isfloor = false;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("3rd Floor"),
                        onTap: () {
                          setState(() {
                            floor = "3rd Floor";
                            menue3 = false;
                            isfloor = false;
                          });
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(top: 60),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 242, 242, 242), // Background color
                        foregroundColor:
                            Color.fromARGB(255, 120, 11, 192), // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Container(
                    width: 110,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        if (faculty == 'Faculty' ||
                            batch == 'Batch' ||
                            floor == "Floor" ||
                            faculty == 'Select Faculty' ||
                            batch == 'Select Batch' ||
                            floor == 'Select Floor') {
                          if (faculty == "Faculty") {
                            setState(() {
                              isfaculty = true;
                              faculty = 'Select Faculty';
                            });
                          }
                          if (batch == 'Batch') {
                            setState(() {
                              isbatch = true;
                              batch = 'Select Batch';
                            });
                          }
                          if (floor == 'Floor') {
                            setState(() {
                              floor = 'Select Floor';
                              isfloor = true;
                            });
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => booking(
                                      floor: floor,
                                      faculty: faculty,
                                      baj: batch,
                                    )),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 120, 11, 192), // Background color
                        foregroundColor: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Search',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    )));
  }
}
