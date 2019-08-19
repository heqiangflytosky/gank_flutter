import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/model/TodayBean.dart';
import 'package:gank_flutter/network/request.dart';
import 'package:gank_flutter/model/DailyDataBean.dart';
import 'package:gank_flutter/widgets/list_item.dart';
import 'package:gank_flutter/utils/state_load.dart';
import 'package:gank_flutter/model/GankItem.dart';
import 'package:gank_flutter/model/GankItemBean.dart';
import 'package:gank_flutter/widgets/list_head_item.dart';
import 'package:gank_flutter/widgets/list_image_item.dart';
import 'package:gank_flutter/utils/constants.dart';
import 'package:gank_flutter/widgets/loading.dart';
import 'package:gank_flutter/widgets/error.dart';
import 'package:gank_flutter/utils/log_utils.dart';

class DailyList extends StatefulWidget {
  static final String TAG = "Gank";
  @override
  State<StatefulWidget> createState() {
    return new DailyListState();
  }

}

class DailyListState extends State<DailyList>  with AutomaticKeepAliveClientMixin{

  var _listData = <GankItem>[];
  LOAD_STATE _state;
  CancelToken _cancelToken = new CancelToken();

  @override
  void initState() {
    super.initState();
    _state = LOAD_STATE.STATE_LOADING;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_listData.length == 0) {
      if (_state == LOAD_STATE.STATE_LOADING) {
        return new LoadingWidget();
      } else if (_state == LOAD_STATE.STATE_ERROR) {
        return new GankErrorWidget(
          reload: (){
            setState(() {
              _state = LOAD_STATE.STATE_LOADING;
              _getData();
            });
          },
        );
      }
    } else {
      return new RefreshIndicator(
          child: _buildListView(context),
          onRefresh: _getNewData
      );
    }
    return null;
  }


  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel("daily get cancel");
  }

  // implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;

  Widget _buildListView(BuildContext context){
    return new ListView.builder(
        itemCount: _listData.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          GankItem item = _listData[i];
          if (item is GankContentItem) {
            return new ListItem(item.data,false);
          } else if (item is GankHeaderItem) {
            return new ListHeadItem(item.title, item.imageUrl);
          } else if (item is GankImageItem) {
            return new ListImageItem(item.imageUrl);
          }
          return new Text("未知类型");
        }
    );
  }

  Future<Null> _getNewData() async {

    return null;
  }

  _getData () async{
    TodayBean data = await Request.getInstance().getGankToday(_cancelToken);
    if (data != null && data.error == false && data.results != null) {
      DailyDataBean bean = data.results;
      setState(() {
        List<GankItemBean> benefit = bean.benefitDataList;
        int maxContent = 5;
        if (benefit != null && benefit.length > 0) {
          _listData.add(new GankHeaderItem(GankType.TYPE_BENEFIT, _getIconUrl(GankType.TYPE_BENEFIT)));
          _listData.add(new GankImageItem(benefit.elementAt(0).url));
        }

        List<GankItemBean> android = bean.androidDataList;
        if (android != null && android.length > 0) {
          _listData.add(new GankHeaderItem(GankType.TYPE_ANDROID, _getIconUrl(GankType.TYPE_ANDROID)));
          int max = android.length < maxContent ? android.length : maxContent;
          for(int i = 0;i<max;i++) {
            _listData.add(new GankContentItem(android.elementAt(i)));
          }
        }

        List<GankItemBean> ios = bean.iosGDataList;
        if (ios != null && ios.length > 0) {
          _listData.add(new GankHeaderItem(GankType.TYPE_IOS, _getIconUrl(GankType.TYPE_IOS)));
          int max = ios.length < maxContent ? ios.length : maxContent;
          for(int i = 0;i<max;i++) {
            _listData.add(new GankContentItem(ios.elementAt(i)));
          }
        }

        List<GankItemBean> web = bean.webDataList;
        if (web != null && web.length > 0) {
          _listData.add(new GankHeaderItem(GankType.TYPE_WEB, _getIconUrl(GankType.TYPE_WEB)));
          int max = web.length < maxContent ? web.length : maxContent;
          for(int i = 0;i<max;i++) {
            _listData.add(new GankContentItem(web.elementAt(i)));
          }
        }

        List<GankItemBean> app = bean.appDataList;
        if (app != null && app.length > 0) {
          _listData.add(new GankHeaderItem(GankType.TYPE_APP, _getIconUrl(GankType.TYPE_APP)));
          int max = app.length < maxContent ? app.length : maxContent;
          for(int i = 0;i<max;i++) {
            _listData.add(new GankContentItem(app.elementAt(i)));
          }
        }

        List<GankItemBean> video = bean.restVideoDataList;
        if (video != null && video.length > 0) {
          _listData.add(new GankHeaderItem(GankType.TYPE_REST_VIDEO, _getIconUrl(GankType.TYPE_REST_VIDEO)));
          int max = video.length < maxContent ? video.length : maxContent;
          for(int i = 0;i<max;i++) {
            _listData.add(new GankContentItem(video.elementAt(i)));
          }
        }

        List<GankItemBean> res = bean.expandResDataList;
        if (res != null && res.length > 0) {
          _listData.add(new GankHeaderItem(GankType.TYPE_EXPAND_RES, _getIconUrl(GankType.TYPE_EXPAND_RES)));
          int max = res.length < maxContent ? res.length : maxContent;
          for(int i = 0;i<max;i++) {
            _listData.add(new GankContentItem(res.elementAt(i)));
          }
        }

        List<GankItemBean> recommend = bean.recommendDataList;
        if (recommend != null && recommend.length > 0) {
          _listData.add(new GankHeaderItem(GankType.TYPE_RECOMMEND, _getIconUrl(GankType.TYPE_RECOMMEND)));
          int max = recommend.length < maxContent ? recommend.length : maxContent;
          for(int i = 0;i<max;i++) {
            _listData.add(new GankContentItem(recommend.elementAt(i)));
          }
        }

      });
    } else {
      if (_listData.length == 0) {
        setState(() {
          _state = LOAD_STATE.STATE_ERROR;
        });
      }
    }
  }

  String _getIconUrl(String type){
    String url;
    switch (type) {
      case GankType.TYPE_ANDROID:
        url = "images/ic-title-android.png";
        break;
      case GankType.TYPE_BENEFIT:
        url = "images/ic-title-benefit.png";
        break;
      case GankType.TYPE_IOS:
        url = "images/ic-title-ios.png";
        break;
      case GankType.TYPE_WEB:
        url = "images/ic-title-app.png";
        break;
      case GankType.TYPE_APP:
        url = "images/ic-title-app.png";
        break;
      case GankType.TYPE_REST_VIDEO:
        url = "images/ic-title-video.png";
        break;
      case GankType.TYPE_EXPAND_RES:
        url = "images/ic-title-res.png";
        break;
      case GankType.TYPE_RECOMMEND:
        url = "images/ic-title-recommand.png";
        break;
    }
    return url;

  }

}