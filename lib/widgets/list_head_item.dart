import 'package:flutter/material.dart';

class ListHeadItem extends StatelessWidget {
  String _title;
  String _imageUrl;

  ListHeadItem(String title, String url) {
    _title = title;
    _imageUrl = url;
  }
  @override
  Widget build(BuildContext context) {
    return  new Container(
        color: Color(0xffefefef),
        child:new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(left:12,top:12,right: 12,bottom: 8),
              child: new Row(
                children: <Widget>[
                  new Image.asset(
                    _imageUrl,
                    width: 14,
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(2),
                  ),
                  new Text(
                      _title,
                      style: TextStyle(
                          fontSize:14,
                          color:Color(0xff000000),
                          fontWeight: FontWeight.bold
                      )
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
    );



  }

}