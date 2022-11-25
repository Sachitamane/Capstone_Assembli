//manual model class, not serializable b/c control sets instances, not firestore directly
import 'package:assembli/models/course_model.dart';

class AppUser {
  String? email;
  int? rnum;
  String? type;
  String? fname;
  String? lname;
  List<Course>? schedule;   ///////////////////////// this is set by the control class upon signin
  //List<course_model.dart>? schedule
  //attendance record??? <=== maybe create this field within the course model


  AppUser(
    {
      this.email,
      this.rnum,
      this.type,
      this.fname,
      this.lname,
      this.schedule         ///////////////////////// this is set by the control class upon signin
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