import 'package:flutter/material.dart';
import 'package:gank_flutter/utils/constants.dart';
import 'package:gank_flutter/utils/log_utils.dart';
import 'package:gank_flutter/widgets/category_list.dart';
import 'package:gank_flutter/widgets/daily_list.dart';

class HomePageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageStage();
  }
}

class HomePageStage extends State<HomePageWidget> with SingleTickerProviderStateMixin {
  var _tabs = <String>[TabTitle.CATEGORY_DAILY,TabTitle.CATEGORY_ANDROID,TabTitle.CATEGORY_IOS,
    TabTitle.CATEGORY_WEB,TabTitle.CATEGORY_APP,TabTitle.CATEGORY_EXPAND_RES];
  TabController _controller;// DefaultTabController

  @override
  void initState() {
    _controller = new TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(
          child: new AppBar(
            bottom: new TabBar(
              controller: _controller,
              tabs: _tabs.map((String tab){
                return new Tab(
                  text: tab,
                );
              }).toList(),
              isScrollable: true,
            ),
          ),
          preferredSize: Size.fromHeight(48)
      ),
      body: new TabBarView(
        controller: _controller,
        children: _tabs.map((String tab){
          LogUtils.e("Test", "tab = "+tab);
          if (tab == TabTitle.CATEGORY_DAILY) {
            return new DailyList();
          } else {
            return new CategoryList(tab);
          }
        }).toList(),
      ),
    );
  }

}