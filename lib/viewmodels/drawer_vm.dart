import 'article_link_model.dart';

class DrawerVM {
  final List<ArticleLinkModel> articleLinks;
  final ArticleLinkModel parentLink;

  DrawerVM({
    this.articleLinks,
    this.parentLink,
  });
}