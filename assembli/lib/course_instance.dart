//utilized for searchCourse function in student_courses_page.dart 
//example file, not in-use
//commented out


class Course{
  final int rnum;         //teacher rnum
  final int cid;          //courseid number "4366, 3354, ..."
  final int sect;         //section for course
  final String cname;     //course name/identifier
  final int crn;          //crn

  Course({
    required this.cid,
    this.cname = '',
    required this.crn,
    required this.rnum,
    required this.sect,
  });

  Map<String, dynamic> toJson() => {
    'cid': cid,
    'cname': cname,
    'crn': crn,
    'rnum': rnum,
    'sect': sect,
  };

  static Course fromJson(Map<String, dynamic> json) => Course(
    cid: json['cid'],
    cname: json['cname'],
    crn: json['crn'],
    rnum: json['rnum'],
    sect: json['sect'],
  );
}