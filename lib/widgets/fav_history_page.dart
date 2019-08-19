import 'package:flutter/material.dart';
import 'package:gank_flutter/persistence/db_helper.dart';
import 'package:gank_flutter/widgets/list_item.dart';
import 'package:gank_flutter/model/GankItemBean.dart';

class FavHisWidget extends StatefulWidget {
  PAGE_TYPE _page_type;

  FavHisWidget(this._page_type);

  @override
  State<StatefulWidget> createState() {
    return new FavHisState(_page_type);
  }
  
}

class FavHisState extends State<FavHisWidget> {
  PAGE_TYPE _page_type;
  List _data = new List();

  FavHisState(this._page_type);


  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(getTitle()),
      ),
      body: _getBody(),

    );
  }


  Widget _getBody() {
    return new ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context,i) {
        return new ListItem(DateBaseHelper.getInstance().toGankBean(_data[i]), true);
      }
    );
  }

  String getTitle() {
    if (_page_type == PAGE_TYPE.FAVOURITE) {
      return "我的收藏";
    } else if (_page_type == PAGE_TYPE.HISTORY) {
      return "阅读过的文章";
    }
    return "";
  }

  _getData(){
    _get().then((List list){
      if (list != null && list.length > 0) {
        setState(() {
          _data.addAll(list);
        });
      }
    });

  }

  Future<List> _get() {
    if (_page_type == PAGE_TYPE.FAVOURITE) {
      return DateBaseHelper.getInstance().getFavourites();
    } else {
      return DateBaseHelper.getInstance().getHistories();
    }
  }

}

enum PAGE_TYPE {
  FAVOURITE,
  HISTORY
}