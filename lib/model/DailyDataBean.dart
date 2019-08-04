import 'package:json_annotation/json_annotation.dart';
import 'GankItemBean.dart';
import 'package:gank_flutter/utils/constants.dart';
import 'dart:convert';

part 'DailyDataBean.g.dart';

@JsonSerializable()
class DailyDataBean {
  @JsonKey(name: GankType.TYPE_ANDROID)
  List<GankItemBean> androidDataList;
  @JsonKey(name: GankType.TYPE_IOS)
  List<GankItemBean> iosGDataList;
  @JsonKey(name: GankType.TYPE_WEB)
  List<GankItemBean> webDataList;
  @JsonKey(name: GankType.TYPE_APP)
  List<GankItemBean> appDataList;
  @JsonKey(name: GankType.TYPE_BENEFIT)
  List<GankItemBean> benefitDataList;
  @JsonKey(name: GankType.TYPE_REST_VIDEO)
  List<GankItemBean> restVideoDataList;
  @JsonKey(name: GankType.TYPE_EXPAND_RES)
  List<GankItemBean> expandResDataList;
  @JsonKey(name: GankType.TYPE_RECOMMEND)
  List<GankItemBean> recommendDataList;

  DailyDataBean(this.androidDataList,this.appDataList,this.iosGDataList,this.restVideoDataList,
      this.webDataList,this.expandResDataList,
      this.recommendDataList,this.benefitDataList);
  factory DailyDataBean.fromJson(Map<String, dynamic> json) => _$DailyDataBeanFromJson(json);
  Map<String, dynamic> toJson() => _$DailyDataBeanToJson(this);
}