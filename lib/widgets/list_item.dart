import 'package:flutter/material.dart';
import 'package:gank_flutter/model/GankItemBean.dart';
import 'package:gank_flutter/utils/log_utils.dart';
import 'package:gank_flutter/utils/constants.dart';

// 这里要用 StatefulWidget，解决 onTap 跳转无法获取 context 的问题

class ListItem extends StatefulWidget {
  GankItemBean _data;
  bool _showType = false;

  ListItem(this._data, this._showType);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ListItemState(_data,_showType);
  }

}

class ListItemState extends State<ListItem> {
  static const String TAG = "Gank";
  GankItemBean _data;
  bool _showType = false;

  ListItemState(this._data,this._showType);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              height: 80,
              padding: const EdgeInsets.only(left:12,top:12,right: 12,bottom: 8),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    _data.desc,
                    maxLines: 2,
                    overflow:TextOverflow.ellipsis, // 显示不完，就在后面显示3个点
                    style: TextStyle(
                      fontSize:15,
                      color:Color(0xff212121),
                    ),
                  ),
                  new Expanded(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Visibility(
                          visible: _showType == true,
                            child: new Row(
                              children: <Widget>[
                                new Padding(
                                  padding: new EdgeInsets.only(left:0,top:0,right:3,bottom:0),
                                  child: new Image.asset(
                                    "images/ic_content_type.png",
                                    width: 14,
                                  ),
                                ),
                                new Text(
                                    _data.type,
                                    style: TextStyle(
                                      fontSize:11,
                                      color:Color(0x44000000),
                                    )
                                ),
                                new Padding(padding: new EdgeInsets.only(left:0,top:0,right:6,bottom:0),)
                              ],
                            )
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(left:0,top:0,right:3,bottom:0),
                          child: new Image.asset(
                            "images/ic_content_from.png",
                            width: 14,
                          ),
                        ),
                        new Text(
                            _data.who,
                            style: TextStyle(
                              fontSize:11,
                              color:Color(0x44000000),
                            )
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(left:6,top:0,right:3,bottom:0),
                          child: new Image.asset(
                            "images/ic_content_time.png",
                            width: 14,
                          ),
                        ),
                        new Text(
                            formatPublishedTime(DateTime.parse(_data.publishedAt)),
                            style: TextStyle(
                              fontSize:11,
                              color:Color(0x44000000),
                            )
                        )
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            new Divider(
                height: 1,
                color: Color(0xffdddddd)
            )
          ],
        ),

      ),
      onTap: _onClickItem,
    );
  }

  void _onClickItem() {
    LogUtils.e(TAG, "on click ");
    Navigator.of(context).pushNamed(Page.PAGE_DETAILS,arguments: _data);
  }

  String formatPublishedTime(DateTime date) {
    DateTime curDate = new DateTime.now();
    Duration diff = curDate.difference(date);

    if (diff.inDays > 0) {
      if (diff.inDays > 365) {
        int year = diff.inDays ~/ 365;
        return year.toString() + "年前";
      }else if (diff.inDays > 31) {
        int month = diff.inDays ~/ 31;
        return month.toString() + "个月前";
      }
      return diff.inDays.toString() + "天前";
    } else if (diff.inHours > 0) {
      return diff.inHours.toString() + "小时前";
    } else if (diff.inMinutes > 0) {
      return diff.inMinutes.toString() + "分钟前";
    } else if (diff.inSeconds > 0) {
      return "刚刚";
    }
    return date.toString();
  }

}