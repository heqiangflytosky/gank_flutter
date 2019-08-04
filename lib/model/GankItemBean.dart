import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'GankItemBean.g.dart';

@JsonSerializable()
class GankItemBean{
  @JsonKey(name: '_id')
  final String id;
  final String createdAt;
  final String desc;
  final String publishedAt;
  final String source;
  final String type;
  final String url;
  final bool used;
  final String who;

  GankItemBean(this.id,this.createdAt,this.desc,this.publishedAt,this.source,this.type,this.url,this.used,this.who);

//  static GankItemBean fromJson(Map<String, dynamic> json) {
//    return new GankItemBean(json["_id"], json["createdAt"], json["desc"], json["publishedAt"], json["source"], json["type"], json["url"], json["used"], json["who"]);
//  }
  factory GankItemBean.fromJson(Map<String, dynamic> json) => _$GankItemBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GankItemBeanToJson(this);

}