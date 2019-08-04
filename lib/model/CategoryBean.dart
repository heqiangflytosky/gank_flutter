import 'package:json_annotation/json_annotation.dart';
import 'GankItemBean.dart';

part 'CategoryBean.g.dart';

@JsonSerializable()
class CategoryBean {
  bool error;
  List<GankItemBean> results;

  CategoryBean(this.error,this.results);

  factory CategoryBean.fromJson(Map<String, dynamic> json) => _$CategoryBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryBeanToJson(this);
}