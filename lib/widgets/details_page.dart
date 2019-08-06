import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// WebviewScaffold 这里必须用 StatefulWidget
class DetailsPage extends StatefulWidget{
  String _title;
  String _url;
  DetailsPage(this._title,this._url);

  @override
  State<StatefulWidget> createState() {
    return new DetailsPageSate(_title, _url);
  }
}

class DetailsPageSate extends State<DetailsPage> {
  String _title;
  String _url;

  DetailsPageSate(this._title, this._url);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: _url,
      withZoom: false,
      withJavascript: true,
      withLocalStorage: true,
      appBar: new PreferredSize(
          child: new AppBar(
            title: new Text(_title),
          ),
          preferredSize: Size.fromHeight(48)
      ),
    );
  }

}