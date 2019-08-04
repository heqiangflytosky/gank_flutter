import 'package:json_annotation/json_annotation.dart';
import 'DailyDataBean.dart';
import 'dart:convert';

part 'TodayBean.g.dart';

@JsonSerializable()
class TodayBean {
  List<String> category;
  bool error;
  DailyDataBean results;

  TodayBean(this.category,this.error,this.results);

  factory TodayBean.fromJson(Map<String, dynamic> json) => _$TodayBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TodayBeanToJson(this);
}