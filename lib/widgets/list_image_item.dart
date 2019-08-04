import 'package:flutter/material.dart';

class ListImageItem extends StatelessWidget{
  String _url;
  ListImageItem(String url) {
    _url = url;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Image.network(
      _url,
      height: 300,
    );
  }

}