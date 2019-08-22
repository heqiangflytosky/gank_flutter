import 'package:flutter/material.dart';
import 'widgets/main_page.dart';
import 'utils/constants.dart';
import 'widgets/details_page.dart';
import 'widgets/fav_history_page.dart';
import 'widgets/about_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        body: MainPageWidget(),
        //floatingActionButton: new FloatingActionButton(onPressed: test),
      ),
      routes: {
        Page.PAGE_DETAILS:(context) {
          return new DetailsPage(ModalRoute.of(context).settings.arguments);
        },
        Page.PAGE_FAV_HISTORY:(context) {
          return new FavHisWidget(ModalRoute.of(context).settings.arguments);
        },
        Page.PAGE_ABOUT:(context) => AboutWidget(),
      },
    );
  }
}
