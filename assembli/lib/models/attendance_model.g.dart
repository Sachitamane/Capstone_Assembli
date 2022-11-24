// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      rnum: json['rnum'] as int,
      crn: json['crn'] as int,
      date: DateTime.parse(json['date'] as String),
      present: json['present'] as bool,
      excused: json['excused'] as bool,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'rnum': instance.rnum,
      'crn': instance.crn,
      'date': instance.date.toIso8601String(),
      'present': instance.present,
      'excused': instance.excused,
    };
