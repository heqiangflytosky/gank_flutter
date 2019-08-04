
import 'package:gank_flutter/utils/log_utils.dart';
import 'package:gank_flutter/model/TodayBean.dart';
import 'package:gank_flutter/model/CategoryBean.dart';

import 'package:dio/dio.dart';
import 'api.dart';

class Request{
  static final String TAG = "Gank";
  Dio dio;
  static Request _request;
  Request._() {
    dio = new Dio();
    dio.options.baseUrl = Api.gank_base_url;
    dio.options.connectTimeout = 5000;
    dio.options.responseType = ResponseType.json;

    LogUtils.e(TAG, "Request");
  }

  static Request getInstance() {
    if (_request == null) {
      _request = new Request._();
    }
    return _request;
  }

  getGankToday(CancelToken cancelToken) async {
    LogUtils.e(TAG, "getGankToday");
    TodayBean bean;
    try {
      Response response = await dio.get(Api.gank_today,cancelToken: cancelToken);
      LogUtils.e(TAG, "string = "+response.data.toString());
      bean = TodayBean.fromJson(response.data);
      LogUtils.e(TAG, "object = "+bean.toString());
    } on DioError catch(e){
      LogUtils.e(TAG, e.toString());
    } on FormatException catch(e) {
      LogUtils.e(TAG, e.toString());
    }
    return bean;
  }

  getGankCategoryData(String category, int page,CancelToken cancelToken) async {
    LogUtils.e(TAG, "getGankCategoryData");
    CategoryBean bean;
    try {
      Response response = await dio.get(Api.gank_data+"/"+category+'/20/'+page.toString(),cancelToken: cancelToken);
      LogUtils.e(TAG, "string = "+response.data.toString());
      bean = CategoryBean.fromJson(response.data);
      LogUtils.e(TAG, "object = "+bean.toString());
    } on DioError catch(e){
      LogUtils.e(TAG, e.toString());
    } on FormatException catch(e) {
      LogUtils.e(TAG, e.toString());
    }

    return bean;
  }

}