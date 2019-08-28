import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gank_flutter/utils/log_utils.dart';
import 'package:gank_flutter/model/GankItemBean.dart';
import 'package:gank_flutter/persistence/db_helper.dart';


// WebviewScaffold 这里必须用 StatefulWidget
class DetailsPage extends StatefulWidget{
  GankItemBean _data;
  DetailsPage(this._data);

  @override
  State<StatefulWidget> createState() {
    return new DetailsPageSate();
  }
}

class DetailsPageSate extends State<DetailsPage> {
  final _plugin = new FlutterWebviewPlugin();
  GankItemBean _data;

  @override
  void initState() {
    super.initState();
    _data = widget._data;
    DateBaseHelper.getInstance().addHistory(_data);
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
        url: _data.url,
        withZoom: false,
        withJavascript: true,
        withLocalStorage: true,
        appBar: new PreferredSize(
            child: new AppBar(
              title: new Text(_data.desc),
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.refresh, color: new Color(0xffffffff),),
                    onPressed: _onRefresh)
              ],
            ),
            preferredSize: Size.fromHeight(48)
        ),
        bottomNavigationBar: new BottomBar(_data)
    );
  }
//new BottomNavigationBar(items: [new BottomNavigationBarItem(icon: new Icon(Icons.refresh),title: new Text("111")),new BottomNavigationBarItem(icon: new Icon(Icons.refresh),title: new Text("111"))]),
  _onRefresh() {
    _plugin.reload();
  }
}

class BottomBar extends StatefulWidget{
  GankItemBean _data;
  BottomBar(this._data);
  @override
  State<StatefulWidget> createState() {
    return new BottomBarState(_data);
  }
}


class BottomBarState extends State<BottomBar> {
  GankItemBean _data;
  bool _isFavourite;
  BottomBarState(this._data);


  @override
  void initState() {
    super.initState();
    _isFavourite = false;
    _updateFavouriteState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 49,
      child: new Column(
        children: <Widget>[
          new Divider(
            height: 1,
            color: Color(0xffdddddd)
          ),
          new Row(
            children: <Widget>[
              new IconButton(
                icon: Image.asset(_getFavouriteIconPath(),width: 26, height: 26,),
                onPressed: _onFavouritePressed,
              ),
              new IconButton(
                  icon: Image.asset("images/ic_action_share.png",width: 26, height: 26,),
                  onPressed: _onSharePressed
              ),
              new Expanded(
                child: new Container(height: 48),
                flex: 1,
              ),
              new Text(
                "推荐者："+_data.who,
                style: new TextStyle(
                    color: new Color(0xffa8b2bd),
                    fontSize:14
                ),),
              new Padding(padding: new EdgeInsets.only(left:0,top:0,right:15,bottom:0),)
            ],
          )
        ],
      ),
    );
  }

  _onFavouritePressed() {
    DateBaseHelper.getInstance().saveFavourite(_data).then((int value) {
      LogUtils.e("Test", "2222");
      setState(() {
        _isFavourite = !_isFavourite;

      });
    });
    LogUtils.e("Test", "1111");
  }

  _onSharePressed() {

  }

  _updateFavouriteState() {
    DateBaseHelper.getInstance().hasFavouriteEntry(_data).then((bool value){
      if (value) {
        _isFavourite = value;
      }
    });
  }

  String _getFavouriteIconPath() {
    if (_isFavourite) {
      return "images/ic_action_favorite.png";
    } else {
      return "images/ic_action_favorite_outline_gray.png";
    }
  }

}