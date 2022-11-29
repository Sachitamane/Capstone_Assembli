// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      crn: json['crn'] as int,
      date: json['date'] as String,
      message: json['message'] as String,
      annID: json['annID'] as String?,
      recipient: json['recipient'] as String?,
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'crn': instance.crn,
      'date': instance.date,
      'message': instance.message,
      'annID': instance.annID,
      'recipient': instance.recipient,
    };
