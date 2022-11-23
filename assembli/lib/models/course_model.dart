//utilized for searchCourse function in student_courses_page.dart 
//example file, not in-use
//commented out
//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:json_annotation/json_annotation.dart';

//https://www.youtube.com/watch?v=GiKOfdoD6R8&list=PL4tcFRTiQTj2BeFQ0e97C0ZQAi8l-HOM4&index=15
part 'course_model.g.dart'; // <== applies when using other classes as variables w/in this class
 
@JsonSerializable(explicitToJson: true)
class Course{
  final int rnum;         //teacher rnum
  final int cid;          //courseid number "4366, 3354, ..."
  final int sect;         //section for course
  final String cname;     //course name/identifier
  final int crn;          //crn
  final List<int> roster;
  //look into data types for
  //startTime and endTime
  //fields/variables in database
  //carry them over into contructor below 
  //and 'fromJson' and 'toJson'

  Course({
    required this.cid,
    required this.cname,
    required this.crn,
    required this.rnum,
    required this.sect,
    required this.roster
    //startTime...
    //endTime...
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  String toString(){
    return "Course info \n\ncid: $cid\ncname: $cname\ncrn: $crn\nrnum: $rnum\nsect: $sect\nroster: $roster";
  }
/*
  //static Course fromJson(...        <= alt function signature
  factory Course.fromJson(Map<String, dynamic> json) {
    
    return Course(
      cid: json['cid'],
      cname: json['cname'],
      crn: json['crn'],
      rnum: json['rnum'],
      sect: json['sect'],
      roster: json['roster'],
      //startTime : json[],...
      //endTime : json[]...
    );
  }
  Map<String, dynamic> toJson() => {
    'cid': cid,
    'cname': cname,
    'crn': crn,
    'rnum': rnum,
    'sect': sect,
    //'startTime' : ...
    //'endTime' : ...
  };

*/
}