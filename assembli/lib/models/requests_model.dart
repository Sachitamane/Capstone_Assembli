import 'package:assembli/models/course_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:assembli/globals.dart' as globals;


part 'requests_model.g.dart';


@JsonSerializable(explicitToJson: true)
class Request {
  final int crn;    //use to create course object later w/ a function
  final String date;
  final String reason;
  final String status;
  final int rnum;
  String? reqID;      //documentID shortcut, set by control class

  Request({
    required this.crn,
    required this.date,
    required this.reason,
    required this.status,
    required this.rnum,
    this.reqID
  });

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  @override
  String toString(){
    return 'Request info \ndocumentID: $reqID\ncrn: $crn\ndate: $date\nreason: $reason\nstatus: $status\nrnum: $rnum\n';
  }
}
