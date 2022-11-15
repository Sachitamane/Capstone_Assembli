// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:assembli/studentUI/student_course_home.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:assembli/instructorUI/instructor_course_home.dart';


/*
    For Students Log Attendance

*/

class LocationFinder extends StatefulWidget {
  const LocationFinder({super.key});

  @override
  State<LocationFinder> createState() => _LocationFinderState();
}

class _LocationFinderState extends State<LocationFinder> {  
  //for holding gps location of student
  var _latitude = "";
  var _longitude = "";
  //to hold difference between Intructor and Student Position
  var _difference = "";
  //to hold validness of student position
  bool _valid = false;
  //used as a checker to make sure _valid has been evaluated properly by _checkPosition()
  bool _cancheck = false;
  //hard coded positions of Instructor
  double instructorLatitude = 33.5855774;
  double instructorLongitude = -101.8737846; 


  //used to compare Instructors position and Students Position and check Students position validness
  //updates _valid and _cancheck boolean variables
  Future<void> _checkPosition() async {
    Position posStudent = await _determinePosition();
    setState(() {
      _difference = Geolocator.distanceBetween(posStudent.latitude,
              posStudent.longitude, instructorLatitude, instructorLongitude)
          .toString();
      //place to mess with proximity interval to make location valid closer to hard coded professors or farther away
      if ((double.parse(_difference) >= 0) &&
          (double.parse(_difference) <= 75)) {
        _valid = true;
      } else {
        _valid = false;
      }
      _cancheck = true;
    });
  }


  //used to update the _latitude and _longitude; Student GPS Location
  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
   // List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
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

  @override
  Widget build(BuildContext context) {
    _updatePosition();
    _checkPosition();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
              child: Column(
                children: <Widget>[
                    //empty container for aesthetics
                    SizedBox(
                        height: 50,
                          width: 250,
                      ),
                      Container(
                        height: 100,
                          width: 250,
                          decoration: BoxDecoration(
                                        border: Border.all(color: Color.fromARGB(255, 179, 194, 168)),
                                        borderRadius: BorderRadius.circular(20)
                                    ), 
                        child: Center( child: !_cancheck?
                                                  Text('Proximity Check: Pending', style: TextStyle(fontSize: 18)):
                                                  _valid?Text('Proximity Check: Valid', style: TextStyle(fontSize: 18,color: Colors.green)):
                                                              Text('Proximity Check: Invalid', style: TextStyle(fontSize: 18,color: Colors.red)),
                                                              
                                    )   
                      ),
                      Padding(
                            padding: EdgeInsets.all(30),
                            child: _cancheck? Column(
                                  children: <Widget> [
                                    const Text ('Classroom Location:',
                                    style:  TextStyle(fontSize:20),),
                                    Text('Latitude : ${instructorLatitude.toString()}',
                                        style: TextStyle(fontSize:20)),
                                    Text('Longitude : ${instructorLongitude.toString()}',
                                        style: TextStyle(fontSize:20)),
                                    const Text('Your Location:',
                                        style: TextStyle(fontSize:20)),
                                    Text('Latitude : $_latitude',
                                        style: TextStyle(fontSize:20)),
                                    Text('Longitude : $_longitude',
                                        style: TextStyle(fontSize:20)),
                                    Text('Difference : $_difference',
                                    style: TextStyle(fontSize:20)),
                                  ]):Center(child: CircularProgressIndicator()))
                        ,
                                  //if valid displays inputfield Widget to enter code and submit button to return to student course home
                                  //, if fails displays simple timer widget and returns to student course home page
                                  Padding(
                                    padding: EdgeInsets.all(30),
                                    child: SizedBox(
                                              height:200,
                                              width: 250,
                                              child: !_cancheck?
                                              SizedBox.shrink():
                                                    _valid?Column(children: <Widget>[ TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Enter Code'),), ElevatedButton(child:Text('Submit Code'),onPressed: () {Navigator.pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (BuildContext context) {
                                                                  return const StudentCourseHome(courseName: 'buffer', courseNumb: 1111);
                                                                },
                                                              ),
                                                              (route) => false,
                                                            );}), ]):
                                                            SimpleTimer(status: TimerStatus.start,duration: Duration(seconds: 10),onEnd: () => Navigator.pushAndRemoveUntil(
                                                            context,MaterialPageRoute(builder: (BuildContext context) {return const StudentCourseHome(courseName: 'buffer', courseNumb: 1111);},),(route) => false,), ),
                                              ),
                                    ),
                  ],
              )),
      )
    );
  }
}

/*
    For Professors open attendance

*/

class LocationSetter extends StatefulWidget {
  const LocationSetter({super.key});

  @override
  State<LocationSetter> createState() => _LocationSetterState();
}


class _LocationSetterState extends State<LocationSetter>{

  //for holding gps location of Instructor
  var _latitude = "";
  var _longitude = "";
  //for holding the geocoding of GPS Location
  var _address = "";
  //to check whether the button and info information can be displayed after GPS Pos for Instructor has been found
  bool _canConfirm = false;
  //to check whether the Instructor has confirmed location
  bool _confirmedLocation = false;


  //used to update _confirmedLocation to activate code inputfield
  Future<void> _instructorCodeActivation() async {
    setState(() {
        _confirmedLocation = true;
    });
  }

  //used to update the _latitude and _longitude; Instructor GPS Location
  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      _address= pm[0].toString();
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

    @override
  Widget build(BuildContext context) {
    _updatePosition();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
              child: Column(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(30),
                            child: 
                                const Text('Classroom Location: ',
                                style: TextStyle(fontSize: 20)),
                    ),
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: !_canConfirm?
                                Center(child: CircularProgressIndicator()):
                                Column(
                                  children: <Widget> [
                                    Text('Latitude $_latitude',
                                      style: TextStyle(fontSize:20)
                                    ),
                                    Text('Longitude $_longitude',
                                      style: TextStyle(fontSize:20)
                                    ),
                                  ]
                                ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget> [
                            Text(_address,
                              style: TextStyle(fontSize:15)
                            ),
                          ]
                        ),
                    ),
                    Padding(
                          padding: EdgeInsets.all(20),
                          child: !_canConfirm ? 
                                  SizedBox.shrink():
                                    !_confirmedLocation ? Column(children: <Widget>[ElevatedButton(
                                                                child:Text('Confirm Classroom Location'),onPressed: () 
                                                                {
                                                                  _instructorCodeActivation();
                                                                }
                                                            ), 
                                            ]
                                  ): Column(children:<Widget>[ TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Input Code Login')),
                                  ElevatedButton(onPressed: (){
                                              Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (BuildContext context) {
                                                                        return const InstructorCourseHome();
                                                                      },
                                                                    ),
                                                                    (route) => false
                                                                  ,);
                                  }, child:  const Text('Confirm Code',
          style: TextStyle(color: Colors.white, fontSize: 25)),)]),
              ),],
              )),
      )
    );
  }
}