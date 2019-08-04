import 'package:flutter/material.dart';
import 'widgets/home_page.dart';

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
        body: HomePageWidget(),
        //floatingActionButton: new FloatingActionButton(onPressed: test),
      )
    );
  }
}