// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:assembli/instructorUI/instructor_course_home.dart';
import 'package:assembli/models/course_model.dart';

/*
    For Professors open attendance

*/

class LocationSetter extends StatefulWidget {
  final Course course;

  const LocationSetter({
    Key? key,
    required this.course,
  }) : super(key: key);
  @override
  State<LocationSetter> createState() => _LocationSetterState();
}

class _LocationSetterState extends State<LocationSetter> {
  // gps location of Instructor
  var _latitude = "";
  var _longitude = "";
  // geocoding of GPS Location
  List _address = [];
  // whether the button and info information can be displayed after GPS Pos for Instructor has been found
  bool _canConfirm = false;
  // whether the Instructor has confirmed location
  bool _confirmedLocation = false;
  // Collection Reference to DB
  CollectionReference classroom =
      FirebaseFirestore.instance.collection('CourseAuthFactors');
  // controller object to capture class code input
  final myController = TextEditingController();

  // Clean up the controller
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // updates _confirmedLocation to activate code inputfield
  Future<void> _instructorCodeActivation() async {
    setState(() {
      _confirmedLocation = true;
    });
  }

  // updates the _latitude and _longitude; Instructor GPS Location
  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    updateCoordinates(pos);
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      _address = pm[0].toString().split(',');
      _canConfirm = true;
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

  // updates the Coordinates in DB for classroom
  Future<void> updateCoordinates(Position instructorPosition) async {
    return classroom.doc(widget.course.crn.toString()).update({
      'coordinate':
          GeoPoint(instructorPosition.latitude, instructorPosition.longitude)
    });
  }

  // updates the class code in DB
  Future<void> updateCode(int code) async {
    return classroom.doc(widget.course.crn.toString()).update({'code': code});
  }

  @override
  Widget build(BuildContext context) {
    _updatePosition();
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
              Container(height: 50, width: 250),
              Padding(
                padding: EdgeInsets.all(30),
                child: const Text('Classroom Location ',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic)),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: !_canConfirm
                    ? Center(child: CircularProgressIndicator())
                    : Column(children: <Widget>[
                        Text('Latitude: $_latitude',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 179, 194, 168))),
                        Text('Longitude: $_longitude',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 179, 194, 168))),
                        Container(height: 50, width: 250),
                        Text(
                            _address[0] +
                                "\n" +
                                _address[1] +
                                "\n" +
                                _address[6] +
                                "\n" +
                                _address[5] +
                                "\n" +
                                _address[3],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ))
                      ]),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: !_canConfirm
                    ? SizedBox.shrink()
                    : !_confirmedLocation
                        ? Column(children: <Widget>[
                            ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color.fromARGB(255, 179, 194, 168))),
                              onPressed: () {
                                _instructorCodeActivation();
                              },
                              child: Text('Confirm Classroom Location',
                                  style: TextStyle(fontSize: 19)),
                            ),
                          ])
                        : Column(children: <Widget>[
                            TextField(
                              controller: myController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Input Code Login'),
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color.fromARGB(255, 179, 194, 168))),
                              onPressed: () => [
                                updateCode(int.parse(myController.text)),
                                Navigator.pop(context)
                              ],
                              child: const Text('Confirm Code',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25)),
                            )
                          ]),
              ),
            ],
          )),
        ));
  }
}
