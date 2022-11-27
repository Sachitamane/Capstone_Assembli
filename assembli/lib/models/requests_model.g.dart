// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      crn: json['crn'] as int,
      date: DateTime.parse(json['date'] as String),
      reason: json['reason'] as String,
      status: json['status'] as String,
      rnum: json['rnum'] as int,
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'crn': instance.crn,
      'date': instance.date.toIso8601String(),
      'reason': instance.reason,
      'status': instance.status,
      'rnum': instance.rnum,
    };
