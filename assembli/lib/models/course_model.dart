import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

//command for getting and building generated files
//enter in terminal :  " flutter packages pub run build_runner build "
//see youtube vid for clearer instructions
//https://docs.flutter.dev/development/data-and-backend/json
//https://www.youtube.com/watch?v=GiKOfdoD6R8&list=PL4tcFRTiQTj2BeFQ0e97C0ZQAi8l-HOM4&index=15
part 'course_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Course {
  final int rnum; //teacher rnum
  final int cid; //courseid number "4366, 3354, ..."
  final int sect; //section for course
  final String cname; //course name/identifier
  final int crn; //crn
  final List<int> roster;

  //final TimeOfDay startTime;        //JsonSerializable cannot take on TimeOfDay data type
  //w/o some work, so notifications targeting a time period
  //may not be possible atm
  //final TimeOfDay endTime;

  Course({
    required this.cid,
    required this.cname,
    required this.crn,
    required this.rnum,
    required this.sect,
    required this.roster,
    //required this.startTime,
    //required this.endTime
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  String toString() {
    return "Course info \n\ncid: $cid\ncname: $cname\ncrn: $crn\nrnum: $rnum\nsect: $sect\nroster: $roster\n"; //startTime: $startTime\nendTime: $endTime";
  }
}
