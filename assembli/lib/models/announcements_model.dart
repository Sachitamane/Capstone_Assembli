import 'package:json_annotation/json_annotation.dart';

//https://docs.flutter.dev/development/data-and-backend/json
//https://www.youtube.com/watch?v=GiKOfdoD6R8&list=PL4tcFRTiQTj2BeFQ0e97C0ZQAi8l-HOM4&index=15
//part 'announcements_model.g.dart'; 
 
@JsonSerializable(explicitToJson: true)
class Announcement{
  final int rnum;
  final int crn;
  final DateTime date;
  final bool present;
  final bool excused;     //toggle setting values of this in db based on present bool settings

  Announcement({
    required this.rnum,
    required this.crn,
    required this.date,
    required this.present,
    required this.excused,
  });

//  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

//  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  @override
  String toString(){
    return 'Announcement info \nrnum: $rnum\ncrn: $crn\ndate: $date\npresent: $present\nexcused: $excused\n';
  }

}