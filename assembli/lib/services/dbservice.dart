import 'package:assembli/models/announcements_model.dart';
import 'package:assembli/models/attendance_model.dart';
import 'package:assembli/models/course_model.dart';
import 'package:assembli/models/requests_model.dart';
import 'package:assembli/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
///////////////////////////////////////////////////////////////////
import 'package:assembli/globals.dart' as globals;

class Control {
  final FirebaseFirestore _instance= FirebaseFirestore.instance;
  //variables with a question mark will be set by the methods below upon sign in with authenticatedUser
  User? authUser;// = FirebaseAuth.instance.currentUser;
  AppUser? user;
  List<Course> availCourses = [];     //all courses in the database in a list of course objects
  List<Attendance> attend = [];
  List<Request> reqs = [];
  List<Announcement> announces = [];

  Control({
    this.authUser,
    this.user,
  });
  
  ////////////////----METHODS-------------------------------------------------

  ///get methods query the database for overall list
  ///set method filter lists obtained by the get methods
  ///these methods can be used a refresh pairs within UI files

  //sets AppUser 'user' of this class
  Future<void> setUser(String uid) async {
    CollectionReference users = _instance.collection('Users');
    DocumentSnapshot docsnap = await users.doc(uid).get();
    
    var data = docsnap.data() as Map<String, dynamic>;
    AppUser result = AppUser.fromJson(data);
    
   // globals.runningUser = result;
    
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
    //debugPrint('getCourses results');
    //debugPrint(availCourses.toString());
  }
  
  //set schedule variable of AppUser 'user' (see user_model.dart for 'user' variables)
  //courses will come from the list of courses (course objects) 'availCourses' variable set in getCourses method
  void setSchedule(AppUser user) async{  //for appUser
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

  //getting all attendance records
  Future<void> getAttendanceRecords() async{
    
    CollectionReference attendance = _instance.collection('attendance<test>');
    QuerySnapshot snapshot = await attendance.get();
    
    var documents = snapshot.docs;
    //for each document in the list of documents via 'documents' var
    //gets all attendance documents
    documents.forEach((DocumentSnapshot element) {
      var tt = element.data() as Map<String,dynamic>;       //turn document into a map
      Attendance buffer = Attendance.fromJson(tt);
      attend.add(buffer);
    });
  }

  //Limiting attendance list to user status/type
  void setAttendance(AppUser user){

    //if user is a student, get attendance(documents) where student is listed (as rnum)
    if(user.type!.compareTo('student')==0){
      attend.retainWhere((attendance) => attendance.rnum == user.rnum);
      user.attends = attend; 
    }
    
    //if user is an instructor, get attendance(documents) where instructor is listed as teacher
    //(aka is the rnum var of that course object through crn)
    if(user.type!.compareTo('instructor')==0){
      attend.retainWhere((attendance) => user.schedule!.any((course) => course.crn == attendance.crn));
      user.attends = attend;    
    }

    //debugPrint('Attends list for ${user.type} #${user.rnum}>>>>>>>>>>>>>>>>>>>>>>');
    //debugPrint(user.attends.toString());
  }

  //getting all request records ; limited to instructor users
  Future<void> getRequests() async{
    CollectionReference requests = _instance.collection('requests<test>');
    QuerySnapshot snapshot = await requests.get();

    var documents = snapshot.docs;

    documents.forEach((DocumentSnapshot element) {
      var tt = element.data() as Map<String,dynamic>;
      Request buffer = Request.fromJson(tt);
      buffer.reqID = element.id;
      reqs.add(buffer);
    });

  }

  //when instructor accepts, send a temp announcement to student user, somehow attach announcement to student rnum
  setRequests(AppUser user) {
    if (user.type!.compareTo('instructor') == 0){
      reqs.retainWhere((request) => user.schedule!.any((course) => course.crn == request.crn));
      user.requests = reqs;
    }
    //no need to depict rules for an student, students have no where to see a list of requests on their UI
    //status changes of requests will be depicted as announcements for them
  }

  //instructor only
  //utilized by approve/deny buttons on instructor request page
  void updateRequest(Request req, String inp) {
    CollectionReference requests = _instance.collection('requests<test>');
    var documents = requests.doc(req.reqID);

    documents.update({'status' : inp});
  }

  //students only
  //createRequests//////////////////////////////////////////////////////////////////////////////


  Future<void> getAnnouncements() async{
    CollectionReference announcements = _instance.collection('announcements<test>');
    QuerySnapshot snapshot = await announcements.get();

    var documents = snapshot.docs;

    documents.forEach((DocumentSnapshot element) {
      var tt = element.data() as Map<String,dynamic>;
      Announcement buffer = Announcement.fromJson(tt);
      buffer.annID = element.id;
      announces.add(buffer);
    });
  }

  setAnnouncements(AppUser user) {
    if (user.type!.compareTo('student') == 0){
      announces.retainWhere((announcement) => user.schedule!.any((course) => course.crn == announcement.crn));
      user.announcements = announces;
    }

    //debugPrint(user.announcements.toString());
    //no need to depict rules for an instructor, instructors have no where to see a list of announcements on their UI

  }




  Future<bool> setProfile(User auth)async{
    bool temp =false;
    await setUser(authUser!.uid);
    await getCourses();
    setSchedule(user!);
    await getAttendanceRecords();
    setAttendance(user!);
    await getRequests();
    setRequests(user!);
    await getAnnouncements();
    setAnnouncements(user!);
    
    //updateRequest(user!.requests![0],'approved');

    globals.runningUser = user;
    if(globals.runningUser != null){
      temp = true;
    }    
    return temp;
  }

  
}
