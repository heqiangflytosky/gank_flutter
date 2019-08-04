// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailyDataBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyDataBean _$DailyDataBeanFromJson(Map<String, dynamic> json) {
  return DailyDataBean(
      (json['Android'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['App'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['iOS'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['休息视频'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['前端'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['拓展资源'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['瞎推荐'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['福利'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DailyDataBeanToJson(DailyDataBean instance) =>
    <String, dynamic>{
      'Android': instance.androidDataList,
      'iOS': instance.iosGDataList,
      '前端': instance.webDataList,
      'App': instance.appDataList,
      '福利': instance.benefitDataList,
      '休息视频': instance.restVideoDataList,
      '拓展资源': instance.expandResDataList,
      '瞎推荐': instance.recommendDataList
    };
