class news {
  int timestamp;
  int articleCount;
  List<Articles> articles;

  news({this.timestamp, this.articleCount, this.articles});

  news.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    articleCount = json['articleCount'];
    if (json['articles'] != null) {
      articles = new List<Articles>();
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['articleCount'] = this.articleCount;
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  String title;
  String description;
  String url;
  Null image;
  String publishedAt;
  Source source;

  Articles(
      {this.title,
      this.description,
      this.url,
      this.image,
      this.publishedAt,
      this.source});

  Articles.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    image = json['image'];
    publishedAt = json['publishedAt'];
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['image'] = this.image;
    data['publishedAt'] = this.publishedAt;
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    return data;
  }
}

class Source {
  String name;
  String url;

  Source({this.name, this.url});

  Source.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}