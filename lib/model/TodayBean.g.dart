// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodayBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayBean _$TodayBeanFromJson(Map<String, dynamic> json) {
  return TodayBean(
      (json['category'] as List)?.map((e) => e as String)?.toList(),
      json['error'] as bool,
      json['results'] == null
          ? null
          : DailyDataBean.fromJson(json['results'] as Map<String, dynamic>));
}

Map<String, dynamic> _$TodayBeanToJson(TodayBean instance) => <String, dynamic>{
      'category': instance.category,
      'error': instance.error,
      'results': instance.results
    };
