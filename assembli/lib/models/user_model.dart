//manual model class, not serializable b/c control sets instances, not firestore directly
import 'package:assembli/models/attendance_model.dart';
import 'package:assembli/models/course_model.dart';
import 'package:assembli/models/requests_model.dart';

class AppUser {
  String? email;                
  int? rnum;                    
  String? type;                 
  String? fname;                
  String? lname;                
  List<Course>? schedule;       
  List<Attendance>? attends;    
  List<Request>? requests;


  AppUser(
    {
      this.email,               
      this.rnum,                
      this.type,                
      this.fname,               
      this.lname,               
      this.schedule,            
      this.attends              
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