// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:assembli/studentUI/student_course_home.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:assembli/models/course_model.dart';
import 'package:assembli/globals.dart' as globals;

/*
    For Students Log Attendance

*/

class LocationFinder extends StatefulWidget {
  final Course course;

  const LocationFinder({
    Key? key,
    required this.course,
  }) : super(key: key);
  @override
  State<LocationFinder> createState() => _LocationFinderState();
}

class _LocationFinderState extends State<LocationFinder> {
  // gps location of student
  var _latitude = "";
  var _longitude = "";
  // difference between Classroom and Student Coords
  var _difference = "";
  // validness of student position
  bool _valid = false;
  // checker to make sure _valid has been evaluated properly by _checkPosition()
  bool _cancheck = false;
  //datbase pull has occured
  bool DBdone = false;
  // geopoint for classroom in DB
  GeoPoint classroomCoordinates = GeoPoint(0, 0);
  // code for classroom in DB
  int classroomCode = 0;
  // obtains classroom code input
  final myController = TextEditingController();
  late bool classOpen = false;
  // reference to collection in DB
  //edit Dylan Lowman
  CollectionReference classroom =
      FirebaseFirestore.instance.collection('CourseAuthFactors');
  CollectionReference attendance =
      FirebaseFirestore.instance.collection('Attendance');

  // Clean up the controller
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // compares Classroom and Students Coords and check Students Coords validness
  // updates _valid and _cancheck boolean variables
  Future<void> _checkPosition() async {
    Position posStudent = await _determinePosition();
    setState(() {
      _difference = Geolocator.distanceBetween(
              posStudent.latitude,
              posStudent.longitude,
              classroomCoordinates.latitude,
              classroomCoordinates.longitude)
          .toString();
      // proximity interval to make location valid closer or farther
      if ((double.parse(_difference) >= 0) &&
          (double.parse(_difference) <= 75)) {
        _valid = true;
      } else {
        _valid = false;
      }
      _cancheck = true;
    });
  }

  // updates the _latitude and _longitude; Student Coords
  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // updates the present status of student in DB
  Future<void> updateUserPresent() async {
    //hardcoded need to fix once data has been confirmed
    return attendance
        .doc(globals.authUser!.uid.toString())
        .update({'coursePresence.${widget.course.crn}': true});
  }

  // checks classroom code to student code input
  bool checkCode(int classroomCode, String studentCode) {
    if (int.parse(studentCode) == classroomCode) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _updatePosition();
    _checkPosition();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 179, 194, 168),
          title: Text('Assembli'),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              FutureBuilder<DocumentSnapshot>(
                  future: classroom.doc(widget.course.crn.toString()).get(),
                  builder: ((BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print("error!");
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      print("data exists");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic>? data =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      classroomCoordinates = data?['coordinate'];
                      classroomCode = data?['code'];
                      classOpen = data?['open'];
                      DBdone = true;
                    }
                    return Container();
                  })),
              //empty container for aesthetics
              Container(
                  height: 100,
                  width: 250,
                  child: Center(
                    child: Text("Location Check",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic)),
                  )),
              classOpen ?
              Container(
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 179, 194, 168), width: 7),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: !_cancheck
                        ? Text('Proximity Check: Pending',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w900))
                        : _valid
                            ? Text('Proximity Check: Valid',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: const Color.fromARGB(
                                        255, 179, 194, 168)))
                            : Text('Proximity Check: Invalid',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.red)),
                  )): 
                    DBdone ?
                    Column(children: <Widget>[
                    Container(child: Text("The Instructor has not yet opened class attendance yet ...",
                    style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900)),),
                    Container(height:100,width:250),
                     Container(width: 250,height: 200,
                      child: SimpleTimer(
                              status: TimerStatus.start,
                              duration: Duration(seconds: 5),
                              onEnd: () => Navigator.pop(
                                context,
                              ),
                            ),),
                  ],): Container(),

              classOpen ?
              Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(30),
                  child: _cancheck
                      ? Column(children: <Widget>[
                          const Text(
                            'Classroom Location',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900),
                          ),
                          Text(
                              'Latitude : ${classroomCoordinates.latitude.toString()}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: const Color.fromARGB(
                                      255, 179, 194, 168))),
                          Text(
                              'Longitude : ${classroomCoordinates.longitude.toString()}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: const Color.fromARGB(
                                      255, 179, 194, 168))),
                          const Text('Your Location',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w900)),
                          Text('Latitude : $_latitude',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: const Color.fromARGB(
                                      255, 179, 194, 168))),
                          Text('Longitude : $_longitude',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: const Color.fromARGB(
                                      255, 179, 194, 168))),
                          Text('Difference',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w900)),
                          _valid
                              ? Text('$_difference',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: const Color.fromARGB(
                                          255, 179, 194, 168)))
                              : Text('$_difference',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.red))
                        ])
                      : Center(child: CircularProgressIndicator())),
              //if valid displays inputfield Widget to enter code and submit button to return to student course home
              //, if fails displays simple timer widget and returns to student course home page
              Padding(
                padding: EdgeInsets.all(30),
                child: Container(
                  height: 200,
                  width: 250,
                  child: !_cancheck
                      ? SizedBox.shrink()
                      : _valid
                          ? Column(children: <Widget>[
                              TextField(
                                controller: myController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Code'),
                              ),
                              Center(
                                  child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<
                                            Color>(
                                        Color.fromARGB(255, 179, 194, 168))),
                                onPressed: () => {
                                  checkCode(classroomCode, myController.text)
                                      ? {
                                          updateUserPresent(),
                                          Navigator.pop(
                                            context,
                                          )
                                        }
                                      : showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text("Incorrect Code"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                          barrierDismissible: false,
                                        )
                                },
                                child: Text("Submit Code",
                                    style: TextStyle(fontSize: 30)),
                              )),
                            ])
                          : SimpleTimer(
                              status: TimerStatus.start,
                              duration: Duration(seconds: 5),
                              onEnd: () => Navigator.pop(
                                context,
                              ),
                            ),
                ),
              )]):Container()
            ],
          )),
        ));
  }
}