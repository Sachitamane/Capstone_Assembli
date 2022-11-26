//manual model class, not serializable b/c control sets instances, not firestore directly
import 'package:assembli/models/attendance_model.dart';
import 'package:assembli/models/course_model.dart';

class AppUser {
  String? email;                ///////////////////////// this is set by the db upon signin
  int? rnum;                    ///////////////////////// this is set by the db upon signin
  String? type;                 ///////////////////////// this is set by the db upon signin
  String? fname;                ///////////////////////// this is set by the db upon signin
  String? lname;                ///////////////////////// this is set by the db upon signin
  List<Course>? schedule;       ///////////////////////// this is set by the control class upon signin
  List<Attendance>? attends;    ///////////////////////// this is set by the control class upon signin
  


  AppUser(
    {
      this.email,               ///////////////////////// this is set by the db upon signin
      this.rnum,                ///////////////////////// this is set by the db upon signin
      this.type,                ///////////////////////// this is set by the db upon signin
      this.fname,               ///////////////////////// this is set by the db upon signin
      this.lname,               ///////////////////////// this is set by the db upon signin
      this.schedule,            ///////////////////////// this is set by the control class upon signin
      this.attends              ///////////////////////// this is set by the control class upon signin
    }
  );

  factory AppUser.fromJson(Map<String, dynamic> json) =>
  AppUser(
    email: json['email'],
    rnum: json['rnum'],
    type: json['type'],
    fname: json['fname'],
    lname: json['lname']
  );
  //our application doesn't do writing but we'll have this func anyways
  Map<String, dynamic> toJson() => {
    'email': email,
    'rnum': rnum,
    'type': type,
    'fname': fname,
    'lname': lname
  };

  @override
  String toString(){
    return "Current User\nfname: $fname\nlname: $lname\nemail: $email\nrnum: $rnum\ntype: $type\n schedule: $schedule";
  }
  
}