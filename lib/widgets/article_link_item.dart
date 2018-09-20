import 'package:flutter/material.dart';

class ArticleLinkItem extends StatelessWidget {
  final String url;
  final String titleTxt;

  ArticleLinkItem({
    Key key,
    this.url,
    this.titleTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(5.0),
      title: Text(titleTxt, style: TextStyle(color: Colors.blue),),
      onTap: () {
        print("$url");
      }
    );
  }


}