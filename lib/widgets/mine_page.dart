
import 'package:flutter/material.dart';
import 'package:gank_flutter/persistence/db_helper.dart';


class MinePageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MinePageWidgetState();
  }

}

class MinePageWidgetState extends State<MinePageWidget> {
  int _favouriteSize ;
  int _historySize ;


  @override
  void initState() {
    super.initState();
    DateBaseHelper.getInstance().getFavouriteCount().then((int value){
      setState(() {
        _favouriteSize = value;
      });
    });
    DateBaseHelper.getInstance().getHistoryCount().then((int value){
      setState(() {
        _historySize = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _getBodyView(),
      appBar: new PreferredSize(
          child: AppBar(
            title: new Align(
              alignment: Alignment.center,
              child: new Text(
                "我的",
                style: new TextStyle(
                  fontSize: 16
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(48)
      ),
    );
  }

  Widget _getBodyView(){
    return new Container(
      padding: new EdgeInsets.only(left: 0,top:10,right: 0,bottom: 0),
      child: new Column(
        children: <Widget>[
          new Divider(
              height: 1,
              color: Color(0xffdddddd)
          ),
          new MineItem("images/user_favourite.png","我的收藏",_favouriteSize),
          new Divider(
              height: 1,
              color: Color(0xffdddddd)
          ),
          new MineItem("images/user_viewed.png","阅读过的文章",_historySize),
          new Divider(
              height: 1,
              color: Color(0xffdddddd)
          ),
          new Padding(
              padding: new EdgeInsets.only(left: 0,top:20,right: 0,bottom: 0),
          ),
          new Divider(
              height: 1,
              color: Color(0xffdddddd)
          ),
          new MineItem("images/user_about_author.png","关于我们",null),
          new Divider(
              height: 1,
              color: Color(0xffdddddd)
          ),
        ],
      ),
    );
  }

}

class MineItem extends StatelessWidget{
  String _iconPath;
  int _size;
  String _title;

  MineItem(this._iconPath,this._title,this._size);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: new Color(0xffffffff),
      padding: new EdgeInsets.only(left: 20,top:0,right: 20,bottom: 0),
        child: new Row(
          children: <Widget>[
            new Image.asset(
              _iconPath,
              width: 22,
            ),
            new Padding(
                padding: new EdgeInsets.only(left: 20,top:0,right: 0,bottom: 0),
            ),
            new Text(
              _title,
              style: new TextStyle(
                fontSize: 16,
                color: new Color(0xff000000)
              ),
            ),
            new Expanded(
              child: new Align(
                alignment: Alignment.centerRight,
                child: new Offstage(
                  offstage: _size == null,
                  child: new Text(
                      (_size != null ? _size.toString() : "")+" 篇",
                    style: new TextStyle(
                      fontSize: 14,
                      color: new Color(0xffcacaca),
                    ),
                  ),
                ),
              ),
              flex: 1,
            ),
          ],
        ),
        height: 52
    );
  }

}