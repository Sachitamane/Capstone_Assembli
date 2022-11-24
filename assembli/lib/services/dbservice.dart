import 'package:assembli/models/attendance_model.dart';
import 'package:assembli/models/course_model.dart';
import 'package:assembli/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Control {
  final FirebaseFirestore _instance= FirebaseFirestore.instance;
  //variables with a question mark will be set by the methods below upon sign in with authenticatedUser
  User? authUser;// = FirebaseAuth.instance.currentUser;
  AppUser? user;
  List<Course> availCourses=[];     //all courses in the database in a list of course objects
  List<Attendance> attend = [];
  //used for testing
  /*
  AppUser test = AppUser(
    email: 'kimberly.fisher@ttu.edu',
    rnum: 87654321,
    type: 'student'
  );
*/
  Control({
    this.authUser,
    this.user,
  });
  
  ////////METHODS-------------------------------------------------

  //sets AppUser 'user' of this class
  Future<void> setUser(String uid) async {
    CollectionReference users = _instance.collection('Users');
    DocumentSnapshot docsnap = await users.doc(uid).get();
    
    var data = docsnap.data() as Map<String, dynamic>;
    AppUser result = AppUser.fromJson(data);
    
    user = result; 
    //debugPrint('AppUser set');   
  }
  
  
  //get the list of courses from db    
  Future<void> getCourses() async{
    CollectionReference courses = _instance.collection('courses<test>');
    QuerySnapshot snapshot = await courses.get();     //get list of documents in course collection

    var documents = snapshot.docs;
    //for each document in the list of documents via 'documents' var
    documents.forEach((DocumentSnapshot element) {
      var tt = element.data() as Map<String,dynamic>;       //turn document into a map
      Course buffer = Course.fromJson(tt);
      availCourses.add(buffer);
    });
    debugPrint('getCourses results');
    debugPrint(availCourses.toString());
  }

  //set schedule variable of AppUser 'user' (see user_model.dart for 'user' variables)
  //courses will come from the list of courses (course objects) 'availCourses' variable set in getCourses method
  void setSchedule(AppUser user) async{  //for appUser
//testers 
/*    await getCourses(AppUser(
    email: 'dana.allen@ttu.edu',
    rnum: 12345678,
    type: 'instructor'
      ));
    
    /*
    await getCourses(AppUser(email: 'kimberly.fisher@ttu.edu',
    rnum: 87654321,
    type: 'student'
      ));
     */ 
*/
    
    //if user is a student, get courses(documents) where student is listed in the course roster
    if(user.type!.compareTo('student')==0){
      availCourses.retainWhere((course) => course.roster.contains(user.rnum));
      user.schedule = availCourses; 
      
    }
    //if user is an instructor, get courses(documents) where instructor is listed as teacher 
    //(aka is the rnum var of that course object)
    if(user.type!.compareTo('instructor')==0){
      availCourses.retainWhere((course) => (course.rnum).compareTo(user.rnum!) == 0 );
      user.schedule = availCourses;    
    }    
  }

  Future<void> getAttendanceRecords(AppUser user) async{
    //limiting the request to records only pertaining to the current user, thus the user is needed
    CollectionReference attendance = _instance.collection('attendance<test>');
    QuerySnapshot snapshot = await attendance.where('rnum', isEqualTo: user.rnum!).get();

    var documents = snapshot.docs;
    //for each document in the list of documents via 'documents' var
    documents.forEach((DocumentSnapshot element) {
      var tt = element.data() as Map<String,dynamic>;       //turn document into a map
      Attendance buffer = Attendance.fromJson(tt);
      attend.add(buffer);
    });
    debugPrint('attendance results');
    debugPrint(attend.toString());
    
  }
}

 












/*//////////////////////////////////////////////////////////////////////////
  Future<bool> setProfile() async{
    bool achieved = false;
   // await getUser(authenticatedUser!.uid);

    return achieved;
  }
*/

/*
  Future<String> getType(String uid) async {
    //_instance = FirebaseFirestore.instance;
    String type='';
    CollectionReference users = _instance.collection('Users');
    
    await users.doc(uid).get().then((DocumentSnapshot docsnap) {
        type = docsnap.get('type');
      });
      //debugPrint('temp equals $type in getType method');
    return type;
  }
*/