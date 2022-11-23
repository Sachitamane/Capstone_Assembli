// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      cid: json['cid'] as int,
      cname: json['cname'] as String,
      crn: json['crn'] as int,
      rnum: json['rnum'] as int,
      sect: json['sect'] as int,
      roster: (json['roster'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'rnum': instance.rnum,
      'cid': instance.cid,
      'sect': instance.sect,
      'cname': instance.cname,
      'crn': instance.crn,
      'roster': instance.roster,
    };
