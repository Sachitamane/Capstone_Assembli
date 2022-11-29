import 'package:json_annotation/json_annotation.dart';

//https://docs.flutter.dev/development/data-and-backend/json
part 'announcements_model.g.dart'; 
 
@JsonSerializable(explicitToJson: true)
class Announcement{
  final int crn;
  final String date;
  final String message;
  String? annID;
  String? recipient;

  Announcement({
    required this.crn,
    required this.date,
    required this.message,
    this.annID,
    this.recipient
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  @override
  String toString(){
    return 'Announcement info \ncrn: $crn\ndate: $date\n';
  }

}