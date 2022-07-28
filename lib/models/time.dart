import 'package:flutter/cupertino.dart';

final String timeTable = 'time';

class TimeFields{
  static final List<String> values = [
    id, email, createdTime
  ];

  static final String id = '_id';
  static final String email ='email';
  static final String createdTime ='createdTime';
}
class Time{
  final int id;
  final String email;
  final DateTime createdTime;

  const Time({
    this.id,
    @required this.email,
    @required this.createdTime,
  });



  Time copy ({
    int id,
    String email,
    DateTime createdTime,
  }) => Time(
    id: id ?? this.id,
    email: email ?? this.email,
    createdTime: createdTime ?? this.createdTime
  );

  static Time fromJson(Map<String, Object> json) => Time(
    id: json[TimeFields.id] as int,
    email: json[TimeFields.email] as String,
    createdTime: DateTime.parse(json[TimeFields.createdTime] as String)
  );

  Map<String, Object> toJson()=>{
    TimeFields.id: id,
    TimeFields.email: email,
    TimeFields.createdTime: createdTime.toIso8601String(),
  };
}
