import 'package:flutter/material.dart';

import '../providers/article_provider.dart';

class TestPage extends StatelessWidget {
  final int number;

  TestPage({
    Key key,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleBloc = ArticleProvider.of(context);
    return Container(
      child: Column(
        children: <Widget>[
          Text("Test Page $number"),
          StreamBuilder<bool>(
            stream: articleBloc.isLoading,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Loading ..."),
                  ]
                );
              }
              return Container();
            },
          ),
          StreamBuilder<bool>(
            stream: articleBloc.isLoaded,
            initialData: false,
            builder: (context, snapshot) {
              return Text("Loaded: ${snapshot.data}");
            },
          ),
        ],
      ),
    );
  }
}
