import 'dart:convert';

NewsResponse newsResponseFromJson(String str) =>
    NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  List<News>? news;

  NewsResponse({
    this.news,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        news: json["news"] == null
            ? []
            : List<News>.from(json["news"]!.map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "news": news == null
            ? []
            : List<dynamic>.from(news!.map((x) => x.toJson())),
      };
}

class News {
  String? id;
  String? title;
  String? content;
  String? imageUrl;
  List<String>? categories;
  Author? author;
  dynamic hospitalId;
  String? createdAt;
  String? updatedAt;

  News({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.categories,
    this.author,
    this.hospitalId,
    this.createdAt,
    this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        imageUrl: json["imageUrl"],
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"]!.map((x) => x)),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        hospitalId: json["hospitalId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "imageUrl": imageUrl,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "author": author?.toJson(),
        "hospitalId": hospitalId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Author {
  String? name;
  String? avatarUrl;

  Author({
    this.name,
    this.avatarUrl,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "avatarUrl": avatarUrl,
      };
}
