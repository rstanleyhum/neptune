import 'package:flutter/material.dart';

import '../blocs/article_bloc.dart';

class ArticleProvider extends InheritedWidget {
  final ArticleBloc articleBloc;

  const ArticleProvider({
    Key key,
    @required this.articleBloc,
    @required Widget child,
  }) : super(key: key, child: child);

  static ArticleBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ArticleProvider) as ArticleProvider).articleBloc;
  }

  @override
  bool updateShouldNotify(ArticleProvider old) => articleBloc != old.articleBloc;
}