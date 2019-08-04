// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryBean _$CategoryBeanFromJson(Map<String, dynamic> json) {
  return CategoryBean(
      json['error'] as bool,
      (json['results'] as List)
          ?.map((e) => e == null
              ? null
              : GankItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CategoryBeanToJson(CategoryBean instance) =>
    <String, dynamic>{'error': instance.error, 'results': instance.results};
