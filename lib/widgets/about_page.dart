import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("关于我们"),
      ),
      body: new Container(
        padding: EdgeInsets.all(10),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new HeaderText("简介"),
            new ContentText("每日分享技术干货和妹子图，还有供大家中午休息的休闲视频"),
            new LinkText("数据来源： http://gank.io/api"),
            new LinkText("项目源码： https://github.com/heqiangflytosky/GankTouTiao"),
            new HeaderText("开发者"),
            new LinkText("个人主页: http://www.heqiangfly.com"),
            new LinkText("CSDN: http://blog.csdn.net/heqiangflytosky"),
            new LinkText("GitHub: https://github.com/heqiangflytosky"),
          ],
        ),
      )
    );
  }

}

class HeaderText extends StatelessWidget{
  String title;

  HeaderText(this.title);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 0,top: 10,right: 0,bottom: 5),
      child: new Text(
        title,
        style: TextStyle(
          fontSize:16,
          color:Color(0xff000000),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}

class ContentText extends StatelessWidget{
  String title;

  ContentText(this.title);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 0,top: 2,right: 0,bottom: 3),
      child: new Text(
        title,
        style: TextStyle(
          fontSize:14,
          color:Color(0xaa000000),
        ),
      ),
    );
  }

}

class LinkText extends StatelessWidget{
  String title;

  LinkText(this.title);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 0,top: 2,right: 0,bottom: 3),
      child: new Linkify(
        text: title,
        style: TextStyle(
          fontSize:14,
          color:Color(0xaa000000),
        ),
        onOpen: (url) => _openUrl(url),
      ),
    );
  }

  _openUrl(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

}

