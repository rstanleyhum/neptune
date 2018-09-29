import 'article_payload.dart';

class DrawerVM {
  final List<ArticleLinkModel> articleLinks;
  final ArticleLinkModel parentLink;

  DrawerVM({
    this.articleLinks,
    this.parentLink,
  });
}