import 'package:flutter/material.dart';

import 'blocs/ui_bloc.dart';
import 'blocs/article_bloc.dart';

import 'providers/article_provider.dart';
import 'providers/ui_provider.dart';

import 'widgets/material_base.dart';


class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ArticleProvider(
      articleBloc: ArticleBloc(),
      child: UIProvider(
        uiBloc: UIBloc(),
        child: MaterialBase(),
      ),
    );
  }
}
