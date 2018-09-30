class ArticleLinkModel {
  String key;
  String title;
  String intro;

  ArticleLinkModel({
    this.key,
    this.title,
    this.intro,
  });

  @override
  String toString() {
    return "ArticleLinkModel: {key: $key, title: $title}";
  }
}