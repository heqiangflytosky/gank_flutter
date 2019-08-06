import 'package:flutter/material.dart';


class GankErrorWidget extends StatelessWidget {

  GankErrorWidget ({this.reload});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      child: new Center(
        child: Text(
          "加载失败，点击重试",
        ),
      ),
      onTap: reload,
    );
  }

  void Function() reload;

}