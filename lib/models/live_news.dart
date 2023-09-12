class LiveNews {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  LiveNews({this.status, this.totalResults, this.articles});

  LiveNews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  String? title;
  String? author;
  Source? source;
  String? publishedAt;
  String? url;

  Articles({this.title, this.author, this.source, this.publishedAt, this.url});

  Articles.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    source =
    json['source'] != null ? new Source.fromJson(json['source']) : null;
    publishedAt = json['publishedAt'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    data['publishedAt'] = this.publishedAt;
    data['url'] = this.url;
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}