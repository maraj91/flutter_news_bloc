class NewsListMain {
  NewsListMain({
    required this.status,
    required this.message,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final String message;
  final int totalResults;
  final List<Article> articles;

  factory NewsListMain.fromJson(Map<String, dynamic> json){
    return NewsListMain(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      totalResults: json["totalResults"] ?? 0,
      articles: json["articles"] == null ? [] : List<Article>.from(json["articles"]!.map((x) => Article.fromJson(x))),
    );
  }

}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source? source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime? publishedAt;
  final String content;

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      source: json["source"] == null ? null : Source.fromJson(json["source"]),
      author: json["author"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
      content: json["content"] ?? "",
    );
  }

}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Source.fromJson(Map<String, dynamic> json){
    return Source(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}