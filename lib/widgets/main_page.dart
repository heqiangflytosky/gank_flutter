import 'package:flutter/material.dart';
import 'package:gank_flutter/widgets/home_page.dart';
import 'package:gank_flutter/utils/log_utils.dart';
import 'package:gank_flutter/widgets/mine_page.dart';

class MainPageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }

}

class MainPageState extends State<MainPageWidget> {
  var _tabImage = [["images/tab_home_normal.png","images/tab_home.png"],
    ["images/tab_profile_normal.png","images/tab_profile.png"]];
  var _tabTitles = ["精选","我的"];
  int _curBottomTabIndex = 0;
  PageController _pageController = new PageController();


  @override
  void initState() {
    super.initState();
    //_pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _getBodyView(),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[new BottomNavigationBarItem(icon: _getTabIcon(0),title:_getTabTitle(0)),
          new BottomNavigationBarItem(icon: _getTabIcon(1),title:_getTabTitle(1))],
        currentIndex: _curBottomTabIndex,
        elevation: 4,
        selectedFontSize:12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  Widget _getBodyView() {
    return new PageView(
      children: <Widget>[new HomePageWidget(),new MinePageWidget()],
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), // 禁止滑动
      onPageChanged: (int index) {
        setState(() {
          _curBottomTabIndex = index;
        });
      },
    );
    /*
    switch(_curBottomTabIndex) {
      case 0:
        if (_homeWidget == null) {
          _homeWidget = new HomePageWidget();
        }
        return _homeWidget;
      case 1:
        if (_aboutWidget == null) {
          _aboutWidget = new Text("Test");
        }
        return _aboutWidget;
    }
    */
  }

  String _getTabIconPath(int curIndex) {
    if (curIndex == _curBottomTabIndex) {
      return _tabImage[curIndex][1];
    }
    return _tabImage[curIndex][0];
  }

  Image _getTabIcon(int index) {
    return new Image.asset(_getTabIconPath(index), width: 24.0, height: 24.0);
  }

  Text _getTabTitle(int index) {
    return new Text(_tabTitles.elementAt(index));
  }


}