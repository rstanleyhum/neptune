
class ArticleLinkModel {
  String key;
  String title;
  String intro;

  ArticleLinkModel({
    this.key,
    this.title,
    this.intro,
  });
}

class ArticleModel {
  String key;
  String title;
  String date;
  String byline;
  String mdcontent;
  List<ArticleLinkModel> related;

  ArticleModel({
    this.key,
    this.title,
    this.date,
    this.byline,
    this.mdcontent,
    this.related,
  });
}

class ArticlePayloadModel {
  final List<ArticleModel> articles;
  final int index;

  ArticlePayloadModel({
    this.articles,
    this.index,
  });
}