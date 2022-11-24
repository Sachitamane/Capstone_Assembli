import 'package:assembli/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

//https://docs.flutter.dev/development/data-and-backend/json
//https://www.youtube.com/watch?v=GiKOfdoD6R8&list=PL4tcFRTiQTj2BeFQ0e97C0ZQAi8l-HOM4&index=15
part 'attendance_model.g.dart'; 
 
@JsonSerializable(explicitToJson: true)
class Attendance{
  final int rnum;
  final int crn;
  final DateTime date;
  final bool present;
  final bool excused;     //toggle setting values of this in db based on present bool settings

  Attendance({
    required this.rnum,
    required this.crn,
    required this.date,
    required this.present,
    required this.excused    
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceToJson(this);

  @override
  String toString(){
    return 'Attendance info \nrnum: $rnum\ncrn: $crn\ndate: $date\npresent: $present\nexcused: $excused\n';//"Course info \n\ncid: $cid\ncname: $cname\ncrn: $crn\nrnum: $rnum\nsect: $sect\nroster: $roster\n"; //startTime: $startTime\nendTime: $endTime";
  }

}