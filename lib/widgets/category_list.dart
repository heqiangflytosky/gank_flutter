import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/utils/log_utils.dart';
import 'package:gank_flutter/model/GankItemBean.dart';
import 'package:gank_flutter/network/request.dart';
import 'package:gank_flutter/model/CategoryBean.dart';
import 'package:gank_flutter/widgets/list_item.dart';
import 'package:gank_flutter/utils/state_load.dart';

class CategoryList extends StatefulWidget {
  static final String TAG = "Gank";
  String _categort;

  CategoryList(String type) {
    LogUtils.d(TAG,"CategoryList type = "+type);
    _categort = type;
  }

  @override
  State<StatefulWidget> createState() {
    return new CateGoryListState(_categort);
  }

}

class CateGoryListState extends State<CategoryList> with AutomaticKeepAliveClientMixin{
  var _listData = <GankItemBean>[];
  final ScrollController _scrollController = ScrollController();
  CancelToken _cancelToken = new CancelToken();
  String _type;
  int _pageSize = 0;

  LOAD_STATE _state;

  CateGoryListState(String type){
    _type = type;
  }


  @override
  void initState() {
    super.initState();
    _state = LOAD_STATE.STATE_LOADING;
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _getMoreDate(_pageSize +1);
      }
    });
    _getMoreDate(_pageSize +1);
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel("CateGoryList cancel");
  }

  // implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_listData.length == 0) {
      if (_state == LOAD_STATE.STATE_LOADING) {
        return new Center(
          child: Text("正在加载"),
        );
      } else if (_state == LOAD_STATE.STATE_ERROR) {
        return new Center(
          child: Text("加载失败，点击重试"),
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

  Widget _buildListView(BuildContext context){
    return new ListView.builder(
        controller: _scrollController,
        itemCount: _listData.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return new ListItem(_listData[i]);
        }
    );
  }

  _getMoreDate(int page) async {
    LogUtils.e(CategoryList.TAG, "get more date "+page.toString()+" page");
    int current = page;
    CategoryBean data = await Request.getInstance().getGankCategoryData(_type, page,_cancelToken);
    if (data != null && data.error == false) {
      setState(() {
        _state = LOAD_STATE.STATE_SUCCESS;
        _listData.addAll(data.results);
        _pageSize  = current;
      });
    } else {
      if (_listData.length == 0) {
        setState(() {
          _state = LOAD_STATE.STATE_ERROR;
        });
      }
    }
  }

  Future<Null> _getNewData() async {
    CategoryBean data = await Request.getInstance().getGankCategoryData(_type, 1,_cancelToken);
    return null;
  }

}