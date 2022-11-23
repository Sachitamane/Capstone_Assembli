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
  List<Course> availCourses=[];

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
  
  Future<void> setUser(String uid) async {
    CollectionReference users = _instance.collection('Users');
    DocumentSnapshot docsnap = await users.doc(uid).get();
    
    var data = docsnap.data() as Map<String, dynamic>;
    AppUser result = AppUser.fromJson(data);
    
    //set control's user field
    user = result; 
    debugPrint('AppUser set');   
  }

  Future<void> getCourses(AppUser user) async{
    //get the list of courses      
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
    if(user.type!.compareTo('student')==0){
      availCourses.retainWhere((course) => course.roster.contains(user.rnum));
      user.schedule = availCourses; 
      
    }
    if(user.type!.compareTo('instructor')==0){
      availCourses.retainWhere((course) => (course.rnum).compareTo(user.rnum!) == 0 );
      user.schedule = availCourses;    
    }    
  }
}

/*
  Future<bool> setProfile() async{
    bool achieved = false;
   // this.user = getUser(authenticatedUser!.uid);

    return achieved;
  }
*/
